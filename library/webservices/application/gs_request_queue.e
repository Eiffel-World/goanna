indexing
	description: "Thread safe queue of pending requests"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	
	GS_REQUEST_QUEUE

obsolete "Use THREAD_SAFE_QUEUE instead"

inherit
	
	ANY
		redefine
			default_create
		end
	
	GS_APPLICATION_LOGGER
		export
			{NONE} all
		undefine
			default_create
		end
		
feature -- Initialisation

	default_create is
			-- Initialize
		do
			create {DS_LINKED_QUEUE [GS_QUEUED_REQUEST]} queue.make_default
			create queue_mutex
		end
		
feature -- Access

	next: GS_QUEUED_REQUEST is
			-- Next request in queue. Request is removed from queue
		require
			not_empty: not is_empty
		do
			queue_mutex.lock
			Result := queue.item
			queue.remove
			queue_mutex.unlock
			debugging (generator, "next request removed from queue")
		ensure
			next_item_exists: Result /= Void
			item_removed: not has (Result)
		end		
		
feature -- Measurement

	count: INTEGER is
			-- How many requests are pending
		do
			queue_mutex.lock
			Result := queue.count
			queue_mutex.unlock
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is the queue empty?
		do
			queue_mutex.lock
			Result := queue.is_empty
			queue_mutex.unlock
		end

	has (elem: GS_QUEUED_REQUEST): BOOLEAN is
			-- Does 'elem' exist in this queue?
		require
			item_exists: elem /= Void
		do
			queue_mutex.lock
			Result := queue.has (elem)
			queue_mutex.unlock
		end

feature -- Element change

	put (new_request: GS_QUEUED_REQUEST) is
			-- Add 'new_request' to the queue
		require
			new_request_exists: new_request /= Void
		do
			queue_mutex.lock
			queue.put (new_request)
			queue_mutex.unlock
			debugging (generator, "request added to queue")
		end

feature {NONE} -- Implementation

	queue: DS_QUEUE [GS_QUEUED_REQUEST]
			-- Internal queue implementation
			
	queue_mutex: MUTEX
			-- Mutual exclusion variable for synchronizing 
			-- multi-thread access
	
invariant
	
	queue_exists: queue /= Void
	queue_mutex_exists: queue_mutex /= Void
	
end -- class GS_REQUEST_QUEUE
