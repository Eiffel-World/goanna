indexing
	description: "Mandatory Database Update Integer Parameters"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_NON_EMPTY_INTEGER_UPDATE_PARAMETER
	
inherit
	
	GOA_NON_EMPTY_INTEGER_PARAMETER
	GOA_NON_EMPTY_UPDATE_INPUT_PARAMETER
		undefine
			label_class, validate
		end

end -- class GOA_NON_EMPTY_INTEGER_UPDATE_PARAMETER
