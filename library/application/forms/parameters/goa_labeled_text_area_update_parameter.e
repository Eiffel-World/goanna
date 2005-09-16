indexing
	description: "Text area parameter that is labeled; and behaves as an update parameter"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class
	GOA_LABELED_TEXT_AREA_UPDATE_PARAMETER
	
inherit
	
	 GOA_UPDATE_PARAMETER
		undefine
			add_to_standard_data_input_table
		end
	GOA_LABELED_TEXT_AREA_PARAMETER

end -- class GOA_LABELED_TEXT_AREA_UPDATE_PARAMETER
