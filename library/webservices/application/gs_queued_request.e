indexing
	description: "Holder for a queued request and its response"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	GS_QUEUED_REQUEST

creation
	
	make
	
feature -- Initialization

	make (new_request: HTTP_SERVLET_REQUEST; new_response: HTTP_SERVLET_RESPONSE) is
			-- Initialize holder with 'new_request' and 'new_response'
		require
			new_request_exists: new_request /= Void
			new_response_exists: new_response /= Void
		do
			request := new_request
			response := new_response
		end
		
feature -- Access

	request: HTTP_SERVLET_REQUEST
			-- Request object
			
	response: HTTP_SERVLET_RESPONSE
			-- Response object

invariant
	
	request_exists: request /= Void
	response_exists: response /= Void

end -- class GS_QUEUED_REQUEST
