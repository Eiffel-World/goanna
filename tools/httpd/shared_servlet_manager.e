indexing
	description: "Singleton servlet manager accessor."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SHARED_SERVLET_MANAGER 

feature -- Access

	servlet_manager: SERVLET_MANAGER [HTTP_SERVLET] is
			-- Access singleton servlet manager
		once
			create Result.make
		end
		
end -- class SHARED_SERVLET_MANAGER
