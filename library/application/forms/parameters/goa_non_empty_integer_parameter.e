indexing
	description: "Integer parameter that may not be empty"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_NON_EMPTY_INTEGER_PARAMETER
	
inherit
	
	GOA_NON_EMPTY_PARAMETER
		undefine
			process
		redefine
			validate
		end
	GOA_INTEGER_PARAMETER
		undefine
			label_class
		redefine
			validate
		end
		
feature
	
	validate (processing_result: PARAMETER_PROCESSING_RESULT) is
		do
			Precursor {GOA_NON_EMPTY_PARAMETER} (processing_result)
			if processing_result.is_value_valid then
				Precursor {GOA_INTEGER_PARAMETER} (processing_result)
			end
		end

end -- class GOA_NON_EMPTY_INTEGER_PARAMETER
