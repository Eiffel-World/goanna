
indexing

	description: "Codes and constants representing elements/attributes of the xmlns:goa_redirect schema"
	author: "Neal L. Lester"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2005"
	license: "Eiffel Forum License V2.0 (see forum.txt)"
	
-- DO NOT EDIT THIS FILE
-- This file was generated by schema_codes.xsl
-- Any changes made to this file will be overwritten the 
-- next time the XSL Transformation is run.

class
	GOA_REDIRECT_SCHEMA_CODES

feature -- Element Tags

 	paragraph_element_tag: STRING is "goa_common:paragraph"
	text_item_element_tag: STRING is "goa_common:text_item"
	division_element_tag: STRING is "goa_common:division"
	ordered_list_element_tag: STRING is "goa_common:ordered_list"
	list_item_element_tag: STRING is "goa_common:list_item"
	unordered_list_element_tag: STRING is "goa_common:unordered_list"
	hyperlink_element_tag: STRING is "goa_common:hyperlink"
	popup_hyperlink_element_tag: STRING is "goa_common:popup_hyperlink"
	table_element_tag: STRING is "goa_common:table"
	header_element_tag: STRING is "goa_common:header"
	row_element_tag: STRING is "goa_common:row"
	cell_element_tag: STRING is "goa_common:cell"
	footer_element_tag: STRING is "goa_common:footer"
	body_element_tag: STRING is "goa_common:body"
	hidden_element_tag: STRING is "goa_common:hidden"
	input_element_tag: STRING is "goa_common:input"
	submit_element_tag: STRING is "goa_common:submit"
	radio_element_tag: STRING is "goa_common:radio"
	checkbox_element_tag: STRING is "goa_common:checkbox"
	select_element_tag: STRING is "goa_common:select"
	option_element_tag: STRING is "goa_common:option"
	text_area_element_tag: STRING is "goa_common:text_area"
	image_element_tag: STRING is "goa_common:image"
	redirect_element_tag: STRING is "goa_redirect:redirect"
		
	
feature -- Attribute Names

	span_attribute_name: STRING is "span"
	palette_attribute_name: STRING is "palette"
	summary_attribute_name: STRING is "summary"
	cellspacing_attribute_name: STRING is "cellspacing"
	cellpadding_attribute_name: STRING is "cellpadding"
	colspan_attribute_name: STRING is "colspan"
	name_attribute_name: STRING is "name"
	type_attribute_name: STRING is "type"
	maxlength_attribute_name: STRING is "maxlength"
	size_attribute_name: STRING is "size"
	disabled_attribute_name: STRING is "disabled"
	value_attribute_name: STRING is "value"
	checked_attribute_name: STRING is "checked"
	on_click_script_attribute_name: STRING is "on_click_script"
	multiple_attribute_name: STRING is "multiple"
	selected_attribute_name: STRING is "selected"
	rows_attribute_name: STRING is "rows"
	columns_attribute_name: STRING is "columns"
	url_attribute_name: STRING is "url"
	alternate_text_attribute_name: STRING is "alternate_text"
	height_attribute_name: STRING is "height"
	width_attribute_name: STRING is "width"
	page_title_attribute_name: STRING is "page_title"
	style_sheet_attribute_name: STRING is "style_sheet"
	delay_attribute_name: STRING is "delay"
	dummy_attribute_name: STRING is "dummy"
	class_attribute_name: STRING is "class"
		

feature -- Codes

	span_attribute_code, palette_attribute_code, summary_attribute_code, cellspacing_attribute_code,
	cellpadding_attribute_code, colspan_attribute_code, name_attribute_code, type_attribute_code,
	maxlength_attribute_code, size_attribute_code, disabled_attribute_code, value_attribute_code,
	checked_attribute_code, on_click_script_attribute_code, multiple_attribute_code, selected_attribute_code,
	rows_attribute_code, columns_attribute_code, url_attribute_code, alternate_text_attribute_code,
	height_attribute_code, width_attribute_code, page_title_attribute_code, style_sheet_attribute_code,
	delay_attribute_code, dummy_attribute_code, class_attribute_code, paragraph_element_code, text_item_element_code, division_element_code, ordered_list_element_code,
	list_item_element_code, unordered_list_element_code, hyperlink_element_code, popup_hyperlink_element_code,
	table_element_code, header_element_code, row_element_code, cell_element_code,
	footer_element_code, body_element_code, hidden_element_code, input_element_code,
	submit_element_code, radio_element_code, checkbox_element_code, select_element_code,
	option_element_code, text_area_element_code, image_element_code, redirect_element_code, xml_text_code, xml_null_code: INTEGER is Unique	

