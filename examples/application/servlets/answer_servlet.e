indexing
	description: "A servlet that displays the users answeres to a few questions"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"


class

	ANSWER_SERVLET
	
inherit
	
	GOA_DISPLAYABLE_SERVLET
	GOA_NON_DATABASE_ACCESS_TRANSACTION_MANAGEMENT

creation
	
	make
	
feature

	name: STRING is "answer.htm"
	
	new_xml_document (processing_result: REQUEST_PROCESSING_RESULT): GOA_PAGE_XML_DOCUMENT is
		do
			create Result.make_utf8_encoded
		end
		
	add_body (processing_result: REQUEST_PROCESSING_RESULT; xml: GOA_PAGE_XML_DOCUMENT) is
		local
			user_name, language, language_comment: STRING
			is_male, thinks_goanna_is_cool: BOOLEAN
			session_status: SESSION_STATUS
			message_catalog: MESSAGE_CATALOG
		do
			session_status := processing_result.session_status
			message_catalog := processing_result.message_catalog
			user_name := session_status.name
			is_male := session_status.is_male
			language := session_status.programming_language.name
			language_comment := session_status.programming_language.comment
			thinks_goanna_is_cool := session_status.thinks_goanna_is_cool
			xml.start_page_element (message_catalog.answer_title, configuration.stylesheet, Void)
			xml.add_text_paragraph (Void, message_catalog.comment (user_name, is_male, language, language_comment, thinks_goanna_is_cool))
			xml.start_paragraph_element (Void)
				xml.add_item (question_servlet.hyperlink (processing_result, message_catalog.link_to_question_servlet_text))
			xml.end_current_element
		end
		
	add_footer (processing_result: REQUEST_PROCESSING_RESULT; xml: GOA_PAGE_XML_DOCUMENT) is
		do
			-- No Footer
		end
		
	ok_to_display (processing_result: REQUEST_PROCESSING_RESULT): BOOLEAN is
		local
			session_status: SESSION_STATUS
		do
			session_status := processing_result.session_status
			Result := 	not session_status.name.is_empty and session_status.programming_language /= Void
		end

end -- class ANSWER_SERVLET
