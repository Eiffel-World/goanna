indexing
	description: "Objects that represent a FastCGI servlet application"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI servlets"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	FAST_CGI_SERVLET_APP

inherit
	
	SERVLET_APPLICATION
	
	FAST_CGI_APP
		rename
			make as fast_cgi_app_make
		export
			{NONE} fast_cgi_app_make
		end
	
	SHARED_SERVLET_MANAGER
		export
			{NONE} all
		end

	HTTP_STATUS_CODES
		export
			{NONE} all
		end

feature -- Initialisation

	make (port, backlog: INTEGER) is
			-- Create a new fast cgi servlet application
		do
			fast_cgi_app_make (port, backlog)
		end
	
feature -- Basic operations
		
	process_request is
			-- Process a request.
		local
			req: FAST_CGI_SERVLET_REQUEST
			resp: FAST_CGI_SERVLET_RESPONSE
			path: STRING
		do
			create resp.make (request)
			create req.make (request, resp)	
			-- dispatch to the registered servlet using the path info as the registration name.
			if req.has_header (Path_info_var) then
				path := req.get_header (Path_info_var)
				if path /= Void then
					-- remove leading slash from path
					path.tail (path.count - 1)
				end
			end			
			if path /= Void and servlet_manager.has_registered_servlet (path) then
				info (Servlet_app_log_category, "Servicing request: " + path)
				servlet_manager.servlet (path).service (req, resp)
			else
				handle_missing_servlet (resp)
				error (Servlet_app_log_category, "Servlet not found: " + path)
			end	
		end
		
feature {NONE} -- Implementation

	handle_missing_servlet (resp: FAST_CGI_SERVLET_RESPONSE) is
			-- Send error page indicating missing servlet
		require
			resp_exists: resp /= Void
		do
			resp.send_error (Sc_not_found)
		end
	
end -- class FAST_CGI_SERVLET_APP
