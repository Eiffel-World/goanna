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
	
	NAMED_THREAD
		rename
			make as named_thread_make
		export
			{PRODUCER_CONSUMER_CONTROL} all
			{NONE} named_thread_make
		end
	
	SHARED_PRODUCER_CONSUMER_DATA
		export
			{NONE} all
		end

feature {NONE} -- Initialisation

	make (new_name: STRING; queue: like request_queue) is
			-- Initialise consumer to read from 'queue'
		require
			new_name_not_void: new_name /= Void
			queue_not_void: queue /= Void
		do
			named_thread_make (new_name)
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
				debugging (generator, name + " locking")
				mutex.lock
				debugging (generator, name + " checking not done")
				from
				until
					request_queue.is_empty
				loop
					debugging (generator, name + " checking not done")
					if not done then
						debugging (generator, name + " retrieving request")
						next := request_queue.next
						debugging (generator, name + " unlocking")						
						mutex.unlock
						process (next)
						debugging (generator, name + " relocking")
						mutex.lock
					end
				end
				if request_queue.is_empty then
					debugging (generator, name + " waiting on condition")
					condition.wait (mutex)
				end
				debugging (generator, name + " unlocking after signal")
				mutex.unlock
			end
			debugging (generator, name + " terminated")
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
