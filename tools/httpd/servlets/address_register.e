indexing
	description: "Register of addresses"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	ADDRESS_REGISTER

creation
	
	make
	
feature -- Initialization

	make is
			-- Create a few addresses
		do
			create addresses.make_default
			addresses.force ("200 Elisabeth St, Melbourne", "harry")
			addresses.force ("186 Smith St, Fizroy", "mary")
		end
		
feature -- Access

	addresses: DS_HASH_TABLE [STRING, STRING]
	
	get_address_from_name (name: STRING): STRING is
			-- Locate address by name
		do
			Result := addresses.item (name)
		end
	
	add_entry (name: STRING; address: STRING) is
			-- Add 'address' for 'name'.
		require
			name_exists: name /= Void
			address_exists: address /= Void
		do
			
		end
		
end -- class ADDRESS_REGISTER
