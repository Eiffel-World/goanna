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
		
	THREAD_CONTROL
		export
			{NONE} all
		undefine
			default_create
		end
		
feature -- Initialization

	default_create is
			-- Initialise this servlet application by registering all security realms,
			-- connectors and servlets
		do
			Precursor {GS_APPLICATION_LOGGER}
			info (generator, "initializing")
			create processors.make_default
			create manager
			register_security
			register_servlets
			register_processors
			run
			info (generator, "terminating")
			Log_hierarchy.close_all
		end
	
feature -- Access

	processors: DS_LINKED_LIST [GS_REQUEST_PROCESSOR]
			-- Request processors
			
	manager: GS_SERVLET_MANAGER
			-- Servlet manager

feature -- Status setting

	add_processor (new_processor: GS_REQUEST_PROCESSOR) is
			-- Add 'new_processor' to the list of processors for this application
		require
			new_processor_exists: new_processor /= Void
			new_processor_not_registered: not processors.has (new_processor)
		do
			processors.put_last (new_processor)
		ensure
			processor_registered: processors.has (new_processor)
		end
		
	remove_processor (processor: GS_REQUEST_PROCESSOR) is
			-- Remove 'processor' from list of processors
		require
			processor_exists: processor /= Void
			processor_registered: processors.has (processor)
		do
			processors.delete (processor)
		ensure
			processor_not_registered: not processors.has (processor)
		end
		
feature {NONE} -- Implementation

	register_servlets is
			-- Register all servlets for this application
		deferred
		end
		
	register_security is
			-- Register all security realms
		deferred
		end
		
	register_processors is
			-- Register all processors and their connectors
		deferred
		end

	run is
			-- Start the request processor threads and wait for them 
			-- exit
		local
			c: DS_LINKED_LIST_CURSOR [GS_REQUEST_PROCESSOR]
		do
			from
				c := processors.new_cursor
				c.start
			until
				c.off
			loop
				c.item.launch
				if log_hierarchy.is_enabled_for (info_p) then
					info (generator, "Request processor thread launched: " + c.item.name)
				end
				c.forth
			end
			join_all
		end
		
invariant
	
	processors_exist: processors /= Void
	manager_exists: manager /= Void
	
end -- class GS_SERVLET_APPLICATION
