indexing
	description: "A non empty parameter that updates the database"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_NON_EMPTY_UPDATE_INPUT_PARAMETER
	
inherit
	
	GOA_NON_EMPTY_INPUT_PARAMETER
		undefine
			process
		end
	GOA_UPDATE_INPUT_PARAMETER
		undefine
			label_class
		end
	

end -- class GOA_NON_EMPTY_UPDATE_INPUT_PARAMETER