feature -- Valid Attribute Values
	
	is_valid_attribute_value (attribute_name_code: INTEGER; attribute_value: STRING): BOOLEAN is
			-- is attribute_value valid for athe attribute given by attribute_name_code
		do
			Result :=  True
			inspect attribute_name_code
				when span_attribute_code then
					Result := Result and valid_span_attribute_values.has (attribute_value)
				when cellspacing_attribute_code then
					Result := Result and attribute_value.is_integer and then attribute_value.to_integer >= 0
				when cellpadding_attribute_code then
					Result := Result and attribute_value.is_integer and then attribute_value.to_integer >= 0
				when colspan_attribute_code then
					Result := Result and attribute_value.is_integer and then attribute_value.to_integer >= 0
				when type_attribute_code then
					Result := Result and valid_type_attribute_values.has (attribute_value)
				when maxlength_attribute_code then
					Result := Result and attribute_value.is_integer and then attribute_value.to_integer >= 0
				when size_attribute_code then
					Result := Result and attribute_value.is_integer and then attribute_value.to_integer >= 0
				when disabled_attribute_code then
					Result := Result and valid_disabled_attribute_values.has (attribute_value)
				when checked_attribute_code then
					Result := Result and valid_checked_attribute_values.has (attribute_value)
				when on_click_script_attribute_code then
					Result := Result and valid_on_click_script_attribute_values.has (attribute_value)
				when multiple_attribute_code then
					Result := Result and valid_multiple_attribute_values.has (attribute_value)
				when selected_attribute_code then
					Result := Result and valid_selected_attribute_values.has (attribute_value)
				when rows_attribute_code then
					Result := Result and attribute_value.is_integer and then attribute_value.to_integer >= 0
				when columns_attribute_code then
					Result := Result and attribute_value.is_integer and then attribute_value.to_integer >= 0
				when height_attribute_code then
					Result := Result and attribute_value.is_integer and then attribute_value.to_integer >= 0
				when width_attribute_code then
					Result := Result and attribute_value.is_integer and then attribute_value.to_integer >= 0
				when delay_attribute_code then
					Result := Result and attribute_value.is_integer and then attribute_value.to_integer >= 0
				when dummy_attribute_code then
					Result := Result and attribute_value.is_integer and then attribute_value.to_integer >= 0
				when class_attribute_code then
					Result := Result and valid_class_attribute_values.has (attribute_value)
				else
					Result := True
			end
		end



