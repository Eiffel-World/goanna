indexing
	description: "A list parameter that is labeled for presentation to the user"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	
	GOA_LABELED_ITEM_LIST_PARAMETER [G]
	
inherit
	
	GOA_ITEM_LIST_PARAMETER [G]
	GOA_LABELED_PARAMETER
	
feature
	
	add_list_to_standard_data_input_table (xml: GOA_COMMON_XML_DOCUMENT; processing_result: REQUEST_PROCESSING_RESULT) is	
		require
			valid_xml: xml /= Void
			ok_to_add_standard_input_row: xml.ok_to_add_element_or_text (xml.row_element_code)
			valid_processing_result: processing_result /= Void
			ok_to_read_data (processing_result)
		local
			local_item_list: DS_LINKED_LIST [G]
		do
			local_item_list := item_list (processing_result)
			from
				local_item_list.start
			until
				local_item_list.after
			loop
				add_to_standard_data_input_table (xml, processing_result, local_item_list.index)
				local_item_list.forth
			end
		end

end -- class GOA_LABELED_ITEM_LIST_PARAMETER
