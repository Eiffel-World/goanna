indexing
	description: "Goanna boolean parameters that are labeled with strings"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class
	GOA_STRING_LABELED_BOOLEAN_PARAMETER

inherit
	
	GOA_LABELED_BOOLEAN_PARAMETER
	GOA_STRING_LABELED_PARAMETER
		undefine
			add_to_standard_data_input_table
		end
	
end -- class GOA_STRING_LABELED_BOOLEAN_PARAMETER
