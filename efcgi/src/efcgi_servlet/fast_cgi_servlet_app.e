indexing
	description: "Objects that represent a FastCGI servlet application."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	FAST_CGI_SERVLET_APP

inherit
	FAST_CGI_APP
		rename
			make as fast_cgi_app_make
		export
			{NONE} fast_cgi_app_make
		end
	
	SERVLET_MANAGER [HTTP_SERVLET]
		rename
			make as servlet_manager_make
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make (port, backlog: INTEGER) is
			-- Create a new fast cgi servlet application
		require
			positive_port: port >= 0
			positive_backlog: backlog >= 0
		do
			servlet_manager_make
			fast_cgi_app_make (port, backlog)
		end
	
feature -- Basic operations

	process_request is
			-- Process a request.
		local
			internal_request: FAST_CGI_SERVLET_REQUEST
			internal_response: FAST_CGI_SERVLET_RESPONSE
		do
			create internal_request.make (request)
			create internal_response.make (request)
			get_servlet ("test").service (internal_request, internal_response)
			
		end
		
end -- class FAST_CGI_SERVLET_APP
