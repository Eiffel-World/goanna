indexing
	description: "Accepts a zip code from the user"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_US_ZIP_CODE_PARAMETER
	
inherit
	
	GOA_NON_EMPTY_UPDATE_INPUT_PARAMETER
		redefine
			maxlength, validate
		end
	GOA_INPUT_PARAMETER
		redefine
			maxlength
		end
	
feature
	
	size: INTEGER is 10
	
	maxlength: INTEGER is 10
	
	validate (processing_result: PARAMETER_PROCESSING_RESULT) is
		local
			zip_code, value: STRING
			index: INTEGER
			the_character: CHARACTER
		do
			Precursor (processing_result)
			if processing_result.is_value_valid then
				from
					index := 1
					zip_code := ""
					value := clone (processing_result.value)
				until
					index > value.count
				loop
					the_character := value.item (index)
					if the_character.is_digit then
						zip_code.extend (the_character)
					end
					index := index + 1
				end
				if not (zip_code.count = 5 or zip_code.count = 9) then
						processing_result.error_message.add_message (processing_result.session_status.message_catalog.invalid_zip_code_message)
				end
				if zip_code.count > 5 then
					zip_code.insert_character ('-', 6)
				end
				processing_result.value.wipe_out
				processing_result.value.append (zip_code)
			end
		end
		
	label_string (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
			do
				Result := processing_result.session_status.message_catalog.zip_code_label
			end

end -- class GOA_US_ZIP_CODE_PARAMETER
