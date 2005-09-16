indexing
	description: "A text area parameter that is labeled"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_LABELED_TEXT_AREA_PARAMETER
	
inherit
	
	GOA_TEXT_AREA_PARAMETER
	GOA_LABELED_PARAMETER
		redefine
			add_to_standard_data_input_table
		end
	
feature
	
	add_to_standard_data_input_table (xml: EXTENDED_GOA_COMMON_XML_DOCUMENT; processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER) is
		local
			the_parameter_processing_result: PARAMETER_PROCESSING_RESULT
		do
			the_parameter_processing_result := parameter_processing_result (processing_result, suffix)
			xml.start_row_element (Void)
				xml.start_cell_element (label_class (processing_result, suffix), "3")
					xml.start_division_element (label_class (processing_result, suffix))
						xml.add_item (label (processing_result, suffix))
					xml.end_current_element
				xml.end_current_element
			xml.end_current_element
			xml.start_row_element (Void)
				xml.start_cell_element (Void, "2")
					add_to_document (xml, processing_result, suffix)
				xml.end_current_element
				xml.start_cell_element (xml.class_error_message, "1")
					if the_parameter_processing_result /= Void then
						the_parameter_processing_result.error_message.add_to_document (xml)
					end
				xml.end_current_element
			xml.end_current_element
		end
		


end -- class GOA_LABELED_TEXT_AREA_PARAMETER
