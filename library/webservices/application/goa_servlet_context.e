indexing
	description: "Servlet context scope"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

deferred class GOA_SERVLET_CONTEXT
	
feature -- Access

	manager: GOA_SERVLET_MANAGER is
			-- Servlet manager
		deferred
		end

	processor: GOA_REQUEST_PROCESSOR is
			-- Request processor
		deferred
		end
	
end -- class GOA_SERVLET_CONTEXT
