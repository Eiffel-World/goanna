indexing
	description: "Password input parameters"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_PASSWORD_PARAMETER

inherit
	
	GOA_NON_EMPTY_INPUT_PARAMETER
		redefine
			type
		end

feature
	
	type: STRING is
			-- Type of the input
		once
			Result := password_input_type
		end
		
	label_string (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
			-- label for this parameter (intended for presentation to the user
		do
			Result := processing_result.session_status.message_catalog.password_label
		end

end -- class GOA_PASSWORD_PARAMETER
