indexing
	description: "Holder for a queued request and its response"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	GOA_QUEUED_REQUEST

creation
	
	make
	
feature -- Initialization

	make (new_request: GOA_HTTP_SERVLET_REQUEST; new_response: GOA_HTTP_SERVLET_RESPONSE) is
			-- Initialize holder with 'new_request' and 'new_response'
		require
			new_request_exists: new_request /= Void
			new_response_exists: new_response /= Void
		do
			request := new_request
			response := new_response
		end
		
feature -- Access

	request: GOA_HTTP_SERVLET_REQUEST
			-- Request object
			
	response: GOA_HTTP_SERVLET_RESPONSE
			-- Response object

invariant
	
	request_exists: request /= Void
	response_exists: response /= Void

end -- class GOA_QUEUED_REQUEST
