indexing
	description: "Threaded producer."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "utility thread"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	
	PRODUCER [K]

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
			-- Initialise this producer to write to 'queue'
		require
			queue_not_void: queue /= Void
		do
			request_queue := queue
		end
		
feature {PRODUCER_CONSUMER_CONTROL} -- Basic operations

	execute is
			-- Feed threads
		do
			from
			until
				done
			loop
				debug ("producer_consumer") print ("producer locking%N") end
				mutex.lock
				debug ("producer_consumer") print ("producer storing next%N") end
				request_queue.put (generate_next)
				debug ("producer_consumer") print ("producer unlocking%N") end
				mutex.unlock
				debug ("producer_consumer") print ("producer signalling%N") end
				condition.signal
			end
		end

feature {NONE} -- Implementation

	generate_next: K is
			-- Generate the next element for the queue
		deferred
		end
		
	done: BOOLEAN is
			-- Has the producer finished generating events?
		deferred
		end

	request_queue: THREAD_SAFE_QUEUE [K]
			-- Queue of requests to write to

invariant
	
	request_queue_not_void: request_queue /= Void
	
end -- class PRODUCER
