indexing
	description: "Objects that manage HTTP sessions"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "HTTP Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	HTTP_SESSION_MANAGER

creation
	make

feature -- Initialization

	make is
			-- Create a new session manager
		do
			create sessions.make (10)
		end
	
feature -- Access

	get_session (id: STRING): HTTP_SESSION is
			-- Return the session with 'id'
		require
			id_exists: id /= Void
			has_session: has_session (id)
		do
			Result := sessions.item (id)
			Result.touch
		end
				
feature -- Status report

	has_session (id: STRING): BOOLEAN is
			-- Does a session with 'id' exist?
		require
			id_exists: id /= Void			
		do
			expire_sessions
			Result := sessions.has (id)
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
			session: HTTP_SESSION
		do
			expire_sessions
			-- look for the session id cookie, if it exists the session will already exist so
			-- mark it as old and update its access time.
			create cookie.make (Session_cookie_name, "")
			req.cookies.start
			req.cookies.search_forth (cookie)
			if not req.cookies.off then
				cookie := req.cookies.item_for_iteration
				-- check for stale cookie
				if sessions.has (cookie.value) then
					session := sessions.item (cookie.value)
					if session.is_new then
						session.set_old					
					end
					session.touch
					last_session_id := session.id	
				else
					create_new_session (resp)
				end
			else
				create_new_session (resp)
			end
		end
	
feature {NONE} -- Implementation

	sessions: DS_HASH_TABLE [HTTP_SESSION, STRING]
			-- Active sessions.

	Session_cookie_name: STRING is "GSESSIONID"
			-- Name of session cookie
			
	create_new_session (resp: HTTP_SERVLET_RESPONSE) is
			-- Create a new session and set the session cookie
		local
			session: HTTP_SESSION
			cookie: COOKIE
		do
			last_session_id := generate_session_id
			create session.make (last_session_id)
			sessions.put (session, last_session_id)
			create cookie.make (Session_cookie_name, last_session_id)
			resp.add_cookie (cookie)
		end
	
	generate_session_id: STRING is
			-- Generate a new secure session id.
			-- Key is generated from a random number and the current date and time.
			-- TODO: make this secure
		local
			date: DATE_AND_TIME
			formatter: DATE_FORMATTER
		do
			current_random := current_random + 1
			Result := random.next_random (current_random).out
			create date.make_to_now
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
	
	random: RANDOM is
			-- Random number generator
		do
			create Result.make
		end
	
	current_random: INTEGER
			-- Current position in random number stream
		
	expire_sessions is
			-- Check all current sessions and expire if appropriate.
		local
			cursor: DS_HASH_TABLE_CURSOR [HTTP_SESSION, STRING]
			session: HTTP_SESSION
			now, idle: DATE_AND_TIME
			expired_sessions: DS_LINKED_LIST [STRING]
		do
			create now.make_to_now
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
				sessions.remove (expired_sessions.item_for_iteration)
				expired_sessions.forth
			end
		end
			
end -- class HTTP_SESSION_MANAGER
