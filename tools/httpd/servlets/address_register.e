indexing
	description: "Register of addresses"

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
		
end -- class ADDRESS_REGISTER
