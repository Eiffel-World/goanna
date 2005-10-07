indexing
	description: "Servlet that asks the user some questions"
	author: "Neal L. Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) 2005 Neal L. Lester and others"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	QUESTION_SERVLET
	
inherit
	
	GOA_DISPLAYABLE_SERVLET
		redefine
			make
		end
	GOA_NON_DATABASE_ACCESS_TRANSACTION_MANAGEMENT

creation
	
	make

feature

	name: STRING is "question.htm"
	
	new_xml_document (processing_result: REQUEST_PROCESSING_RESULT): GOA_PAGE_XML_DOCUMENT is
		do
			create Result.make_utf8_encoded
			Result.start_page_element (processing_result.virtual_domain_host.host_name, processing_result.message_catalog.question_title, configuration.stylesheet, post_url (processing_result))			
		end
		
	add_body (processing_result: REQUEST_PROCESSING_RESULT; xml: GOA_PAGE_XML_DOCUMENT) is
		do
			xml.add_text_paragraph (Void, processing_result.message_catalog.question_title)
			xml.start_data_entry_table_element (processing_result.message_catalog)
					-- Indent twice because this command opens up two XML elements
					xml.add_standard_input_row (0, name_parameter, processing_result)
					xml.add_parameter (0, gender_parameter, processing_result)
					xml.add_standard_input_row (0, programming_language_parameter, processing_result)
					xml.add_standard_input_row (0, thinks_goanna_is_cool_parameter, processing_result)
				xml.end_current_element
			xml.end_current_element
			xml.start_paragraph_element (Void)
				xml.add_parameter (0, standard_submit_parameter, processing_result)
			xml.end_current_element
		end
		
	add_footer (processing_result: REQUEST_PROCESSING_RESULT; xml: GOA_PAGE_XML_DOCUMENT) is
		do
			-- No Footer
		end
		
	ok_to_display (processing_result: REQUEST_PROCESSING_RESULT): BOOLEAN is
		do
			Result := True
		end

feature {NONE} -- Creation

	make is
		do
			Precursor
			expected_parameters.force_last (name_parameter.name)
			expected_parameters.force_last (programming_language_parameter.name)
			add_if_absent_parameters.force_last (gender_parameter.name)
			add_if_absent_parameters.force_last (thinks_goanna_is_cool_parameter.name)
		end
		

end -- class QUESTION_SERVLET
