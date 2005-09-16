indexing
	description: "Text area parameter that is labeled; and behaves as an update parameter"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_LABELED_TEXT_AREA_UPDATE_PARAMETER
	
inherit
	
	 GOA_UPDATE_PARAMETER
		undefine
			add_to_standard_data_input_table
		end
	GOA_LABELED_TEXT_AREA_PARAMETER

end -- class GOA_LABELED_TEXT_AREA_UPDATE_PARAMETER
