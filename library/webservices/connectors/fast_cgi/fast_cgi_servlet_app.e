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

	ASCII
	
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
			path, servlet_name: STRING
			servlet_found: BOOLEAN
			slash_index: INTEGER
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
			if path /= Void then
				-- Search upwards through a hierarchy of servlet names.
				from
					servlet_name := path
					slash_index := -1
				until
					servlet_found or slash_index = 0
				loop
					debug ("Fast CGI servlet app")
						info (Servlet_app_log_category, "Trying servlet: " + servlet_name)
					end
					if
						servlet_manager.has_registered_servlet (servlet_name)
					 then
						servlet_found := True
					else
						if servlet_name.count >0 then
							slash_index := servlet_name.last_index_of (Slash.to_character, servlet_name.count)
							debug ("Fast CGI servlet app")
								info (Servlet_app_log_category, "Slash index is " + slash_index.out)
							end
						else
							slash_index := 0
						end
						if slash_index > 0 then
							servlet_name := servlet_name.substring (1, slash_index - 1)
						else
							debug ("Fast CGI servlet app")
								info (Servlet_app_log_category, "Servlet name is " + servlet_name)
							end
							--check -- this is rubbish
							--	servlet_prefix: servlet_name.is_equal (servlet_manager.servlet_mapping_prefix)
							--end
						end
					end
				end
			end
			if servlet_found then
				info (Servlet_app_log_category, "Servicing request: " + path)
				info (Servlet_app_log_category, "Using servlet named: " + servlet_name)
				servlet_manager.servlet (servlet_name).service (req, resp)
			else
				if
					servlet_manager.has_default_servlet
				 then
					info (Servlet_app_log_category, "Using default servlet.")
					servlet_manager.default_servlet.service (req, resp)
				else
					handle_missing_servlet (resp)
					if
						path /= Void
					 then
						error (Servlet_app_log_category, "Servlet not found: " + path)
					else
						error (Servlet_app_log_category, "Servlet not found: path was Void")
					end
				end
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
