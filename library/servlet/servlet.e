indexing
	description: "Objects that run within a web server. Servlets receive and respond to requests from Web clients. "
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	SERVLET

inherit

	HTTP_STATUS_CODES
		export
			{NONE} all
		end
		
feature -- Initialization

	init (config: SERVLET_CONFIG) is
			-- Called by the servlet manager to indicate that the servlet is being placed
			-- into service. The servlet manager calls 'init' exactly once after instantiating
			-- the object. The 'init' method must complete successfully before the servlet can
			-- receive any requests.
		require
			config_exists: config /= Void
		deferred
		end
	
feature -- Access

	servlet_config: SERVLET_CONFIG
			-- The servlet configuration object which contains initialization and startup
			-- parameters for thsi servlet.

	servlet_info: STRING 
			-- Information about the servlet, such as, author, version and copyright.
	
feature -- Basic operations

	service (req: SERVLET_REQUEST; resp: SERVLET_RESPONSE) is
			-- Called by teh servlet manager to allow the servlet to
			-- respond to a request.
		require
			request_exists: req /= Void
			response_exists: resp /= Void
		deferred
		end
	
	destroy is
			-- Called by the servlet manager to indicate that the servlet
			-- is being taken out of service. The servlet can then clean
			-- up any resources that are being held.
		deferred
		end
	
invariant
	configured: servlet_config /= Void
	servlet_info_exists: servlet_info /= Void
	
end -- class SERVLET
