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
		
	LOG_SHARED_HIERARCHY
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
			initialise_logger
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
			if path /= Void then
				info (Servlet_app_log_category, "Servicing request: " + path)
				if servlet_manager.has_registered_servlet (path) then
					servlet_manager.servlet (path).service (req, resp)
				elseif servlet_manager.has_default_servlet then
					servlet_manager.default_servlet.service (req, resp)
				else
					handle_missing_servlet (resp)
					error (Servlet_app_log_category, "Servlet not found for URI " + path)
				end
			else
				handle_missing_servlet (resp)
				error (Servlet_app_log_category, "Request URI not specified")
			end	
		end
		
feature {NONE} -- Implementation
	
	Servlet_app_log_category: STRING is "servlet.app"
	
	initialise_logger is
			-- Set logger appenders
		local
			appender: LOG_APPENDER
			layout: LOG_LAYOUT
		do
			create {LOG_FILE_APPENDER} appender.make ("log.txt", True)
			create {LOG_PATTERN_LAYOUT} layout.make ("&d [&-6p] &c - &m%N")
			appender.set_layout (layout)
			log_hierarchy.category (Servlet_app_log_category).add_appender (appender)
		end
		
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
