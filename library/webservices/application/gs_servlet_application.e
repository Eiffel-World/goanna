indexing
	description: "Servlet based application"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class

	GS_SERVLET_APPLICATION
	
inherit
	
	GS_SERVLET_CONTEXT
		undefine
			default_create
		end

	GS_APPLICATION_LOGGER
		export
			{NONE} all
		redefine
			default_create
		end

feature -- Initialization

	default_create is
			-- Initialise this servlet application by registering all security realms,
			-- connectors and servlets
		do
			Precursor {GS_APPLICATION_LOGGER}
			info (generator, "initializing")
			create processor.make (Current)
			create manager
			register_security
			register_servlets
			register_producers
			register_consumers
			run
			info (generator, "terminating")
			Log_hierarchy.close_all
		end
	
feature -- Access

	processor: GS_REQUEST_PROCESSOR
			-- Request processor
			
	manager: GS_SERVLET_MANAGER
			-- Servlet manager

feature {NONE} -- Implementation

	register_servlets is
			-- Register all servlets for this application
		deferred
		end
		
	register_security is
			-- Register all security realms
		deferred
		end
		
	register_producers is
			-- Register all producers
		deferred
		end

	register_consumers is
			-- Register all consumers
		deferred
		end

	run is
			-- Start the request processor threads and wait for them 
			-- exit
		do
			processor.run
		end
		
invariant
	
	processor_exist: processor /= Void
	manager_exists: manager /= Void
	
end -- class GS_SERVLET_APPLICATION
