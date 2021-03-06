
indexing

	description: "An XML Document conforming with the xmlns:goa_common schema"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	copyright: ""
	license: ""

-- DO NOT EDIT THIS FILE
-- This file was generated by deferred_xml_writer.xsl
-- Any changes made to this file will be overwritten the 
-- next time the XSL Transformation is run.

deferred class
	GOA_COMMON_XML_DOCUMENT
	
inherit
	GOA_XML_DOCUMENT
	GOA_COMMON_ATTRIBUTE_VALUES
		
	
feature -- Adding Elements

	start_paragraph_element (new_class: STRING; ) is
			-- Start a new goa_common:paragraph element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_paragraph: ok_to_add_element_or_text (paragraph_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = paragraph_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	add_text_item_element (choice_N7N21N0_name_code: INTEGER; choice_N7N21N0_value: STRING; text_to_add: STRING) is
			--Add a new goa_common:text_item element to the xml document
			-- Use the attribute name code xml_null_code to indicate a null attribute for the choice
		require
			ok_to_add_text_item: ok_to_add_element_or_text (text_item_element_code)
			is_valid_choice_N7N21N0_name_code: choice_N7N21N0_name_code /= xml_null_code implies (create {ARRAY[INTEGER]}.make_from_array (<<class_attribute_code, span_attribute_code>>)).has (choice_N7N21N0_name_code)
			valid_value_if_class: choice_N7N21N0_name_code = class_attribute_code implies is_valid_attribute_value (class_attribute_code, choice_N7N21N0_value)
			valid_value_if_span: choice_N7N21N0_name_code = span_attribute_code implies is_valid_attribute_value (span_attribute_code, choice_N7N21N0_value)
		deferred
		ensure
			current_element_unchanged: current_element_code = old current_element_code
			open_element_count_unchanged: element_stack.count = old element_stack.count
			current_element_contents_updated: current_element_contents.count = (old current_element_contents.count + 1) and current_element_contents @ current_element_contents.upper = text_item_element_code
		end

	start_division_element (new_class: STRING; ) is
			-- Start a new goa_common:division element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_division: ok_to_add_element_or_text (division_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = division_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	start_ordered_list_element (new_class: STRING; ) is
			-- Start a new goa_common:ordered_list element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_ordered_list: ok_to_add_element_or_text (ordered_list_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = ordered_list_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	start_list_item_element (new_class: STRING; ) is
			-- Start a new goa_common:list_item element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_list_item: ok_to_add_element_or_text (list_item_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = list_item_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	start_unordered_list_element (new_class: STRING; ) is
			-- Start a new goa_common:unordered_list element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_unordered_list: ok_to_add_element_or_text (unordered_list_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = unordered_list_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	start_hyperlink_element (new_class: STRING; new_url: STRING; ) is
			-- Start a new goa_common:hyperlink element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_hyperlink: ok_to_add_element_or_text (hyperlink_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			is_valid_value_new_url: new_url /= Void implies is_valid_attribute_value (url_attribute_code, new_url)
			valid_new_url: new_url /= Void
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = hyperlink_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	add_popup_hyperlink_element (new_class: STRING; new_url: STRING; text_to_add: STRING) is
			--Add a new goa_common:popup_hyperlink element to the xml document
		require
			ok_to_add_popup_hyperlink: ok_to_add_element_or_text (popup_hyperlink_element_code)
			valid_text_to_add: text_to_add /= Void and then not text_to_add.is_empty
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			is_valid_value_new_url: new_url /= Void implies is_valid_attribute_value (url_attribute_code, new_url)
			valid_new_url: new_url /= Void
		deferred
		ensure
			current_element_unchanged: current_element_code = old current_element_code
			open_element_count_unchanged: element_stack.count = old element_stack.count
			current_element_contents_updated: current_element_contents.count = (old current_element_contents.count + 1) and current_element_contents @ current_element_contents.upper = popup_hyperlink_element_code
		end

	start_table_element (new_class: STRING; new_cellspacing: STRING; new_cellpadding: STRING; new_summary: STRING; ) is
			-- Start a new goa_common:table element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_table: ok_to_add_element_or_text (table_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			is_valid_value_new_cellspacing: new_cellspacing /= Void implies is_valid_attribute_value (cellspacing_attribute_code, new_cellspacing)
			is_valid_value_new_cellpadding: new_cellpadding /= Void implies is_valid_attribute_value (cellpadding_attribute_code, new_cellpadding)
			is_valid_value_new_summary: new_summary /= Void implies is_valid_attribute_value (summary_attribute_code, new_summary)
			valid_new_summary: new_summary /= Void
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = table_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	start_header_element (new_class: STRING; ) is
			-- Start a new goa_common:header element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_header: ok_to_add_element_or_text (header_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = header_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	start_row_element (new_class: STRING; ) is
			-- Start a new goa_common:row element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_row: ok_to_add_element_or_text (row_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = row_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	start_cell_element (new_class: STRING; new_colspan: STRING; ) is
			-- Start a new goa_common:cell element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_cell: ok_to_add_element_or_text (cell_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			is_valid_value_new_colspan: new_colspan /= Void implies is_valid_attribute_value (colspan_attribute_code, new_colspan)
			valid_new_colspan: new_colspan /= Void
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = cell_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	start_footer_element (new_class: STRING; ) is
			-- Start a new goa_common:footer element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_footer: ok_to_add_element_or_text (footer_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = footer_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	start_body_element (new_class: STRING; ) is
			-- Start a new goa_common:body element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_body: ok_to_add_element_or_text (body_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = body_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	add_hidden_element (new_name: STRING; new_value: STRING; ) is
			--Add a new goa_common:hidden element to the xml document
		require
			ok_to_add_hidden: ok_to_add_element_or_text (hidden_element_code)
			is_valid_value_new_name: new_name /= Void implies is_valid_attribute_value (name_attribute_code, new_name)
			valid_new_name: new_name /= Void
			is_valid_value_new_value: new_value /= Void implies is_valid_attribute_value (value_attribute_code, new_value)
			valid_new_value: new_value /= Void
		deferred
		ensure
			current_element_unchanged: current_element_code = old current_element_code
			open_element_count_unchanged: element_stack.count = old element_stack.count
			current_element_contents_updated: current_element_contents.count = (old current_element_contents.count + 1) and current_element_contents @ current_element_contents.upper = hidden_element_code
		end

	add_input_element (new_class: STRING; new_name: STRING; new_type: STRING; new_disabled: STRING; new_maxlength: STRING; new_size: STRING; new_value: STRING; ) is
			--Add a new goa_common:input element to the xml document
		require
			ok_to_add_input: ok_to_add_element_or_text (input_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			is_valid_value_new_name: new_name /= Void implies is_valid_attribute_value (name_attribute_code, new_name)
			valid_new_name: new_name /= Void
			is_valid_value_new_type: new_type /= Void implies is_valid_attribute_value (type_attribute_code, new_type)
			valid_new_type: new_type /= Void
			is_valid_value_new_disabled: new_disabled /= Void implies is_valid_attribute_value (disabled_attribute_code, new_disabled)
			valid_new_disabled: new_disabled /= Void
			is_valid_value_new_maxlength: new_maxlength /= Void implies is_valid_attribute_value (maxlength_attribute_code, new_maxlength)
			is_valid_value_new_size: new_size /= Void implies is_valid_attribute_value (size_attribute_code, new_size)
			is_valid_value_new_value: new_value /= Void implies is_valid_attribute_value (value_attribute_code, new_value)
			valid_new_value: new_value /= Void
		deferred
		ensure
			current_element_unchanged: current_element_code = old current_element_code
			open_element_count_unchanged: element_stack.count = old element_stack.count
			current_element_contents_updated: current_element_contents.count = (old current_element_contents.count + 1) and current_element_contents @ current_element_contents.upper = input_element_code
		end

	add_submit_element (new_class: STRING; new_name: STRING; new_value: STRING; new_on_click_script: STRING; ) is
			--Add a new goa_common:submit element to the xml document
		require
			ok_to_add_submit: ok_to_add_element_or_text (submit_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			is_valid_value_new_name: new_name /= Void implies is_valid_attribute_value (name_attribute_code, new_name)
			valid_new_name: new_name /= Void
			is_valid_value_new_value: new_value /= Void implies is_valid_attribute_value (value_attribute_code, new_value)
			valid_new_value: new_value /= Void
			is_valid_value_new_on_click_script: new_on_click_script /= Void implies is_valid_attribute_value (on_click_script_attribute_code, new_on_click_script)
		deferred
		ensure
			current_element_unchanged: current_element_code = old current_element_code
			open_element_count_unchanged: element_stack.count = old element_stack.count
			current_element_contents_updated: current_element_contents.count = (old current_element_contents.count + 1) and current_element_contents @ current_element_contents.upper = submit_element_code
		end

	add_radio_element (new_class: STRING; new_name: STRING; new_value: STRING; new_checked: STRING; new_disabled: STRING; ) is
			--Add a new goa_common:radio element to the xml document
		require
			ok_to_add_radio: ok_to_add_element_or_text (radio_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			is_valid_value_new_name: new_name /= Void implies is_valid_attribute_value (name_attribute_code, new_name)
			valid_new_name: new_name /= Void
			is_valid_value_new_value: new_value /= Void implies is_valid_attribute_value (value_attribute_code, new_value)
			valid_new_value: new_value /= Void
			is_valid_value_new_checked: new_checked /= Void implies is_valid_attribute_value (checked_attribute_code, new_checked)
			valid_new_checked: new_checked /= Void
			is_valid_value_new_disabled: new_disabled /= Void implies is_valid_attribute_value (disabled_attribute_code, new_disabled)
			valid_new_disabled: new_disabled /= Void
		deferred
		ensure
			current_element_unchanged: current_element_code = old current_element_code
			open_element_count_unchanged: element_stack.count = old element_stack.count
			current_element_contents_updated: current_element_contents.count = (old current_element_contents.count + 1) and current_element_contents @ current_element_contents.upper = radio_element_code
		end

	add_checkbox_element (new_class: STRING; new_name: STRING; new_checked: STRING; new_disabled: STRING; new_on_click_script: STRING; ) is
			--Add a new goa_common:checkbox element to the xml document
		require
			ok_to_add_checkbox: ok_to_add_element_or_text (checkbox_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			is_valid_value_new_name: new_name /= Void implies is_valid_attribute_value (name_attribute_code, new_name)
			valid_new_name: new_name /= Void
			is_valid_value_new_checked: new_checked /= Void implies is_valid_attribute_value (checked_attribute_code, new_checked)
			valid_new_checked: new_checked /= Void
			is_valid_value_new_disabled: new_disabled /= Void implies is_valid_attribute_value (disabled_attribute_code, new_disabled)
			valid_new_disabled: new_disabled /= Void
			is_valid_value_new_on_click_script: new_on_click_script /= Void implies is_valid_attribute_value (on_click_script_attribute_code, new_on_click_script)
		deferred
		ensure
			current_element_unchanged: current_element_code = old current_element_code
			open_element_count_unchanged: element_stack.count = old element_stack.count
			current_element_contents_updated: current_element_contents.count = (old current_element_contents.count + 1) and current_element_contents @ current_element_contents.upper = checkbox_element_code
		end

	start_select_element (new_class: STRING; new_name: STRING; new_disabled: STRING; new_multiple: STRING; new_size: STRING; new_on_click_script: STRING; ) is
			-- Start a new goa_common:select element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_select: ok_to_add_element_or_text (select_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			is_valid_value_new_name: new_name /= Void implies is_valid_attribute_value (name_attribute_code, new_name)
			valid_new_name: new_name /= Void
			is_valid_value_new_disabled: new_disabled /= Void implies is_valid_attribute_value (disabled_attribute_code, new_disabled)
			valid_new_disabled: new_disabled /= Void
			is_valid_value_new_multiple: new_multiple /= Void implies is_valid_attribute_value (multiple_attribute_code, new_multiple)
			is_valid_value_new_size: new_size /= Void implies is_valid_attribute_value (size_attribute_code, new_size)
			is_valid_value_new_on_click_script: new_on_click_script /= Void implies is_valid_attribute_value (on_click_script_attribute_code, new_on_click_script)
		deferred
		ensure
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = select_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end

	add_option_element (new_value: STRING; new_selected: STRING; text_to_add: STRING) is
			--Add a new goa_common:option element to the xml document
		require
			ok_to_add_option: ok_to_add_element_or_text (option_element_code)
			valid_text_to_add: text_to_add /= Void and then not text_to_add.is_empty
			is_valid_value_new_value: new_value /= Void implies is_valid_attribute_value (value_attribute_code, new_value)
			valid_new_value: new_value /= Void
			is_valid_value_new_selected: new_selected /= Void implies is_valid_attribute_value (selected_attribute_code, new_selected)
		deferred
		ensure
			current_element_unchanged: current_element_code = old current_element_code
			open_element_count_unchanged: element_stack.count = old element_stack.count
			current_element_contents_updated: current_element_contents.count = (old current_element_contents.count + 1) and current_element_contents @ current_element_contents.upper = option_element_code
		end

	add_text_area_element (new_class: STRING; new_name: STRING; new_rows: STRING; new_columns: STRING; text_to_add: STRING) is
			--Add a new goa_common:text_area element to the xml document
		require
			ok_to_add_text_area: ok_to_add_element_or_text (text_area_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			is_valid_value_new_name: new_name /= Void implies is_valid_attribute_value (name_attribute_code, new_name)
			valid_new_name: new_name /= Void
			is_valid_value_new_rows: new_rows /= Void implies is_valid_attribute_value (rows_attribute_code, new_rows)
			valid_new_rows: new_rows /= Void
			is_valid_value_new_columns: new_columns /= Void implies is_valid_attribute_value (columns_attribute_code, new_columns)
			valid_new_columns: new_columns /= Void
		deferred
		ensure
			current_element_unchanged: current_element_code = old current_element_code
			open_element_count_unchanged: element_stack.count = old element_stack.count
			current_element_contents_updated: current_element_contents.count = (old current_element_contents.count + 1) and current_element_contents @ current_element_contents.upper = text_area_element_code
		end

	add_image_element (new_class: STRING; new_url: STRING; new_alternate_text: STRING; new_height: STRING; new_width: STRING; ) is
			--Add a new goa_common:image element to the xml document
		require
			ok_to_add_image: ok_to_add_element_or_text (image_element_code)
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			is_valid_value_new_url: new_url /= Void implies is_valid_attribute_value (url_attribute_code, new_url)
			valid_new_url: new_url /= Void
			is_valid_value_new_alternate_text: new_alternate_text /= Void implies is_valid_attribute_value (alternate_text_attribute_code, new_alternate_text)
			valid_new_alternate_text: new_alternate_text /= Void
			is_valid_value_new_height: new_height /= Void implies is_valid_attribute_value (height_attribute_code, new_height)
			valid_new_height: new_height /= Void
			is_valid_value_new_width: new_width /= Void implies is_valid_attribute_value (width_attribute_code, new_width)
			valid_new_width: new_width /= Void
		deferred
		ensure
			current_element_unchanged: current_element_code = old current_element_code
			open_element_count_unchanged: element_stack.count = old element_stack.count
			current_element_contents_updated: current_element_contents.count = (old current_element_contents.count + 1) and current_element_contents @ current_element_contents.upper = image_element_code
		end

	add_tool_tip_element (new_class: STRING; text_to_add: STRING) is
			--Add a new goa_common:tool_tip element to the xml document
		require
			ok_to_add_tool_tip: ok_to_add_element_or_text (tool_tip_element_code)
			valid_text_to_add: text_to_add /= Void and then not text_to_add.is_empty
			is_valid_value_new_class: new_class /= Void implies is_valid_attribute_value (class_attribute_code, new_class)
			valid_new_class: new_class /= Void
		deferred
		ensure
			current_element_unchanged: current_element_code = old current_element_code
			open_element_count_unchanged: element_stack.count = old element_stack.count
			current_element_contents_updated: current_element_contents.count = (old current_element_contents.count + 1) and current_element_contents @ current_element_contents.upper = tool_tip_element_code
		end



feature -- Element Tags

		paragraph_element_tag: STRING is 
		deferred
		end

	text_item_element_tag: STRING is 
		deferred
		end

	division_element_tag: STRING is 
		deferred
		end

	ordered_list_element_tag: STRING is 
		deferred
		end

	list_item_element_tag: STRING is 
		deferred
		end

	unordered_list_element_tag: STRING is 
		deferred
		end

	hyperlink_element_tag: STRING is 
		deferred
		end

	popup_hyperlink_element_tag: STRING is 
		deferred
		end

	table_element_tag: STRING is 
		deferred
		end

	header_element_tag: STRING is 
		deferred
		end

	row_element_tag: STRING is 
		deferred
		end

	cell_element_tag: STRING is 
		deferred
		end

	footer_element_tag: STRING is 
		deferred
		end

	body_element_tag: STRING is 
		deferred
		end

	hidden_element_tag: STRING is 
		deferred
		end

	input_element_tag: STRING is 
		deferred
		end

	submit_element_tag: STRING is 
		deferred
		end

	radio_element_tag: STRING is 
		deferred
		end

	checkbox_element_tag: STRING is 
		deferred
		end

	select_element_tag: STRING is 
		deferred
		end

	option_element_tag: STRING is 
		deferred
		end

	text_area_element_tag: STRING is 
		deferred
		end

	image_element_tag: STRING is 
		deferred
		end

	tool_tip_element_tag: STRING is 
		deferred
		end

	
 	
feature -- Attribute Names

		span_attribute_name: STRING is
		deferred
		end

	palette_attribute_name: STRING is
		deferred
		end

	summary_attribute_name: STRING is
		deferred
		end

	cellspacing_attribute_name: STRING is
		deferred
		end

	cellpadding_attribute_name: STRING is
		deferred
		end

	colspan_attribute_name: STRING is
		deferred
		end

	name_attribute_name: STRING is
		deferred
		end

	type_attribute_name: STRING is
		deferred
		end

	maxlength_attribute_name: STRING is
		deferred
		end

	size_attribute_name: STRING is
		deferred
		end

	disabled_attribute_name: STRING is
		deferred
		end

	value_attribute_name: STRING is
		deferred
		end

	checked_attribute_name: STRING is
		deferred
		end

	on_click_script_attribute_name: STRING is
		deferred
		end

	multiple_attribute_name: STRING is
		deferred
		end

	selected_attribute_name: STRING is
		deferred
		end

	rows_attribute_name: STRING is
		deferred
		end

	columns_attribute_name: STRING is
		deferred
		end

	url_attribute_name: STRING is
		deferred
		end

	alternate_text_attribute_name: STRING is
		deferred
		end

	height_attribute_name: STRING is
		deferred
		end

	width_attribute_name: STRING is
		deferred
		end

	page_title_attribute_name: STRING is
		deferred
		end

	style_sheet_attribute_name: STRING is
		deferred
		end

	class_attribute_name: STRING is
		deferred
		end

	

feature -- Codes

		span_attribute_code: INTEGER is
		deferred
		end

	palette_attribute_code: INTEGER is
		deferred
		end

	summary_attribute_code: INTEGER is
		deferred
		end

	cellspacing_attribute_code: INTEGER is
		deferred
		end

	cellpadding_attribute_code: INTEGER is
		deferred
		end

	colspan_attribute_code: INTEGER is
		deferred
		end

	name_attribute_code: INTEGER is
		deferred
		end

	type_attribute_code: INTEGER is
		deferred
		end

	maxlength_attribute_code: INTEGER is
		deferred
		end

	size_attribute_code: INTEGER is
		deferred
		end

	disabled_attribute_code: INTEGER is
		deferred
		end

	value_attribute_code: INTEGER is
		deferred
		end

	checked_attribute_code: INTEGER is
		deferred
		end

	on_click_script_attribute_code: INTEGER is
		deferred
		end

	multiple_attribute_code: INTEGER is
		deferred
		end

	selected_attribute_code: INTEGER is
		deferred
		end

	rows_attribute_code: INTEGER is
		deferred
		end

	columns_attribute_code: INTEGER is
		deferred
		end

	url_attribute_code: INTEGER is
		deferred
		end

	alternate_text_attribute_code: INTEGER is
		deferred
		end

	height_attribute_code: INTEGER is
		deferred
		end

	width_attribute_code: INTEGER is
		deferred
		end

	page_title_attribute_code: INTEGER is
		deferred
		end

	style_sheet_attribute_code: INTEGER is
		deferred
		end

	class_attribute_code: INTEGER is
		deferred
		end

	paragraph_element_code: INTEGER is
		deferred
		end

	text_item_element_code: INTEGER is
		deferred
		end

	division_element_code: INTEGER is
		deferred
		end

	ordered_list_element_code: INTEGER is
		deferred
		end

	list_item_element_code: INTEGER is
		deferred
		end

	unordered_list_element_code: INTEGER is
		deferred
		end

	hyperlink_element_code: INTEGER is
		deferred
		end

	popup_hyperlink_element_code: INTEGER is
		deferred
		end

	table_element_code: INTEGER is
		deferred
		end

	header_element_code: INTEGER is
		deferred
		end

	row_element_code: INTEGER is
		deferred
		end

	cell_element_code: INTEGER is
		deferred
		end

	footer_element_code: INTEGER is
		deferred
		end

	body_element_code: INTEGER is
		deferred
		end

	hidden_element_code: INTEGER is
		deferred
		end

	input_element_code: INTEGER is
		deferred
		end

	submit_element_code: INTEGER is
		deferred
		end

	radio_element_code: INTEGER is
		deferred
		end

	checkbox_element_code: INTEGER is
		deferred
		end

	select_element_code: INTEGER is
		deferred
		end

	option_element_code: INTEGER is
		deferred
		end

	text_area_element_code: INTEGER is
		deferred
		end

	image_element_code: INTEGER is
		deferred
		end

	tool_tip_element_code: INTEGER is
		deferred
		end



end -- GOA_COMMON_XML_DOCUMENT

