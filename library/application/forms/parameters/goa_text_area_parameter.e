indexing
	description: "Parameter that accepts input from the user through an html text_area tag"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_TEXT_AREA_PARAMETER
	
inherit
	
	GOA_REQUEST_PARAMETER
	
feature
	
	add_to_document (xml: EXTENDED_GOA_COMMON_XML_DOCUMENT; processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER) is
		do
			xml.add_text_area_element (input_class (processing_result, suffix), name, rows (processing_result, suffix).out, columns (processing_result, suffix).out, display_value (processing_result, suffix))
		end

	ok_to_add (xml: EXTENDED_GOA_COMMON_XML_DOCUMENT): BOOLEAN is
		do
			Result := xml.ok_to_add_element_or_text (xml.text_area_element_code)
		end
		
	rows (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): INTEGER is 
			-- Number of rows in the text area element
		require
			valid_processing_result: processing_result /= Void
			is_suffix_valid:  is_suffix_valid (processing_result, suffix)
		deferred
		end
			
	columns (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): INTEGER is 
			-- Number of columns in the text area element
		require
			valid_processing_result: processing_result /= Void
			is_suffix_valid:  is_suffix_valid (processing_result, suffix)
		deferred
		end
	
end -- class GOA_TEXT_AREA_PARAMETER
