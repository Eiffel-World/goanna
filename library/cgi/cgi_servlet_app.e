indexing
	description: "Objects that represent a CGI servlet application"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "CGI servlets"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	CGI_SERVLET_APP

inherit
	
	SERVLET_APPLICATION
		rename
			make as servlet_app_make
		end
	
	SHARED_SERVLET_MANAGER
		export
			{NONE} all
		end

	HTTP_STATUS_CODES
		export
			{NONE} all
		end
		
	SHARED_STANDARD_LOGGER
		export
			{NONE} all
		end

	CGI_VARIABLES
		export
			{NONE} all
		end
		
	KL_SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end
		
feature -- Initialisation

	make is
			-- Process the request and exit
		do
			register_servlets
			run
		end
	
feature -- Basic operations
		
	run is
			-- Process a request.
		local
			req: CGI_SERVLET_REQUEST
			resp: CGI_SERVLET_RESPONSE
			path: STRING
		do
			create resp.make
			create req.make (resp)	
			-- dispatch to the registered servlet using the path info as the registration name.
			if req.has_header (Path_info_var) then
				path := req.get_header (Path_info_var)
				if path /= Void then
					-- remove leading slash from path
					path.tail (path.count - 1)
				end
			end			
			if path = Void then
				handle_missing_servlet (resp)
				log (Error, "Servlet path not specified")
			elseif servlet_manager.has_registered_servlet (path) then
				log (Info, "Servicing request: " + path)
				servlet_manager.servlet (path).service (req, resp)
			else
				handle_missing_servlet (resp)
				log (Error, "Servlet not found: " + path)
			end	
		end
		
feature {NONE} -- Implementation
	
	handle_missing_servlet (resp: CGI_SERVLET_RESPONSE) is
			-- Send error page indicating missing servlet
		require
			resp_exists: resp /= Void
		do
			resp.send_error (Sc_not_found)
		end

	servlet_app_make (port, backlog: INTEGER) is
			-- Not used in a CGI app 	
		do
		end
		
end -- class CGI_SERVLET_APP
