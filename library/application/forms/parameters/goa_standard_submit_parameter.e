indexing
	description: "Standard Submit Button Parameter"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_STANDARD_SUBMIT_PARAMETER
	
inherit

	GOA_SUBMIT_PARAMETER
		redefine
			is_suffix_valid
		end
	GOA_NON_DATABASE_ACCESS_PARAMETER
	
creation
	
	make
	
feature
	
	name: STRING is "standard_submit"
	
	process (processing_result: PARAMETER_PROCESSING_RESULT)is
		do
			-- Nothing
		end
		
	label_string (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
		do
			if processing_result.generating_servlet = Void then
				Result := processing_result.message_catalog.submit_label
			else
				Result := processing_result.generating_servlet.standard_submit_label (processing_result)
			end
		end
		
	is_suffix_valid (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): BOOLEAN is
		do
			Result := True
		end
		
	add_not_received_error_message (processing_result: PARAMETER_PROCESSING_RESULT) is
			-- Add error message to if the parameter was not included with the request
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result.request_processing_result)
		do
			-- Nothing
		ensure
			ok_to_read_data: ok_to_read_data (processing_result.request_processing_result)
		end

		
end -- class GOA_STANDARD_SUBMIT_PARAMETER
