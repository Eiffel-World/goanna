indexing
	description: "Generic notion of a pool of objects. May be bounded or unbounded. Generic items must support %
		%default creation (ie, default_create)."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "utility"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	POOL [K -> ANY create default_create end]

inherit
	
	ANY
		redefine
			default_create
		end
		
create

	default_create

feature -- Initialization

	default_create is
			-- Initialise empty pool
		do
			create {DS_LINKED_STACK [K]} free_pool.make_default
			create {DS_LINKED_LIST [K]} busy_pool.make_default
			build_free_item
		end
		
feature -- Access

	item: K is
			-- Retrieve item from the free pool. Create new item if necessary.
		require
			item_free: free >= 0
		do
			Result := free_pool.item
			free_pool.remove
			busy_pool.force_last (Result)
			if free = 0 and not full then
				build_free_item
			end
		ensure
			busy: is_busy (Result)
		end
		
	return (i: K) is
			-- Make 'i' available on free pool.
		require
			is_busy: is_busy (i)
		do
			busy_pool.delete (i)
			free_pool.put (i)
		ensure
			free: is_free (i)
		end
	
	full: BOOLEAN is
			-- Is the pool full?
		do
			Result := maximum /= 0 and then count = maximum
		ensure
			full: Result = (maximum /= 0 and then count = maximum)
		end		
		
feature -- Measurement

	free: INTEGER is
			-- Number of items available on free pool.
		do
			Result := free_pool.count
		end
		
	busy: INTEGER is
			-- Number of items currently being used.
		do
			Result := busy_pool.count
		end
		
	count: INTEGER is
			-- Total number of items in pool, free or busy.
		do
			Result := free + busy
		ensure
			free_and_busy_count: Result = free + busy
		end
		
	maximum: INTEGER
			-- Maximum number of items in pool. Zero implies infinite size.

feature -- Status report

	is_free (i: K): BOOLEAN is
			-- Is 'i' currently available for use?
		do
			Result := free_pool.has (i)
		end
		
	is_busy (i: K): BOOLEAN is
			-- Is 'i' currently being used?
		do
			Result := busy_pool.has (i)
		end
		
feature {NONE} -- Implementation

	free_pool: DS_STACK [K]
			-- Stack of free items
	
	busy_pool: DS_LIST [K]
			-- List of busy items
		
	build_free_item is
			-- Build new item and make available in the pool. Do not overfill
			-- the pool.
		require
			not_full: not full
		local
			new_item: K
		do
			create new_item.default_create
			free_pool.force (new_item)
		end
		
invariant

	valid_pool_size: maximum = 0 or else count <= maximum

end -- class POOL
