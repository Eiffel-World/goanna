indexing
	description: "Objects representing agent calls on a target."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class

	SERVICE

inherit
	
	SERVICE_PROXY
		redefine
			make
		end

feature -- Initialisation

	make is
			-- Register services
		do
			Precursor
			self_register
		end
		
feature {NONE} -- Initialisation

	self_register is
			-- Register all facilities of Current in 'registry'.
		deferred
		end
		
end