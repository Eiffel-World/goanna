indexing
	description: "FastCGI connector"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI servlets"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	GS_FAST_CGI_CONNECTOR

inherit
	
	GS_CONNECTOR
	
	FAST_CGI
		rename
			Log_hierarchy as Fast_cgi_log_hierarchy,
			error as fast_cgi_error,
			log as fast_cgi_log,
			fatal as fast_cgi_fatal,
			info as fast_cgi_info,
			debugging as fast_cgi_debugging,
			warn as fast_cgi_warn
		export
			{NONE} all
		undefine
			default_create
		redefine
			make
		end

create
	
	make

feature -- Initialisation

	make (port, backlog: INTEGER) is
			-- Initialise
		do
			Precursor (port, backlog)
			default_create
			info (generator, "Listening on port: " + port.out)
		end
		
feature -- Basic operations

	read_request is
			-- Read a request from the service. Indicate success of read by
			-- setting 'last_operation_ok' and if successful set 'last_request'
			-- and 'last_response'
		local
			response: FAST_CGI_SERVLET_RESPONSE
		do
			info (generator, "accepting new request")
			if accept >= 0 then
				info (generator,  "new request received")
				create response.make (request)
				last_response := response
				create {FAST_CGI_SERVLET_REQUEST} last_request.make (request, response)	
				last_operation_ok := True
			else
				error (generator, "error accepting new request")
				last_operation_ok := False
				last_response := Void
				last_request := Void
			end		
		end

end -- class GS_FAST_CGI_CONNECTOR
