indexing
	description: "Objects that manage HTTP sessions"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "HTTP Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>", "Neal Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	HTTP_SESSION_MANAGER

inherit
	
	DT_SHARED_SYSTEM_CLOCK
--		export
--			{NONE} all
--		end
		
creation
	make

feature -- Initialization

	make is
			-- Create a new session manager
		do
			create sessions.make (10)
		end
	
feature -- Access

	get_session (id: STRING): like session_anchor is
			-- Return the session with 'id'
		require
			id_exists: id /= Void
			has_session: has_session (id)
		do
			Result  := sessions.item (id)
			Result.touch
		end
				
feature -- Status report

	has_session (id: STRING): BOOLEAN is
			-- Does a session with 'id' exist?
		require
			id_exists: id /= Void			
		do
			expire_sessions
			Result  := sessions.has (id)
		end
	
	last_session_id: STRING
			-- Id of last session bound or touched.
			
feature -- Status setting

	bind_session (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- If the request does not already have a session, then create one.
			-- If the request includes the session id cookie then mark the session
			-- as old (ie, the client has accepted the session).
		local
			cookie: COOKIE
			session: like session_anchor
		do
			expire_sessions
			-- look for the session id cookie, if it exists the session will already exist so
			-- mark it as old and update its access time.
			create cookie.make (Session_cookie_name, "")
			debug ("session_management")
				print ("Binding session%R%N")
			end	
			req.cookies.start
			req.cookies.search_forth (cookie)
			if not req.cookies.off then
				cookie := req.cookies.item_for_iteration
				debug ("session_management")
					print ("Cookie value is: " + cookie.value + "%R%N")
				end	
				-- check for stale cookie
				if sessions.has (cookie.value) then
					debug ("session_management")
						print ("We have the cookie value%R%N")
					end	
					session := sessions.item (cookie.value)
					if session.is_new then
						session.set_old					
					end
					session.touch
					last_session_id := session.id	
				else
					debug ("session_management")
						print ("Creating session as we don't have the cookie value%R%N")
					end	
					create_new_session (resp)
				end
			else
				debug ("session_management")
					print ("Creating session as we can't find the cookie%R%N")
				end	
				create_new_session (resp)
			end
		end

	terminate is
			-- Application is shutting down.
		require
			True
		local
			session: like session_anchor
			key: STRING
		do
			-- Force-expire all sessions
			if sessions.count > 0 then
				from
					sessions.start
				until
					sessions.off
				loop
					session := sessions.item_for_iteration
					key := sessions.key_for_iteration
					notify_listeners (session, Expiring_code)
					sessions.remove (key)
					notify_listeners (session, Expired_code)
					if not sessions.off then sessions.forth end
				end
			end
		end
	
feature {NONE} -- Implementation

	session_anchor: HTTP_SESSION
			-- Session type anchor
			
	sessions: DS_HASH_TABLE [like session_anchor, STRING]
			-- Active sessions.

	Session_cookie_name: STRING is "GSESSIONID"
			-- Name of session cookie
			
	create_new_session (resp: HTTP_SERVLET_RESPONSE) is
			-- Create a new session and set the session cookie
		local
			session: like session_anchor
			cookie: COOKIE
		do
			last_session_id := generate_session_id
			create session.make (last_session_id)
			sessions.force (session, last_session_id)
			create cookie.make (Session_cookie_name, last_session_id)
			resp.add_cookie (cookie)
			notify_listeners (session, Created_code)
		end
	
	generate_session_id: STRING is
			-- Generate a new secure session id.
			-- Key is generated from a random number and the current date and time.
			-- TODO: make this secure
		local
			date: DT_DATE_TIME
			formatter: DATE_FORMATTER
		do
			-- Not using RANDOM because SmallEiffel has a different random
			-- class and I'm tired of building non-OO classes to support
			-- porting!
			--current_random := current_random + 1
			--Result := random.next_random (current_random).out
			create Result.make (15)
			date := system_clock.date_time_now
			create formatter
			Result.append (formatter.format_compact_sortable (date))
			Result := base64_encoder.encode (Result)
		ensure
			new_session_id_exists: Result /= Void
		end
	
	base64_encoder: BASE64_ENCODER is
			-- Base64 encoder
		once
			create Result
		end
	
--	random: RANDOM is
--			-- Random number generator
--		do
--			create Result.make
--		end
	
--	current_random: INTEGER
--			-- Current position in random number stream
		
	expire_sessions is
			-- Check all current sessions and expire if appropriate.
		local
			cursor: DS_HASH_TABLE_CURSOR [like session_anchor, STRING]
			session: like session_anchor
			expired_session: like session_anchor
			now, idle: DT_DATE_TIME
			expired_sessions: DS_LINKED_LIST [STRING]
		do
			now := system_clock.date_time_now
			create expired_sessions.make
			from
				cursor := sessions.new_cursor
				cursor.start
			until
				cursor.off
			loop
				-- check each session against the current time and collect in list
				-- if it needs expiring
				session := cursor.item
				idle := clone (session.last_accessed_time)
				idle.add_seconds (session.max_inactive_interval)
				if now > idle then
					-- expire session
					debug ("session_management")
						print ("Expiring session: " + cursor.key + "%R%N")
					end
					notify_listeners (cursor.item, Expiring_code)
					expired_sessions.force_last (cursor.key)
				end
				cursor.forth
			end
			-- remove all collected expired sessions
			from
				expired_sessions.start
			until
				expired_sessions.off
			loop
				expired_session := sessions.item (expired_sessions.item_for_iteration)
				sessions.remove (expired_sessions.item_for_iteration)
				notify_listeners (expired_session, Expired_code)
				expired_sessions.forth
			end
		end

feature  -- Listeners

	register_event_listener (listener: HTTP_SESSION_EVENT_LISTENER) is
				-- Register 'listener' to receive notification of
				-- session events.
		require
			listener_exists: listener /= Void
			listener_not_registered: not event_listener_registered (listener)
		do
			if listener_list = void then
				create listener_list.make
			end
			listener_list.force_last (listener)
		ensure
			listener_registered: event_listener_registered (listener)
		end

	unregister_event_listener (listener: HTTP_SESSION_EVENT_LISTENER) is
				-- Unregister 'listener' so that it does not receive session
				-- event notifications.
		require
			listener_exists: listener /= Void
			event_listener_registered: event_listener_registered (listener)
		do
			listener_list.delete (listener)
		ensure
			listener_unregistered: not event_listener_registered (listener)
		end

	event_listener_registered (listener: HTTP_SESSION_EVENT_LISTENER): BOOLEAN is
			-- listener is registered and will receive event notifications
		require
			listener_exists: listener /= Void
		do
			Result := listener_list /= Void and then listener_list.has (listener)
		end

feature {HTTP_SESSION} -- Attribute Binding Event Notification

	attribute_bound_notification (session: like session_anchor; name: STRING; attribute: ANY) is
			-- receive notification from session that an attribute was bound
		require
			session_exists: session /= Void
			name_exists: name /= Void
			attribute_exists: attribute /= Void
		do
			event_attribute_name := name
			event_attribute := attribute
			notify_listeners (session, Attribute_bound_code)
		end

	attribute_unbound_notification (session: like session_anchor; name: STRING; attribute: ANY) is
			-- Receive notification from session that an attribute was unbound
		require
			session_exists: session /= Void
			name_exists: name /= Void
			attribute_exists: attribute /= Void	
		do
			event_attribute_name := name
			event_attribute := attribute
			notify_listeners (session, Attribute_unbound_code)
		end			
	
feature {NONE} -- Listener implementation

	listener_list: DS_LINKED_LIST [HTTP_SESSION_EVENT_LISTENER]
			-- List of registered event listeners

	Expiring_code, Expired_code, Created_code, Attribute_bound_code, Attribute_unbound_code: INTEGER is unique
			-- Event codes

	notify_listeners (session: like session_anchor; event_code: INTEGER) is
			-- notify listeners that an event (signified by event_code) has occurerd for session
		require
			session_exists: session /= Void
			event_code_exists: event_code /= Void
			event_attribute_name_set: (equal (event_code, Attribute_bound_code) or equal (event_code, Attribute_unbound_code)) implies event_attribute_name /= Void
			event_attribute_set: (equal (event_code, Attribute_bound_code) or equal (event_code, Attribute_unbound_code)) implies event_attribute /= Void
		local
			listener_cursor: DS_LINKED_LIST_CURSOR [HTTP_SESSION_EVENT_LISTENER]
		do
			if listener_list /= void and then not listener_list.is_empty then
				create listener_cursor.make (listener_list)
				from
					listener_cursor.start
				until
					listener_cursor.after
				loop
					inspect event_code
					when attribute_bound_code then
						listener_cursor.item.attribute_bound (session, event_attribute_name, event_attribute)
					when attribute_unbound_code then
						listener_cursor.item.attribute_unbound (session, event_attribute_name, event_attribute)
					when expiring_code then
						listener_cursor.item.expiring (session)
					when expired_code then
						listener_cursor.item.expired (session)
					when created_code then
						listener_cursor.item.created (session)
					end
					listener_cursor.forth
				end
			end
			event_attribute_name := void
			event_attribute := void
		ensure
			event_attribute_name_void: event_attribute_name = void
			event_attribute_void: event_attribute = void
		end

	event_attribute_name: STRING
			-- Set if notifying of an attribute_bound/unbound event; otherwise void

	event_attribute: ANY
			-- Set if notifying of an attribute_bound/unbound event; otherwise void
			
end -- class HTTP_SESSION_MANAGER
