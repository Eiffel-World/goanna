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

create
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
			-- Generate a new secure session id
			-- TODO: make this secure	
		do
			current_random := current_random + 1
			Result := random.next_random (current_random).out
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
end -- class HTTP_SESSION_MANAGER
