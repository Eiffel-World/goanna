indexing
	description: "Registry of agent services."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SERVICE_REGISTRY

creation 

	make
	
feature -- Initialisation

	make is
			-- Create new registry
		do
			create services.make_default
		end

feature -- Access

	register (service: SERVICE; name: STRING) is
			-- Register 'service' with 'name'
		require
			name_exists: name /= Void
			service_exists: service /= Void
		do
			services.force (service, name)
		ensure
			service_registered: has (name)
		end
	
	get (name: STRING): SERVICE is
			-- Retrieve service registered under 'name'
		require
			name_exists: name /= Void
			service_registered: has (name)
		do
			Result := services.item (name)
		end
	
	has (name: STRING): BOOLEAN is
			-- Is a service registered under 'name'?
		require
			name_exists: name /= Void
		do
			Result := services.has (name)
		end

feature {NONE} -- Implementation

	services: DS_HASH_TABLE [SERVICE, STRING]
			-- Collection of agent services indexed by name.
invariant
	
	services_exists: services /= Void
	
end -- class SERVICE_REGISTRY
