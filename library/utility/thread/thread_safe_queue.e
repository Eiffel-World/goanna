indexing
	description: "Thread-safe FIFO queue."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "utility thread"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class

	THREAD_SAFE_QUEUE [K]
	
inherit
	
	ANY
		redefine
			default_create
		end
		
create
	
	default_create
	
feature -- Initialisation

	default_create is
			-- Initialise
		do
			create {LINKED_QUEUE [K]} internal_queue.make
			create mutex
		end
		
feature -- Access

	next: K is
			-- Retrieve next item from queue and remove it.
			--| The precondition is not strictly thread safe because
			--| it is not within the mutex block.
		require
			not_empty: not is_empty
		do
			mutex.lock
			debug ("thread_safe_queue") print ("queue next%N") end
			Result := internal_queue.item
			internal_queue.remove
			mutex.unlock
		end

feature -- Status setting

	put (new_item: K) is
			-- Add 'new_item' to end of queue
		do
			mutex.lock
			debug ("thread_safe_queue") print ("queue put%N") end
			internal_queue.extend (new_item)
			mutex.unlock
		end
	
feature -- Status report

	is_empty: BOOLEAN is
			-- Is the queue empty?
		do
			mutex.lock
			Result := internal_queue.is_empty
			debug ("thread_safe_queue") print ("queue is_empty: " + Result.out + "%N") end
			mutex.unlock
		end

feature -- Measurement

	count: INTEGER is
			-- Number of elements in the queue
		do
			mutex.lock
			Result := internal_queue.count
			debug ("thread_safe_queue") print ("queue count: " + Result.out + "%N") end
			mutex.unlock
		end
		
feature {NONE} -- Implementation

	internal_queue: QUEUE [K]
			-- Mutex protected queue.

	mutex: MUTEX
			-- Thread synchronisation mutex.
	
invariant
	
	internal_queue_exists: internal_queue /= Void
	mutex_exists: mutex /= Void
	
end -- class THREAD_SAFE_QUEUE
