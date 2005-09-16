indexing
	description: "Radio button selecting an item in a list of objects of type G"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class
	GOA_RADIO_BUTTON_PARAMETER [G]
	
inherit
	
	GOA_REQUEST_PARAMETER
		redefine
			process, is_suffix_valid
		end
	GOA_SCHEMA_FACILITIES
	
feature

	is_queried: BOOLEAN is  False
	
	process (processing_result: PARAMETER_PROCESSING_RESULT) is
		local
			value: STRING
			local_is_value_valid, local_was_item_updated: BOOLEAN
		do
			value := processing_result.value
			start_transaction (processing_result.request_processing_result)
			if value.is_empty then
				add_not_received_error_message (processing_result)
			else
				validate (processing_result)
				local_is_value_valid := processing_result.is_value_valid
				local_was_item_updated := was_item_updated (item_in_processing_result (processing_result), currently_selected_object (processing_result.request_processing_result))
				if processing_result.is_value_valid and then was_item_updated (item_in_processing_result (processing_result), currently_selected_object (processing_result.request_processing_result)) then
					save_current_value (processing_result)
					if is_a_dependency then
						processing_result.set_was_dependency_updated
					else
						processing_result.set_was_updated
					end
				end
			end
			commit (processing_result.request_processing_result)
		ensure then
			empty_result_implies_not_is_value_valid: processing_result.value.is_empty implies not processing_result.is_value_valid
			valid_processing_result_implies_good_integer_value: processing_result.is_value_valid implies processing_result.value.is_integer and then (0 < processing_result.value.to_integer and processing_result.value.to_integer <= item_list (processing_result.request_processing_result).count)
		end
		
	validate (processing_result: PARAMETER_PROCESSING_RESULT) is
		do
			if not value_is_valid_index (processing_result) then
				processing_result.error_message.add_message (processing_result.session_status.message_catalog.system_error_message)
			end
		ensure then
			valid_processing_result_implies_good_integer_value: processing_result.is_value_valid implies processing_result.value.is_integer and then (0 < processing_result.value.to_integer and processing_result.value.to_integer <= item_list (processing_result.request_processing_result).count)
		end
		
	item_in_processing_result (processing_result: PARAMETER_PROCESSING_RESULT): G is
			-- The object referenced by value in processing_result
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result.request_processing_result)
			valid_index: value_is_valid_index (processing_result)
		do
			Result := item_list (processing_result.request_processing_result).i_th (processing_result.value.to_integer)
		ensure
			ok_to_read_data: ok_to_read_data (processing_result.request_processing_result)
		end
		
	value_is_valid_index (processing_result: PARAMETER_PROCESSING_RESULT): BOOLEAN is
			-- The object referenced by value in processing_result
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result.request_processing_result)
		local
			value: STRING
			integer_value: INTEGER
		do	
			value := processing_result.value
			if value.is_integer then
				integer_value := value.to_integer
				Result := item_list (processing_result.request_processing_result).valid_index (integer_value)
			end
		ensure
			ok_to_read_data: ok_to_read_data (processing_result.request_processing_result)
		end

	suffix_is_valid_index (processing_result: PARAMETER_PROCESSING_RESULT; suffix: INTEGER): BOOLEAN is
			-- The object referenced by value in processing_result
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result.request_processing_result)
		do	
			Result := item_list (processing_result.request_processing_result).valid_index (suffix)
		ensure
			ok_to_read_data: ok_to_read_data (processing_result.request_processing_result)
		end
	
	save_current_value (processing_result: PARAMETER_PROCESSING_RESULT) is
		do
			process_item_selected (processing_result, item_in_processing_result (processing_result))
		end
		
	add_not_received_error_message (processing_result: PARAMETER_PROCESSING_RESULT) is
			-- Add error message to if the parameter was not included with the request
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result.request_processing_result)
		deferred
		ensure
			ok_to_read_data: ok_to_read_data (processing_result.request_processing_result)
		end
		
	process_item_selected (processing_result: PARAMETER_PROCESSING_RESULT; the_object: G) is
			-- Process the_object which was selected from the list
		require
			valid_processing_result: processing_result /= Void
			valid_the_object: the_object /= Void
			valid_index: value_is_valid_index (processing_result)
			ok_to_write_data: ok_to_write_data (processing_result.request_processing_result)
		deferred
		ensure
			ok_to_write_data: ok_to_write_data (processing_result.request_processing_result)
		end
		
	item_list (processing_result: REQUEST_PROCESSING_RESULT): LINKED_LIST [G] is
			-- List upon which this radio button acts
		require
			valid_processing_result: processing_result /= Void
		deferred
		end
		
	currently_selected_object (processing_result: REQUEST_PROCESSING_RESULT): G is
			-- The currently selected object in the list
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
		deferred
		ensure
			ok_to_read_data: ok_to_read_data (processing_result)
		end
		
	is_currently_selected_object (processing_result: REQUEST_PROCESSING_RESULT; the_object: G): BOOLEAN is
			-- Is the_object the currently selected object
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
		do
			Result := the_object = currently_selected_object (processing_result)
		ensure
			ok_to_read_data: ok_to_read_data (processing_result)
		end		
		
	current_value (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
		do
			Result := currently_selected_object (processing_result).out
		end
		
	was_item_updated (item_in_list, item_in_database: G): BOOLEAN is
			-- Was item updated by the user
		do
			Result := item_in_list /= item_in_database
		end
		
	add_to_document (xml: EXTENDED_GOA_COMMON_XML_DOCUMENT; processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER) is
		do
			xml.add_radio_element (input_class (processing_result, suffix), name, suffix.out, yes_no_string_for_boolean (is_currently_selected_object (processing_result, item_list (processing_result).i_th (suffix))))
		end
		
	ok_to_add (xml: EXTENDED_GOA_COMMON_XML_DOCUMENT): BOOLEAN is
		do
			Result := xml.ok_to_add_element_or_text (xml.radio_element_code)
		end
		
	is_suffix_valid (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): BOOLEAN is
		do
			Result := 	True
		end
		
		
end -- class GOA_RADIO_BUTTON_PARAMETER