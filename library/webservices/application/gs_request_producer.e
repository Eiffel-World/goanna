indexing
	description: "Produces requests from a connector"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class

	GS_REQUEST_PRODUCER

inherit
	
	GS_APPLICATION_LOGGER
		export
			{NONE} all
		end
	
	PRODUCER [GS_QUEUED_REQUEST]
		rename
			make as producer_make
		export
			{NONE} producer_make
		end
	
create

	make
		
feature -- Initialization

	make (app_context: GS_SERVLET_CONTEXT; request_connector: GS_CONNECTOR;
		queue: THREAD_SAFE_QUEUE [GS_QUEUED_REQUEST]) is
			-- Initialise this request processor
		require
			app_context_exists: app_context /= Void
			request_connector_not_void: request_connector /= Void
			queue_not_void: queue /= Void
		do
			producer_make (queue)
			context := app_context
			connector := request_connector
		end

feature -- Access

	context: GS_SERVLET_CONTEXT
			-- Application context
			
	connector: GS_CONNECTOR
			-- server connector

feature -- Basic operations
		
	terminate is
			-- Stop this processor from reading requests
		do
			stop := True
		end
	
feature {NONE} -- Implementation

	generate_next: GS_QUEUED_REQUEST is
			-- Generate the next element for the queue
		do
			info (generator, "generate next request")
			connector.read_request
			if connector.last_operation_ok then
				create Result.make (connector.last_request, connector.last_response)
			end
			check 
				next_request_not_void: Result /= Void
			end
		end
		
	done: BOOLEAN is
			-- Has the producer finished generating events?
		do
			Result := stop
		end

	stop: BOOLEAN
			-- Stop flag.
			
invariant
	
	context_not_void: context /= Void
	connector_not_void: connector /= Void
	
end -- class GS_REQUEST_PRODUCER
