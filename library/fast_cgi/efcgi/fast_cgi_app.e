indexing
	description: "Objects that represent a FastCGI standalone application"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI protocol"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	FAST_CGI_APP

inherit

-- NOTE: the following export modification clauses are commented out because
-- the SmallEiffel compiler doesn't correctly compile them. Once SmallEiffel
-- catches up with the language definition, they need uncommenting.

	FAST_CGI
--		export
--			{NONE} all
--		end
	
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
			-- Process a request.
		deferred
		end
	
end -- class FAST_CGI_APP
