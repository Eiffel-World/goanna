indexing
	description: "Shared service registry."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SHARED_SERVICE_REGISTRY

feature -- Access

	registry: SERVICE_REGISTRY is
			-- Shared registry
		once
			create Result.make
		end
		
end -- class SHARED_SERVICE_REGISTRY
