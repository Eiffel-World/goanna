indexing
	description: "Objects that respond to HTTP requests."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_SERVLET

inherit
	SERVLET

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
			-- TODO: create an empty response body and call do_get on it.
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
		require
			request_exists: req /= Void
			response_exists: resp /= Void
		local
			method: STRING
		do
			method := req.method
			if method.equals (Method_get) then
				do_get (req, resp)
			else if method.equals (Method_post) then
				do_post (req, resp)
			else if method.equals (Method_head) then
				do_head (req, resp)
			else
				resp.sendError (Sc_not_implemented)
			end
		end

end -- class HTTP_SERVLET
