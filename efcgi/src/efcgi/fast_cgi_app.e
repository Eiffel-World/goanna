indexing
	description: "Objects that represent a FastCGI standalone application."
	usage: "Inherit from this class to perform standard FastCGI initialisation and request processing."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FAST_CGI_APP

inherit

	FAST_CGI
		export
			{NONE} all
		end
	
feature -- Basic operations

	run is
			-- Read requests as they are received and process each by calling
			-- process_request
		do
			from
			until
				accept < 0
			loop
				process_request
			end
		end
	
	process_request is
			-- Process a new request.
		deferred
		end
	
end -- class FAST_CGI_APP
