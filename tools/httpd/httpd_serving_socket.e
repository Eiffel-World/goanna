indexing
	description: "Callback server socket that processes servlet requests."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class HTTPD_SERVING_SOCKET

inherit

	TCP_SOCKET
		redefine
			multiplex_read_callback
		end

	SOCKET_MULTIPLEXER_SINGLETON
		export
			{NONE}all
		end

	SHARED_SERVLET_MANAGER
		export
			{NONE} all
		end
		
	SHARED_STANDARD_LOGGER
		export
			{NONE} all
		end

	HTTP_STATUS_CODES
		export
			{NONE} all
		end
	
	HTTPD_CGI_HEADER_VARS
		export
			{NONE} all
		end
			
creation

    make_uninitialized

feature

	multiplex_read_callback is
			-- this routine is called if there is data ready for
			-- reading on our socket
		local
			http_request: HTTPD_REQUEST
			resp: HTTPD_SERVLET_RESPONSE
			req: HTTPD_SERVLET_REQUEST
			path: STRING
		do
			debug ("status_output")
				io.put_character ('?')
			end
			-- read the request
			buffer.resize (buffer_size.min (bytes_available))
			buffer.fill_blank
			receive_string (buffer)
			create http_request.make (buffer)
			-- create request and response objects from request buffer
			create resp.make (buffer, Current)
			create req.make (http_request, resp)
			-- dispatch to the registered servlet using the path info as the registration name.
			if req.has_header (Query_string_var) then
				path := req.get_header (Query_string_var)
				if path /= Void then
					-- remove leading slash from path
					path.tail (path.count - 1)
				end
			end			
			if path /= Void then
				log (Info, "Servicing request: " + path)
				if servlet_manager.has_registered_servlet (path) then
					servlet_manager.servlet (path).service (req, resp)
				elseif servlet_manager.has_default_servlet then
					servlet_manager.default_servlet.service (req, resp)
				else
					handle_missing_servlet (resp)
					log (Error, "Servlet not found for URI " + path)
				end
			else
				handle_missing_servlet (resp)
				log (Error, "Request URI not specified")
			end	
			-- close socket after sending reply
			socket_multiplexer.unregister_managed_socket_read (Current)
			close
		end

feature {NONE}

	handle_missing_servlet (resp: HTTPD_SERVLET_RESPONSE) is
			-- Send error page indicating missing servlet
		require
			resp_exists: resp /= Void
		do
			resp.send_error (Sc_not_found)
		end

    Buffer_size : INTEGER is 1024;

	buffer: STRING is
		once
			create Result.make (Buffer_size)
			Result.fill_blank
		end

end -- HTTP_SERVING_SOCKET
