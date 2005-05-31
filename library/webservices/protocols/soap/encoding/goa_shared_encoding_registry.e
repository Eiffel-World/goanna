indexing
	description: "Shared encoding registry"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class	GOA_SHARED_ENCODING_REGISTRY

feature -- Access

	encodings: REGISTRY [GOA_SOAP_ENCODING] is
			-- Shared encoding registry
		once
			create Result.make
		end

end -- class GOA_SHARED_ENCODING_REGISTRY
