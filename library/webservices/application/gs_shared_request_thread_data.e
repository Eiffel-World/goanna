indexing
	description: "Shared data for request threads"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class

	GS_SHARED_REQUEST_THREAD_DATA

obsolete "Use SHARED_PRODUCER_CONSUMER_DATA"

feature {GS_REQUEST_THREAD} -- Access
				
	request_mutex: MUTEX is
				-- Request mutex.
		indexing
			once_status: global
		once
			create Result
		end
		
	request_condition: CONDITION_VARIABLE is
				-- Condition variable on which notification of new requests will
				-- be sent
		indexing
			once_status: global
		once
			create Result.make
		end

feature -- Access

	request_queue: GS_REQUEST_QUEUE is
				-- Queue of pending requests.
		indexing
			once_status: global
		once
			create Result
		end

end -- class GS_SHARED_REQUEST_THREAD_DATA
