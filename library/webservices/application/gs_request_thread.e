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

obsolete "Replaced by GS_REQUEST_CONSUMER"

inherit
	
	NAMED_THREAD
	
	GS_SHARED_REQUEST_THREAD_DATA
		export
			{NONE} request_queue
		end

	GS_APPLICATION_LOGGER
		export
			{NONE} all
		end
		
creation
	
	make
	
feature -- Basic operations

	execute is
			-- Check queue for requests and process if any exist
			-- then wait on the condition variable for a signal that 
			-- there are more requests.
		local
			request_holder: GS_QUEUED_REQUEST
		do
			from
			until
				stop
			loop
				debugging (generator, "checking for requests " + name)
				if request_queue.is_empty then
					debugging (generator, "request mutex lock " + name)					
					request_mutex.lock
					-- wait for a signal	
					debugging (generator, "waiting for condition signal " + name)
					request_condition.wait (request_mutex)
				else
					-- process the requests in the queue
					debugging (generator, "handling request in queue " + name)
					request_holder := request_queue.next
				end
				debugging (generator, "request mutex unlock " + name)					
				request_mutex.unlock
			end	
		end

	terminate is
			-- Indicate that the thread should stop at the next opportunity
		do
			stop := True
		end
		
feature {NONE} -- Implementation

	stop: BOOLEAN
				
end -- class GS_REQUEST_THREAD
