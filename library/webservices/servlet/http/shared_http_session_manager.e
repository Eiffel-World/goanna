indexing
	description: "Singleton access for a HTTP_SESSION_MANAGER"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "HTTP Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SHARED_HTTP_SESSION_MANAGER

feature -- Access

	Session_manager: HTTP_SESSION_MANAGER is
			-- Singleton access to a session manager
		once
			create Result.make
		end
	
end -- class SHARED_HTTP_SESSION_MANAGER
