indexing
	description: "Parameters that operate on one item in a list of existing items; with suffix indicating the list index"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_ITEM_LIST_PARAMETER [G]

inherit
	
	GOA_DEFERRED_PARAMETER
		redefine
			is_suffix_valid
		end

feature
		
	item_list (processing_result: REQUEST_PROCESSING_RESULT): DS_LINKED_LIST [G] is
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
		deferred
		ensure
			ok_to_read_data: ok_to_read_data (processing_result)
		end
	
	is_suffix_valid (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): BOOLEAN is
		do
			Result := item_list (processing_result).valid_index (suffix)
		end
		
	item_in_list (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): G is
		require
			ok_to_read_data: ok_to_read_data (processing_result)
			valid_processing_result: processing_result /= Void
			is_valid_suffix: is_suffix_valid (processing_result, suffix)
		do
			Result := item_list (processing_result).item (suffix)
		ensure
			ok_to_read_data: ok_to_read_data (processing_result)
		end

end -- class GOA_ITEM_LIST_PARAMETER
