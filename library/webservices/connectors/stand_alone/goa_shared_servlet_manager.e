indexing
	description: "Singleton servlet manager accessor."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_SHARED_SERVLET_MANAGER 

feature -- Access

	servlet_manager: GOA_SERVLET_MANAGER [GOA_HTTP_SERVLET] is
			-- Access singleton servlet manager
		once
			create Result.make
		end
		
end -- class GOA_SHARED_SERVLET_MANAGER
