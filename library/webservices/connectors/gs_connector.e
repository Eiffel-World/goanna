indexing
	description: "Servlet connector for connecting to external servers"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class

	GS_CONNECTOR

inherit

	
	GS_APPLICATION_LOGGER
		export
			{NONE} all
		redefine
			default_create
		end
		
feature -- Initialisation

	default_create is
			-- Initialise
		do
			Precursor
		end	
	
feature -- Access

	last_operation_ok: BOOLEAN
			-- Was the last operation performed successful?

	last_request: HTTP_SERVLET_REQUEST
			-- Last request read by 'read_request'. Only valid if 
			-- 'last_operation_ok'
			
	last_response: HTTP_SERVLET_RESPONSE
			-- Response associated with 'last_request'. Only valid if
			-- 'last_operation_ok'
	
feature -- Basic operations

	read_request is
			-- Read a request from the service. Indicate success of read by
			-- setting 'last_operation_ok' and if successful set 'last_request'
			-- and 'last_response'
		deferred
		ensure
			request_read_or_error: last_operation_ok 
				implies (last_request /= Void and last_response /= Void)
			request_failed_on_error: not last_operation_ok
				implies (last_request = Void and last_response = Void)
		end
		
end -- class GS_CONNECTOR
