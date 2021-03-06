indexing
	description: "A parameter which may not be added to an xml document"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class
	
	GOA_NON_DISPLAYABLE_PARAMETER
	
inherit
	
	GOA_REQUEST_PARAMETER
	
feature
	
	ok_to_add (the_document: GOA_XML_DOCUMENT): BOOLEAN is
		do
			Result := False
		ensure then
			not_result: not Result
		end
		
	add_to_document (the_document: GOA_XML_DOCUMENT; processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER) is
		do
			-- Nothing
		end
		
	add_to_standard_data_input_table (xml: GOA_COMMON_XML_DOCUMENT; processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER) is
		do
			-- Nothing
		end
		
		
	current_value (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
		do
			Result := ""
		end
		


end -- class GOA_NON_DISPLAYABLE_PARAMETER
