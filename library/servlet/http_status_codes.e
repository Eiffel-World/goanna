indexing
	description: "HTTP status code constants from RFC 2068."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	HTTP_STATUS_CODES

feature -- Access

	Sc_continue: INTEGER is 100
			-- Client can continue.
			
	Sc_switching_protocols: INTEGER is 101
			-- The server is switching protocols according to Upgrade header.
			
	Sc_ok: INTEGER is 200
			-- Request succeeded normally.
			
	Sc_created: INTEGER is 201
			-- Request succeeded and created a new resource on the server.
	
	Sc_moved_temporarily: INTEGER is 302
			-- Resource has been moved temporarily.
			
	Sc_not_found: INTEGER is 404
			-- Resource could not be found.
			
	Sc_not_implemented: INTEGER is 501
			-- Server does not support the functionality required to service the
			-- request.
				
	-- TODO: the rest!
	
	status_code_message (sc: INTEGER): STRING is
			-- Return textual description for 'sc'
		local
			code_set, set_idx: INTEGER
		do
			code_set := sc // 100
			set_idx := sc - (code_set * 100) + 1
			if code_set <= 0 or code_set > status_messages.count then
				Result := "Invalid status code"
			else
				if set_idx > status_messages.item (code_set).count then
					set_idx := status_messages.item (code_set).count
				end
				Result := status_messages.item (code_set).item (set_idx)
			end
		end
	
feature {NONE} -- Implementation

	status_messages: ARRAY [ARRAY [STRING]] is
			-- Default status descriptive messages
		local
			temp: ARRAY [STRING]
		once
			create Result.make (1, 5)
			-- informational messages
			temp := << 
				"Continue", -- 100
            	"Switching Protocols", -- 101
      			"Informational" -- 1xx
			>>
			Result.put (temp, 1)
			-- success messages
			temp := <<          
           		"OK", -- 200
				"Created", -- 201
				"Accepted", -- 202
				"Non-Authoritative Information", -- 203
				"No Content", -- 204
				"Reset Content", -- 205
				"Partial Content", -- 206
				"Success" -- 2xx
			>>
			Result.put (temp, 2)
			-- redirection messages
			temp := <<
				"Multiple Choices", -- 300
				"Moved Permanently", -- 301
				"Moved Temporarily", -- 302
				"See Other", -- 303
				"Not Modified", -- 304
				"Use Proxy", -- 305
				"Redirection" -- 3xx
			>>
			Result.put (temp, 3)
			-- client error messages
			temp := <<
				"Bad Request", -- 400
				"Unauthorized", -- 401
				"Payment Required", -- 402
				"Forbidden", -- 403
				"Not Found", -- 404
				"Method Not Allowed", -- 405
				"Not Acceptable", -- 406
				"Proxy Authentication Required", -- 407
				"Request Time-out", -- 408
				"Conflict", -- 409
				"Gone", -- 410
				"Length Required", -- 411
				"Precondition Failed", -- 412
				"Request Entity Too Large", -- 413
				"Request-URI Too Large", -- 414
				"Unsupported Media Type", -- 415
				"Client Error" -- 4xx
  			>>
			Result.put (temp, 4)
  			-- server error
			temp := <<
				"Internal Server Error", -- 500
				"Not Implemented", -- 501
				"Bad Gateway", -- 502
				"Service Unavailable", -- 503
				"Gateway Time-out", -- 504
				"HTTP Version not supported", -- 505
				"Server Error" -- 5xx
			>>
			Result.put (temp, 5)
		end
	
end -- class HTTP_STATUS_CODES
