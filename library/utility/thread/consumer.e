indexing
	description: "Threaded consumer."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "utility thread"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	
	CONSUMER [K]

inherit
	
	THREAD
		export
			{PRODUCER_CONSUMER_CONTROL} all
		end
	
	SHARED_PRODUCER_CONSUMER_DATA
		export
			{NONE} all
		end

feature {NONE} -- Initialisation

	make (queue: like request_queue) is
			-- Initialise consumer to read from 'queue'
		require
			queue_not_void: queue /= Void
		do
			request_queue := queue
		end
		
feature {PRODUCER_CONSUMER_CONTROL} -- Basic operations

	execute is
			-- Process queue elements as they arrive
		local
			next: K
		do
			-- process until notified to stop
			from		
			until
				done
			loop				
				mutex.lock
				from
				until
					request_queue.is_empty
				loop
					if not done then
						next := request_queue.next
						mutex.unlock
						process (next)
						mutex.lock
					end
				end
				if request_queue.is_empty then
					condition.wait (mutex)
				end
				mutex.unlock
			end
			debug print (thread_id.out + " terminated%N") end
		end
	
	terminate is
			-- Terminate this thread at the next opportunity
		do
			done := True
		end

feature {NONE} -- Implementation

	process (next: K) is
			-- Process the next entry in the queue.
		deferred
		end

	done: BOOLEAN
			-- Flag indicating whether the consumer should
			-- terminate.
			
	request_queue: THREAD_SAFE_QUEUE [K]
			-- Queue of requests to process.
			
invariant
	
	request_queue_not_void: request_queue /= Void
	
end -- class CONSUMER
