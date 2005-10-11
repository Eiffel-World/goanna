indexing
	description: "A GOA_RADIO_BUTTON_PARAMETER with a label"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class
	GOA_LABELED_RADIO_BUTTON_PARAMETER [G]

inherit
	
	GOA_RADIO_BUTTON_PARAMETER [G]
		undefine
			add_to_standard_data_input_table
		end
	GOA_LABELED_PARAMETER

feature

end -- class GOA_LABELED_RADIO_BUTTON_PARAMETER
