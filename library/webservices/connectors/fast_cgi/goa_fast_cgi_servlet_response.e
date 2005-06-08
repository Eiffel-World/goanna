indexing
	description: "Objects that represent Fast CGI request responses"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI servlets"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_FAST_CGI_SERVLET_RESPONSE

inherit
	
	GOA_CGI_SERVLET_RESPONSE
		rename
			make as cgi_servlet_make
		redefine
			write
		end

create
	make

feature {NONE}-- Initialization

	make (fcgi_request: GOA_FAST_CGI_REQUEST) is
			-- Build a new Fast CGI response object that provides access to
			-- 'fcgi_request' information.
			-- Initialise the response information to allow a successful (Sc_ok) response
			-- to be sent immediately.
		require
			request_exists: fcgi_request /= Void	
		do
			internal_request := fcgi_request
			cgi_servlet_make	
		end

feature {NONE} -- Implementation
		
	internal_request: GOA_FAST_CGI_REQUEST
		-- Internal request information and stream functionality.

	write (data: STRING) is
			-- Write 'data' to the output stream for this response
		do
			internal_request.write_stdout (data)
			-- TODO: check internal_request.write_ok and handle errors
		end
	
end -- class GOA_FAST_CGI_SERVLET_RESPONSE
