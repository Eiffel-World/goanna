indexing
	description: "Objects that respond to HTTP requests."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "HTTP Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	HTTP_SERVLET

inherit
	SERVLET

creation
	init
	
feature -- Initialization

	init (config: SERVLET_CONFIG) is
			-- Called by the servlet manager to indicate that the servlet is being placed
			-- into service. The servlet manager calls 'init' exactly once after instantiating
			-- the object. The 'init' method must complete successfully before the servlet can
			-- receive any requests.
		do
			servlet_config := config
			servlet_info := ""
		end

feature -- Basic operations

	do_get (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Called to allow the servlet to handle a GET request.
			-- Default: do nothing
		require
			request_exists: req /= Void
			response_exists: resp /= Void
		do
		end
	
	do_head (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Called to allow the servlet to handle a HEAD request.
		require
			request_exists: req /= Void
			response_exists: resp /= Void
		do
		end
		
	do_post (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Called to allow the servlet to handle a POST request.
			-- Default: do nothing
		require
			request_exists: req /= Void
			response_exists: resp /= Void
		do
		end
		
	service (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Handle a request by dispatching it to the correct method handler.
		local
			method: STRING
		do
			method := req.method
			if method.is_equal (Method_get) then
				do_get (req, resp)
			elseif method.is_equal (Method_post) then
				do_post (req, resp)
			elseif method.is_equal (Method_head) then
				do_head (req, resp)
			else
				resp.send_error (Sc_not_implemented)
			end
			-- make sure the response has been flushed.
			resp.flush_buffer
		end

	destroy is
			-- Called by the servlet manager to indicate that the servlet
			-- is being taken out of service. The servlet can then clean
			-- up any resources that are being held.
		do
		end
		
feature {NONE} -- Implementation
			
	Method_get: STRING is "GET"
	Method_post: STRING is "POST"
	Method_head: STRING is "HEAD"
	
end -- class HTTP_SERVLET
