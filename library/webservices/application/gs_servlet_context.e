indexing
	description: "Servlet context scope"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class

	GS_SERVLET_CONTEXT
	
feature -- Access

	manager: GS_SERVLET_MANAGER is
			-- Servlet manager
		deferred
		end

	processors: DS_LINKED_LIST [GS_REQUEST_PROCESSOR] is
			-- Request processor
		deferred
		end
	
end -- class GS_SERVLET_CONTEXT
