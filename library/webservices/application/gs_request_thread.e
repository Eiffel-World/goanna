indexing
	description: "Request processing thread."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	
	GS_REQUEST_THREAD

inherit
	
	THREAD

feature -- Basic operations

	execute is
			-- Check queue for requests and process if any exist
			-- then wait on the condition variable for a signal that 
			-- there are more requests.
		do
		end

feature {NONE} -- Implementation

-- NOTE: change to shared global once functions.

	request_queue: GS_REQUEST_QUEUE
				-- Queue of pending requests.
				
	request_mutex: MUTEX
				-- Request mutex.
				
	request_condition: CONDITION_VARIABLE
				-- Condition variable on which notification of new requests will
				-- be sent
				
end -- class GS_REQUEST_THREAD