feature {NONE} -- Implementation
	
		valid_span_attribute_values: DS_LINKED_LIST [STRING] is
			-- Valid values for the spanattribute
		once
			create Result.make_equal
			Result.put_last ("bold")
		end

	valid_type_attribute_values: DS_LINKED_LIST [STRING] is
			-- Valid values for the typeattribute
		once
			create Result.make_equal
			Result.put_last ("text")
			Result.put_last ("password")
		end

	valid_disabled_attribute_values: DS_LINKED_LIST [STRING] is
			-- Valid values for the disabledattribute
		once
			create Result.make_equal
			Result.put_last ("yes")
			Result.put_last ("no")
		end

	valid_checked_attribute_values: DS_LINKED_LIST [STRING] is
			-- Valid values for the checkedattribute
		once
			create Result.make_equal
			Result.put_last ("yes")
			Result.put_last ("no")
		end

	valid_on_click_script_attribute_values: DS_LINKED_LIST [STRING] is
			-- Valid values for the on_click_scriptattribute
		once
			create Result.make_equal
			Result.put_last ("update_safety_suggestion_box_location")
			Result.put_last ("update_reminder_email")
			Result.put_last ("window.close()")
		end

	valid_multiple_attribute_values: DS_LINKED_LIST [STRING] is
			-- Valid values for the multipleattribute
		once
			create Result.make_equal
			Result.put_last ("yes")
			Result.put_last ("no")
		end

	valid_selected_attribute_values: DS_LINKED_LIST [STRING] is
			-- Valid values for the selectedattribute
		once
			create Result.make_equal
			Result.put_last ("yes")
			Result.put_last ("no")
		end

	valid_class_attribute_values: DS_LINKED_LIST [STRING] is
			-- Valid values for the classattribute
		once
			create Result.make_equal
			Result.put_last ("error_message")
			Result.put_last ("required")
			Result.put_last ("waiting_message")
			Result.put_last ("centered_submit_area")
		end



	element_code_by_tag: DS_HASH_TABLE [INTEGER, STRING] is
			-- Element codes, keyed by element tag
		once
			create Result.make_equal (30)
			Result.force (paragraph_element_code, paragraph_element_tag)
			Result.force (text_item_element_code, text_item_element_tag)
			Result.force (division_element_code, division_element_tag)
			Result.force (ordered_list_element_code, ordered_list_element_tag)
			Result.force (list_item_element_code, list_item_element_tag)
			Result.force (unordered_list_element_code, unordered_list_element_tag)
			Result.force (hyperlink_element_code, hyperlink_element_tag)
			Result.force (popup_hyperlink_element_code, popup_hyperlink_element_tag)
			Result.force (table_element_code, table_element_tag)
			Result.force (header_element_code, header_element_tag)
			Result.force (row_element_code, row_element_tag)
			Result.force (cell_element_code, cell_element_tag)
			Result.force (footer_element_code, footer_element_tag)
			Result.force (body_element_code, body_element_tag)
			Result.force (hidden_element_code, hidden_element_tag)
			Result.force (input_element_code, input_element_tag)
			Result.force (submit_element_code, submit_element_tag)
			Result.force (radio_element_code, radio_element_tag)
			Result.force (checkbox_element_code, checkbox_element_tag)
			Result.force (select_element_code, select_element_tag)
			Result.force (option_element_code, option_element_tag)
			Result.force (text_area_element_code, text_area_element_tag)
			Result.force (image_element_code, image_element_tag)
			Result.force (redirect_element_code, redirect_element_tag)
		end
		
	element_tag_by_code: DS_HASH_TABLE [STRING, INTEGER] is
			-- Element tags, keyed by element code
		once
			create Result.make_equal (30)
			Result.force (paragraph_element_tag, paragraph_element_code)
			Result.force (text_item_element_tag, text_item_element_code)
			Result.force (division_element_tag, division_element_code)
			Result.force (ordered_list_element_tag, ordered_list_element_code)
			Result.force (list_item_element_tag, list_item_element_code)
			Result.force (unordered_list_element_tag, unordered_list_element_code)
			Result.force (hyperlink_element_tag, hyperlink_element_code)
			Result.force (popup_hyperlink_element_tag, popup_hyperlink_element_code)
			Result.force (table_element_tag, table_element_code)
			Result.force (header_element_tag, header_element_code)
			Result.force (row_element_tag, row_element_code)
			Result.force (cell_element_tag, cell_element_code)
			Result.force (footer_element_tag, footer_element_code)
			Result.force (body_element_tag, body_element_code)
			Result.force (hidden_element_tag, hidden_element_code)
			Result.force (input_element_tag, input_element_code)
			Result.force (submit_element_tag, submit_element_code)
			Result.force (radio_element_tag, radio_element_code)
			Result.force (checkbox_element_tag, checkbox_element_code)
			Result.force (select_element_tag, select_element_code)
			Result.force (option_element_tag, option_element_code)
			Result.force (text_area_element_tag, text_area_element_code)
			Result.force (image_element_tag, image_element_code)
			Result.force (redirect_element_tag, redirect_element_code)
		end
		
	attribute_code_by_name: DS_HASH_TABLE [INTEGER, STRING] is
			-- Attribute codes, keyed by attribute name
		once
			create Result.make_equal (30)
			Result.force (span_attribute_code, span_attribute_name)
			Result.force (palette_attribute_code, palette_attribute_name)
			Result.force (summary_attribute_code, summary_attribute_name)
			Result.force (cellspacing_attribute_code, cellspacing_attribute_name)
			Result.force (cellpadding_attribute_code, cellpadding_attribute_name)
			Result.force (colspan_attribute_code, colspan_attribute_name)
			Result.force (name_attribute_code, name_attribute_name)
			Result.force (type_attribute_code, type_attribute_name)
			Result.force (maxlength_attribute_code, maxlength_attribute_name)
			Result.force (size_attribute_code, size_attribute_name)
			Result.force (disabled_attribute_code, disabled_attribute_name)
			Result.force (value_attribute_code, value_attribute_name)
			Result.force (checked_attribute_code, checked_attribute_name)
			Result.force (on_click_script_attribute_code, on_click_script_attribute_name)
			Result.force (multiple_attribute_code, multiple_attribute_name)
			Result.force (selected_attribute_code, selected_attribute_name)
			Result.force (rows_attribute_code, rows_attribute_name)
			Result.force (columns_attribute_code, columns_attribute_name)
			Result.force (url_attribute_code, url_attribute_name)
			Result.force (alternate_text_attribute_code, alternate_text_attribute_name)
			Result.force (height_attribute_code, height_attribute_name)
			Result.force (width_attribute_code, width_attribute_name)
			Result.force (page_title_attribute_code, page_title_attribute_name)
			Result.force (style_sheet_attribute_code, style_sheet_attribute_name)
			Result.force (delay_attribute_code, delay_attribute_name)
			Result.force (dummy_attribute_code, dummy_attribute_name)
			Result.force (class_attribute_code, class_attribute_name)
		end
		
	attribute_name_by_code: DS_HASH_TABLE [STRING, INTEGER] is
			-- Attribute names, keyed by attribute code
		once
			create Result.make_equal (30)
			Result.force (span_attribute_name, span_attribute_code)
			Result.force (palette_attribute_name, palette_attribute_code)
			Result.force (summary_attribute_name, summary_attribute_code)
			Result.force (cellspacing_attribute_name, cellspacing_attribute_code)
			Result.force (cellpadding_attribute_name, cellpadding_attribute_code)
			Result.force (colspan_attribute_name, colspan_attribute_code)
			Result.force (name_attribute_name, name_attribute_code)
			Result.force (type_attribute_name, type_attribute_code)
			Result.force (maxlength_attribute_name, maxlength_attribute_code)
			Result.force (size_attribute_name, size_attribute_code)
			Result.force (disabled_attribute_name, disabled_attribute_code)
			Result.force (value_attribute_name, value_attribute_code)
			Result.force (checked_attribute_name, checked_attribute_code)
			Result.force (on_click_script_attribute_name, on_click_script_attribute_code)
			Result.force (multiple_attribute_name, multiple_attribute_code)
			Result.force (selected_attribute_name, selected_attribute_code)
			Result.force (rows_attribute_name, rows_attribute_code)
			Result.force (columns_attribute_name, columns_attribute_code)
			Result.force (url_attribute_name, url_attribute_code)
			Result.force (alternate_text_attribute_name, alternate_text_attribute_code)
			Result.force (height_attribute_name, height_attribute_code)
			Result.force (width_attribute_name, width_attribute_code)
			Result.force (page_title_attribute_name, page_title_attribute_code)
			Result.force (style_sheet_attribute_name, style_sheet_attribute_code)
			Result.force (delay_attribute_name, delay_attribute_code)
			Result.force (dummy_attribute_name, dummy_attribute_code)
			Result.force (class_attribute_name, class_attribute_code)
		end

end -- GOA_REDIRECT_SCHEMA_CODES

 