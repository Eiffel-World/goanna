indexing
	description: "Redirects user to another page"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class
	GOA_REDIRECT_SERVLET
	
inherit
	
	GOA_DISPLAYABLE_SERVLET
	
feature

	new_xml_document (processing_result: REQUEST_PROCESSING_RESULT): EXTENDED_GOA_REDIRECT_XML_DOCUMENT is
		local
			virtual_domain_host: VIRTUAL_DOMAIN_HOST
		do
			create Result.make_utf8_encoded
			virtual_domain_host := processing_result.session_status.virtual_domain_host
			start_version_access (processing_result)
				Result.start_redirect_element (title (processing_result), delay (processing_result), url (processing_result), style_sheet (processing_result))
			end_version_access (processing_result)
		end
	
	add_footer (processing_result: REQUEST_PROCESSING_RESULT; xml: EXTENDED_GOA_REDIRECT_XML_DOCUMENT) is
		do
		
		end
		
	title (processing_result: REQUEST_PROCESSING_RESULT): STRING is
			-- Title displayed in Browser Title
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data (processing_result)
		do
			Result := processing_result.message_catalog.default_redirect_title
		ensure
			ok_to_read_data (processing_result)
		end
		
	style_sheet (processing_result: REQUEST_PROCESSING_RESULT): STRING is
			-- URL to the stylesheet for this page
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data (processing_result)
		do
			Result := Void -- Descendents may redefine if necessary
		ensure
			ok_to_read_data (processing_result)
		end
	
		
	delay (processing_result: REQUEST_PROCESSING_RESULT): STRING is
			-- The number of seconds to delay before redirecting to URL
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data (processing_result)
		deferred
		ensure
			result_is_integer: Result /= Void and then Result.is_integer
			ok_to_read_data (processing_result)
		end
		
	url (processing_result: REQUEST_PROCESSING_RESULT): STRING is
			-- The URL to redirect the user to
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data (processing_result)
		deferred
		ensure
			ok_to_read_data (processing_result)
		end
		
	page_transformer_file_name: STRING is
		once
			Result := configuration.data_directory + "/goa_redirect.xsl"
		end

		
end -- class GOA_REDIRECT_SERVLET
