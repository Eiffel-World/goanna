indexing
	description: "Manages a sequence of connectors and processes requests from each in turn"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class

	GS_REQUEST_PROCESSOR
		
inherit
	
	GS_APPLICATION_LOGGER
		export
			{NONE} all
		end
	
	NAMED_THREAD
		rename
			make as named_thread_make
		export
			{NONE} named_thread_make
		undefine
			default_create
		end
	
create

	make
		
feature -- Initialization

	make (application_context: GS_SERVLET_CONTEXT; thread_name: STRING) is
			-- Initialise this request processor
		require
			application_context_exists: application_context /= Void
			thread_name_exists: thread_name /= Void
		do
			named_thread_make (thread_name)
			default_create
			context := application_context
		end
	
feature -- Access

	context: GS_SERVLET_CONTEXT
			-- Application context
			
	connector: GS_CONNECTOR
			-- server connector

feature -- Basic operations

	execute is
			-- Read and process requests from each of the connectors in turn.
		do
			if connector /= Void then			
				from
					stop := False
				until
					stop
				loop
					info (generator, "reading request")
					connector.read_request
					if connector.last_operation_ok then
						info (generator, "dispatching request")			
						context.manager.dispatch (connector.last_request, connector.last_response)
					else
						stop := True
					end
					yield
				end	
			else
				error (generator, "connector not set")
			end
		end
		
	terminate is
			-- Stop this processor from reading requests
		do
			stop := True
		end
		
feature -- Status setting

	set_connector (new_connector: GS_CONNECTOR) is
			-- Set 'new_connector' as the connector for this processor
		require
			new_connector_exists: new_connector /= Void
		do
			connector := new_connector
		ensure
			connector_set: connector = new_connector
		end
		
feature {NONE} -- Implementation

	stop: BOOLEAN 
			-- Should this processor stop executing?
			
invariant
	
	context_exists: context /= Void
	
end -- class GS_REQUEST_PROCESSOR
