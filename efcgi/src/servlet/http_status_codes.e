indexing
	description: "HTTP status code constants from RFC 2068."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

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
			
	-- TODO: the rest!

end -- class HTTP_STATUS_CODES
