indexing
	description: "Facilities for goa_common.rnc schema"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class

	GOA_SCHEMA_FACILITIES
	
feature

	yes_no_string_for_boolean (the_boolean: BOOLEAN): STRING is
			-- Return a string representing the_boolean
		do
			if the_boolean then
				Result := "yes"
			else
				Result := "no"
			end
		end
		
	on: STRING is "on"
	
	off: STRING is "off"
	
end -- class GOA_SCHEMA_FACILITIES
