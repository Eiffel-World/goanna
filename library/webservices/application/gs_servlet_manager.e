indexing
	description: "Servlet manager provides servlet registry"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class

	GS_SERVLET_MANAGER

inherit
	
	GS_APPLICATION_LOGGER
		export
			{NONE} all
		redefine
			default_create
		end
		
	HTTP_STATUS_CODES
		export
			{NONE} all
		undefine
			default_create
		end

	CGI_VARIABLES
		export
			{NONE} all
		undefine
			default_create
		end
		
create

	default_create
	
feature -- Initialization

	default_create is
			-- Initialise this servlet manager
		do
			Precursor {GS_APPLICATION_LOGGER}
			create registry.make
		end
	
feature -- Access

	registry: SERVLET_MANAGER [HTTP_SERVLET]
			-- Servlet registry

feature -- Basic operations

	dispatch (request: HTTP_SERVLET_REQUEST; response: HTTP_SERVLET_RESPONSE) is
			-- Dispatch 'request' to an appropriate servlet. Allow the servlet
			-- to response on 'response'.
		require
			request_exists: request /= Void
			response_exists: response /= Void
		local
			path: STRING
		do
			info (generator, "dispatching request")
			-- dispatch to the registered servlet using the path info as the registration name.
			if request.has_header (Path_info_var) then
				path := request.get_header (Path_info_var)
				if path /= Void then
					-- remove leading slash from path
					path.tail (path.count - 1)
				end
			end			
			if path /= Void and then registry.has_registered_servlet (path) then
				info (generator, "Servicing request: " + path)
				registry.servlet (path).service (request, response)
			else
				handle_missing_servlet (response)
				if path = Void then
					error (generator, "Servlet path not specified")
				else
					error (generator, "Servlet not found: " + path)
				end
			end	
		end
		
feature {NONE} -- Implementation

	handle_missing_servlet (response: HTTP_SERVLET_RESPONSE) is
			-- Send error page indicating missing servlet
		require
			response_exists: response /= Void
		do
			response.send_error (Sc_not_found)
		end

			
end -- class GS_SERVLET_MANAGER
