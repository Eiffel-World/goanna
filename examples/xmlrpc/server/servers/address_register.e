indexing
	description: "Register of addresses"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XMLRPC examples"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	ADDRESS_REGISTER

inherit
	
	SERVICE
		redefine
			make
		end
		
creation
	
	make
	
feature -- Initialization

	make is
			-- Create a few addresses
		local
			discard: STRING
		do
			Precursor
			create addresses.make_default
		end
		
feature -- Access
			
	get_entry (name: STRING): STRING is
			-- Locate address by name
		do
			Result := addresses.item (name)
		end
	
	add_entry (name: STRING; address: STRING): STRING is
			-- Add 'address' for 'name'.
		require
			name_exists: name /= Void
			address_exists: address /= Void
		do
			addresses.force (address, name)
			Result := address
		end
	
	has_entry (name: STRING): BOOLEAN_REF is
			-- Does 'address' exist for 'name'?
		require
			name_exists: name /= Void
		do
			create Result
			Result.set_item (addresses.has (name))
		end
		
	remove_entry (name: STRING): STRING is
			-- Remove 'address' for 'name'
		require
			name_exists: name /= Void
			has_name: has_entry (name).item
		do
			Result := get_entry (name)
			addresses.remove (name)
		end
	
	get_names: ARRAY [STRING] is
			-- Return all names
		local
			c: DS_HASH_TABLE_CURSOR [STRING, STRING]
			i: INTEGER
		do
			create Result.make (1, addresses.count)
			from
				c := addresses.new_cursor
				c.start
				i := 1
			until
				c.off
			loop
				Result.force (c.key, i)
				c.forth
				i := i + 1
			end
		end
	
feature {NONE} -- Implementation

	addresses: DS_HASH_TABLE [STRING, STRING]
			-- List of addresses indexed by name

feature {NONE} -- Initialisation

	self_register is
			-- Register all actions for this service
		do		
			register (agent get_names, "getNames")
			register (agent get_entry, "getEntry")
			register (agent has_entry, "hasEntry")
			register (agent add_entry, "addEntry")
			register (agent remove_entry, "removeEntry")
		end

end -- class ADDRESS_REGISTER
