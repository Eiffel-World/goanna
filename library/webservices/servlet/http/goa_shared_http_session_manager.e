indexing
	description: "Singleton access for a HTTP_SESSION_MANAGER"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "HTTP Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_SHARED_HTTP_SESSION_MANAGER

feature -- Access

	Session_manager: GOA_HTTP_SESSION_MANAGER is
			-- Singleton access to a session manager
		once
			create Result.make
		end
	
end -- class GOA_SHARED_HTTP_SESSION_MANAGER
