indexing
	description: "Shared service registry."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_SHARED_SERVICE_REGISTRY

feature -- Access

	registry: GOA_SERVICE_REGISTRY is
			-- Shared registry
		once
			create Result.make
		end
		
end -- class GOA_SHARED_SERVICE_REGISTRY
