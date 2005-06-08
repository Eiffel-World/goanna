indexing
	description: "Objects representing agent calls on a target."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

deferred class GOA_SERVICE

inherit
	
	GOA_SERVICE_PROXY
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
		
end -- class GOA_SERVICE
