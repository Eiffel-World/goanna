indexing
	description: "A hidden input in an html form"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	
deferred class
	GOA_HIDDEN_PARAMETER
	
inherit
	
	GOA_REQUEST_PARAMETER
		redefine
			display_value
		end
	
feature
	
	display_value (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
		do
			Result := current_value (processing_result, suffix)
		end
		
	add_to_document (xml: EXTENDED_GOA_COMMON_XML_DOCUMENT; processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER) is
		do
			xml.add_hidden_element (name, display_value (processing_result, suffix))
		end

	ok_to_add (xml: EXTENDED_GOA_COMMON_XML_DOCUMENT): BOOLEAN is
		do
			Result := xml.ok_to_add_element_or_text (xml.hidden_element_code)
		end

end -- class GOA_HIDDEN_PARAMETER
