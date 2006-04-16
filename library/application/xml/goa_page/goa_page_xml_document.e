

indexing

	description: "An XML Document conforming with the xmlns:goa_page schema"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	copyright: ""
	license: ""
	
-- DO NOT EDIT THIS FILE
-- This file was generated by validating_xml_writer.xsl
-- Any changes made to this file will be overwritten the 
-- next time the XSL Transformation is run.

class
	GOA_PAGE_XML_DOCUMENT
	
inherit
	GOA_PAGE_SCHEMA_CODES
	GOA_PAGE_ATTRIBUTE_VALUES
	GOA_XML_DOCUMENT
	GOA_COMMON_XML_DOCUMENT_EXTENDED
	
creation

	make_iso_8859_1_encoded, make_utf8_encoded

feature -- Adding Elements

	start_paragraph_element (new_class: STRING; ) is
			-- Start a new goa_common:paragraph element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (paragraph_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			current_element_contents.force (paragraph_element_code, current_element_contents.upper + 1)
			element_stack.put (paragraph_element_code)
			contents_stack.put (<<>>)
		end

	add_text_item_element (choice_N1_name_code: INTEGER; choice_N1_value: STRING; text_to_add: STRING) is
			--Add a new goa_common:text_item element to the xml document
			-- Use the attribute name code xml_null_code to indicate a null attribute for the choice
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (text_item_element_code))
			if choice_N1_name_code /= xml_null_code then
				writer.set_attribute (attribute_name_for_code (choice_N1_name_code), choice_N1_value)
			end
			if text_to_add /= Void then
				writer.add_data (text_to_add)
			end
			current_element_contents.force (text_item_element_code, current_element_contents.upper + 1)
			writer.stop_tag
		end

	start_division_element (new_class: STRING; ) is
			-- Start a new goa_common:division element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (division_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			current_element_contents.force (division_element_code, current_element_contents.upper + 1)
			element_stack.put (division_element_code)
			contents_stack.put (<<>>)
		end

	start_ordered_list_element (new_class: STRING; ) is
			-- Start a new goa_common:ordered_list element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (ordered_list_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			current_element_contents.force (ordered_list_element_code, current_element_contents.upper + 1)
			element_stack.put (ordered_list_element_code)
			contents_stack.put (<<>>)
		end

	start_list_item_element (new_class: STRING; ) is
			-- Start a new goa_common:list_item element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (list_item_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			current_element_contents.force (list_item_element_code, current_element_contents.upper + 1)
			element_stack.put (list_item_element_code)
			contents_stack.put (<<>>)
		end

	start_unordered_list_element (new_class: STRING; ) is
			-- Start a new goa_common:unordered_list element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (unordered_list_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			current_element_contents.force (unordered_list_element_code, current_element_contents.upper + 1)
			element_stack.put (unordered_list_element_code)
			contents_stack.put (<<>>)
		end

	start_hyperlink_element (new_class: STRING; new_url: STRING; ) is
			-- Start a new goa_common:hyperlink element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (hyperlink_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if new_url /= Void then
				writer.set_attribute (attribute_name_for_code (url_attribute_code), new_url)
			end
			current_element_contents.force (hyperlink_element_code, current_element_contents.upper + 1)
			element_stack.put (hyperlink_element_code)
			contents_stack.put (<<>>)
		end

	add_popup_hyperlink_element (new_class: STRING; new_url: STRING; text_to_add: STRING) is
			--Add a new goa_common:popup_hyperlink element to the xml document
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (popup_hyperlink_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if new_url /= Void then
				writer.set_attribute (attribute_name_for_code (url_attribute_code), new_url)
			end
			if text_to_add /= Void then
				writer.add_data (text_to_add)
			end
			current_element_contents.force (popup_hyperlink_element_code, current_element_contents.upper + 1)
			writer.stop_tag
		end

	start_table_element (new_class: STRING; new_cellspacing: STRING; new_cellpadding: STRING; new_summary: STRING; ) is
			-- Start a new goa_common:table element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (table_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if new_cellspacing /= Void then
				writer.set_attribute (attribute_name_for_code (cellspacing_attribute_code), new_cellspacing)
			end
			if new_cellpadding /= Void then
				writer.set_attribute (attribute_name_for_code (cellpadding_attribute_code), new_cellpadding)
			end
			if new_summary /= Void then
				writer.set_attribute (attribute_name_for_code (summary_attribute_code), new_summary)
			end
			current_element_contents.force (table_element_code, current_element_contents.upper + 1)
			element_stack.put (table_element_code)
			contents_stack.put (<<>>)
		end

	start_header_element (new_class: STRING; ) is
			-- Start a new goa_common:header element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (header_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			current_element_contents.force (header_element_code, current_element_contents.upper + 1)
			element_stack.put (header_element_code)
			contents_stack.put (<<>>)
		end

	start_row_element (new_class: STRING; ) is
			-- Start a new goa_common:row element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (row_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			current_element_contents.force (row_element_code, current_element_contents.upper + 1)
			element_stack.put (row_element_code)
			contents_stack.put (<<>>)
		end

	start_cell_element (new_class: STRING; new_colspan: STRING; ) is
			-- Start a new goa_common:cell element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (cell_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if new_colspan /= Void then
				writer.set_attribute (attribute_name_for_code (colspan_attribute_code), new_colspan)
			end
			current_element_contents.force (cell_element_code, current_element_contents.upper + 1)
			element_stack.put (cell_element_code)
			contents_stack.put (<<>>)
		end

	start_footer_element (new_class: STRING; ) is
			-- Start a new goa_common:footer element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (footer_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			current_element_contents.force (footer_element_code, current_element_contents.upper + 1)
			element_stack.put (footer_element_code)
			contents_stack.put (<<>>)
		end

	start_body_element (new_class: STRING; ) is
			-- Start a new goa_common:body element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (body_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			current_element_contents.force (body_element_code, current_element_contents.upper + 1)
			element_stack.put (body_element_code)
			contents_stack.put (<<>>)
		end

	add_hidden_element (new_name: STRING; new_value: STRING; ) is
			--Add a new goa_common:hidden element to the xml document
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (hidden_element_code))
			if new_name /= Void then
				writer.set_attribute (attribute_name_for_code (name_attribute_code), new_name)
			end
			if new_value /= Void then
				writer.set_attribute (attribute_name_for_code (value_attribute_code), new_value)
			end
			current_element_contents.force (hidden_element_code, current_element_contents.upper + 1)
			writer.stop_tag
		end

	add_input_element (new_class: STRING; new_name: STRING; new_type: STRING; new_disabled: STRING; new_maxlength: STRING; new_size: STRING; new_value: STRING; ) is
			--Add a new goa_common:input element to the xml document
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (input_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if new_name /= Void then
				writer.set_attribute (attribute_name_for_code (name_attribute_code), new_name)
			end
			if new_type /= Void then
				writer.set_attribute (attribute_name_for_code (type_attribute_code), new_type)
			end
			if new_disabled /= Void then
				writer.set_attribute (attribute_name_for_code (disabled_attribute_code), new_disabled)
			end
			if new_maxlength /= Void then
				writer.set_attribute (attribute_name_for_code (maxlength_attribute_code), new_maxlength)
			end
			if new_size /= Void then
				writer.set_attribute (attribute_name_for_code (size_attribute_code), new_size)
			end
			if new_value /= Void then
				writer.set_attribute (attribute_name_for_code (value_attribute_code), new_value)
			end
			current_element_contents.force (input_element_code, current_element_contents.upper + 1)
			writer.stop_tag
		end

	add_submit_element (new_class: STRING; new_name: STRING; new_value: STRING; new_on_click_script: STRING; ) is
			--Add a new goa_common:submit element to the xml document
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (submit_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if new_name /= Void then
				writer.set_attribute (attribute_name_for_code (name_attribute_code), new_name)
			end
			if new_value /= Void then
				writer.set_attribute (attribute_name_for_code (value_attribute_code), new_value)
			end
			if new_on_click_script /= Void then
				writer.set_attribute (attribute_name_for_code (on_click_script_attribute_code), new_on_click_script)
			end
			current_element_contents.force (submit_element_code, current_element_contents.upper + 1)
			writer.stop_tag
		end

	add_radio_element (new_class: STRING; new_name: STRING; new_value: STRING; new_checked: STRING; ) is
			--Add a new goa_common:radio element to the xml document
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (radio_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if new_name /= Void then
				writer.set_attribute (attribute_name_for_code (name_attribute_code), new_name)
			end
			if new_value /= Void then
				writer.set_attribute (attribute_name_for_code (value_attribute_code), new_value)
			end
			if new_checked /= Void then
				writer.set_attribute (attribute_name_for_code (checked_attribute_code), new_checked)
			end
			current_element_contents.force (radio_element_code, current_element_contents.upper + 1)
			writer.stop_tag
		end

	add_checkbox_element (new_class: STRING; new_name: STRING; new_checked: STRING; new_disabled: STRING; new_on_click_script: STRING; ) is
			--Add a new goa_common:checkbox element to the xml document
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (checkbox_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if new_name /= Void then
				writer.set_attribute (attribute_name_for_code (name_attribute_code), new_name)
			end
			if new_checked /= Void then
				writer.set_attribute (attribute_name_for_code (checked_attribute_code), new_checked)
			end
			if new_disabled /= Void then
				writer.set_attribute (attribute_name_for_code (disabled_attribute_code), new_disabled)
			end
			if new_on_click_script /= Void then
				writer.set_attribute (attribute_name_for_code (on_click_script_attribute_code), new_on_click_script)
			end
			current_element_contents.force (checkbox_element_code, current_element_contents.upper + 1)
			writer.stop_tag
		end

	start_select_element (new_class: STRING; new_name: STRING; new_disabled: STRING; new_multiple: STRING; new_size: STRING; new_on_click_script: STRING; ) is
			-- Start a new goa_common:select element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (select_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if new_name /= Void then
				writer.set_attribute (attribute_name_for_code (name_attribute_code), new_name)
			end
			if new_disabled /= Void then
				writer.set_attribute (attribute_name_for_code (disabled_attribute_code), new_disabled)
			end
			if new_multiple /= Void then
				writer.set_attribute (attribute_name_for_code (multiple_attribute_code), new_multiple)
			end
			if new_size /= Void then
				writer.set_attribute (attribute_name_for_code (size_attribute_code), new_size)
			end
			if new_on_click_script /= Void then
				writer.set_attribute (attribute_name_for_code (on_click_script_attribute_code), new_on_click_script)
			end
			current_element_contents.force (select_element_code, current_element_contents.upper + 1)
			element_stack.put (select_element_code)
			contents_stack.put (<<>>)
		end

	add_option_element (new_value: STRING; new_selected: STRING; text_to_add: STRING) is
			--Add a new goa_common:option element to the xml document
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (option_element_code))
			if new_value /= Void then
				writer.set_attribute (attribute_name_for_code (value_attribute_code), new_value)
			end
			if new_selected /= Void then
				writer.set_attribute (attribute_name_for_code (selected_attribute_code), new_selected)
			end
			if text_to_add /= Void then
				writer.add_data (text_to_add)
			end
			current_element_contents.force (option_element_code, current_element_contents.upper + 1)
			writer.stop_tag
		end

	add_text_area_element (new_class: STRING; new_name: STRING; new_rows: STRING; new_columns: STRING; text_to_add: STRING) is
			--Add a new goa_common:text_area element to the xml document
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (text_area_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if new_name /= Void then
				writer.set_attribute (attribute_name_for_code (name_attribute_code), new_name)
			end
			if new_rows /= Void then
				writer.set_attribute (attribute_name_for_code (rows_attribute_code), new_rows)
			end
			if new_columns /= Void then
				writer.set_attribute (attribute_name_for_code (columns_attribute_code), new_columns)
			end
			if text_to_add /= Void then
				writer.add_data (text_to_add)
			end
			current_element_contents.force (text_area_element_code, current_element_contents.upper + 1)
			writer.stop_tag
		end

	add_image_element (new_class: STRING; new_url: STRING; new_alternate_text: STRING; new_height: STRING; new_width: STRING; ) is
			--Add a new goa_common:image element to the xml document
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (image_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if new_url /= Void then
				writer.set_attribute (attribute_name_for_code (url_attribute_code), new_url)
			end
			if new_alternate_text /= Void then
				writer.set_attribute (attribute_name_for_code (alternate_text_attribute_code), new_alternate_text)
			end
			if new_height /= Void then
				writer.set_attribute (attribute_name_for_code (height_attribute_code), new_height)
			end
			if new_width /= Void then
				writer.set_attribute (attribute_name_for_code (width_attribute_code), new_width)
			end
			current_element_contents.force (image_element_code, current_element_contents.upper + 1)
			writer.stop_tag
		end

	add_tool_tip_element (new_class: STRING; text_to_add: STRING) is
			--Add a new goa_common:tool_tip element to the xml document
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (tool_tip_element_code))
			if new_class /= Void then
				writer.set_attribute (attribute_name_for_code (class_attribute_code), new_class)
			end
			if text_to_add /= Void then
				writer.add_data (text_to_add)
			end
			current_element_contents.force (tool_tip_element_code, current_element_contents.upper + 1)
			writer.stop_tag
		end

	start_page_element (new_host_name: STRING; new_page_title: STRING; new_style_sheet: STRING; new_submit_url: STRING; ) is
			-- Start a new goa_page:page element to the xml document
			-- Use end_current_element when done adding sub-elements to this element
		require
			ok_to_add_page: not root_element_added
			is_valid_value_new_host_name: new_host_name /= Void implies is_valid_attribute_value (host_name_attribute_code, new_host_name)
			valid_new_host_name: new_host_name /= Void
			is_valid_value_new_page_title: new_page_title /= Void implies is_valid_attribute_value (page_title_attribute_code, new_page_title)
			valid_new_page_title: new_page_title /= Void
			is_valid_value_new_style_sheet: new_style_sheet /= Void implies is_valid_attribute_value (style_sheet_attribute_code, new_style_sheet)
			valid_new_style_sheet: new_style_sheet /= Void
			is_valid_value_new_submit_url: new_submit_url /= Void implies is_valid_attribute_value (submit_url_attribute_code, new_submit_url)
		local
			name_index, value_index: INTEGER
		do
			writer.start_ns_tag ("", element_tag_for_code (page_element_code))
			root_element_added := True
			writer.set_a_name_space ("goa_page", "http://www.sourceforge.net/projects/goanna/goa_page")
			writer.set_a_name_space ("goa_common", "http://www.sourceforge.net/projects/goanna/goa_common")
			if new_host_name /= Void then
				writer.set_attribute (attribute_name_for_code (host_name_attribute_code), new_host_name)
			end
			if new_page_title /= Void then
				writer.set_attribute (attribute_name_for_code (page_title_attribute_code), new_page_title)
			end
			if new_style_sheet /= Void then
				writer.set_attribute (attribute_name_for_code (style_sheet_attribute_code), new_style_sheet)
			end
			if new_submit_url /= Void then
				writer.set_attribute (attribute_name_for_code (submit_url_attribute_code), new_submit_url)
			end
			current_element_contents.force (page_element_code, current_element_contents.upper + 1)
			element_stack.put (page_element_code)
			contents_stack.put (<<>>)
		ensure
			root_element_added: root_element_added
			open_element_count_updated: element_stack.count = old element_stack.count + 1
			current_element_updated: current_element_code = page_element_code
			current_element_content_is_empty: current_element_contents.is_empty
		end



feature -- Element Validity
		
	is_valid_element_content_fragment (the_element_code: INTEGER; the_fragment: ARRAY [INTEGER]): BOOLEAN is
			-- Is the_fragment a valid valid element/text sequence in element given by the_element_code
		do
			inspect the_element_code
				when paragraph_element_code then
					Result := paragraph_content_validity.is_valid_content_fragment (the_fragment)
				when division_element_code then
					Result := division_content_validity.is_valid_content_fragment (the_fragment)
				when ordered_list_element_code then
					Result := ordered_list_content_validity.is_valid_content_fragment (the_fragment)
				when list_item_element_code then
					Result := list_item_content_validity.is_valid_content_fragment (the_fragment)
				when unordered_list_element_code then
					Result := unordered_list_content_validity.is_valid_content_fragment (the_fragment)
				when hyperlink_element_code then
					Result := hyperlink_content_validity.is_valid_content_fragment (the_fragment)
				when table_element_code then
					Result := table_content_validity.is_valid_content_fragment (the_fragment)
				when header_element_code then
					Result := header_content_validity.is_valid_content_fragment (the_fragment)
				when row_element_code then
					Result := row_content_validity.is_valid_content_fragment (the_fragment)
				when cell_element_code then
					Result := cell_content_validity.is_valid_content_fragment (the_fragment)
				when footer_element_code then
					Result := footer_content_validity.is_valid_content_fragment (the_fragment)
				when body_element_code then
					Result := body_content_validity.is_valid_content_fragment (the_fragment)
				when select_element_code then
					Result := select_content_validity.is_valid_content_fragment (the_fragment)
				when page_element_code then
					Result := page_content_validity.is_valid_content_fragment (the_fragment)
			else
				Result := False
			end
		end

	is_valid_element_content (the_element_code: INTEGER; the_content: ARRAY [INTEGER]): BOOLEAN is
			-- Is the_content a valid complete and valid element/text sequence in element given by the_element_code
		do
			inspect the_element_code
				when paragraph_element_code then
					Result := paragraph_content_validity.is_valid_content (the_content)
				when division_element_code then
					Result := division_content_validity.is_valid_content (the_content)
				when ordered_list_element_code then
					Result := ordered_list_content_validity.is_valid_content (the_content)
				when list_item_element_code then
					Result := list_item_content_validity.is_valid_content (the_content)
				when unordered_list_element_code then
					Result := unordered_list_content_validity.is_valid_content (the_content)
				when hyperlink_element_code then
					Result := hyperlink_content_validity.is_valid_content (the_content)
				when table_element_code then
					Result := table_content_validity.is_valid_content (the_content)
				when header_element_code then
					Result := header_content_validity.is_valid_content (the_content)
				when row_element_code then
					Result := row_content_validity.is_valid_content (the_content)
				when cell_element_code then
					Result := cell_content_validity.is_valid_content (the_content)
				when footer_element_code then
					Result := footer_content_validity.is_valid_content (the_content)
				when body_element_code then
					Result := body_content_validity.is_valid_content (the_content)
				when select_element_code then
					Result := select_content_validity.is_valid_content (the_content)
				when page_element_code then
					Result := page_content_validity.is_valid_content (the_content)
			else
				Result := False
			end
		end

feature -- {NONE} -- Element Content Validity

	paragraph_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) paragraph element
		once
			create Result.make
			Result.add_one_or_more_element (<<text_item_element_code, popup_hyperlink_element_code, hyperlink_element_code, submit_element_code, input_element_code, radio_element_code, select_element_code, text_area_element_code, image_element_code>>)
		end

	division_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) division element
		once
			create Result.make
			Result.add_one_or_more_element (<<paragraph_element_code, submit_element_code, division_element_code, hyperlink_element_code, text_item_element_code, input_element_code, hidden_element_code, radio_element_code, select_element_code, text_area_element_code, table_element_code, image_element_code>>)
		end

	ordered_list_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) ordered_list element
		once
			create Result.make
			Result.add_one_or_more_element (<<list_item_element_code>>)
		end

	list_item_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) list_item element
		once
			create Result.make
			Result.add_one_or_more_element (<<text_item_element_code, hyperlink_element_code, popup_hyperlink_element_code>>)
		end

	unordered_list_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) unordered_list element
		once
			create Result.make
			Result.add_one_or_more_element (<<list_item_element_code>>)
		end

	hyperlink_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) hyperlink element
		once
			create Result.make
			Result.add_optional_element (<<tool_tip_element_code>>)
			Result.add_required_element (<<xml_text_code>>)
		end

	table_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) table element
		once
			create Result.make
			Result.add_required_element (<<header_element_code>>)
			Result.add_required_element (<<footer_element_code>>)
			Result.add_required_element (<<body_element_code>>)
		end

	header_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) header element
		once
			create Result.make
			Result.add_zero_or_more_element (<<row_element_code>>)
		end

	row_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) row element
		once
			create Result.make
			Result.add_one_or_more_element (<<cell_element_code>>)
		end

	cell_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) cell element
		once
			create Result.make
			Result.add_zero_or_more_element (<<text_item_element_code, popup_hyperlink_element_code, hyperlink_element_code, submit_element_code, input_element_code, radio_element_code, checkbox_element_code, select_element_code, text_area_element_code, division_element_code>>)
		end

	footer_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) footer element
		once
			create Result.make
			Result.add_zero_or_more_element (<<row_element_code>>)
		end

	body_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) body element
		once
			create Result.make
			Result.add_zero_or_more_element (<<row_element_code>>)
		end

	select_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) select element
		once
			create Result.make
			Result.add_one_or_more_element (<<option_element_code>>)
		end

	page_content_validity: GOA_XML_ELEMENT_SCHEMA is
			-- Schema representing valid contents of a(n) page element
		once
			create Result.make
			Result.add_zero_or_more_element (<<paragraph_element_code, division_element_code, text_area_element_code, submit_element_code, hyperlink_element_code, text_item_element_code, ordered_list_element_code, unordered_list_element_code, hidden_element_code, popup_hyperlink_element_code, table_element_code, select_element_code, input_element_code, radio_element_code, image_element_code>>)
		end

	

feature {NONE} -- Transformation

	transform_file_name: STRING is
			-- Name of file containing the XSLT transform to produce an HTML version of this document
		once
			Result := configuration.data_directory + "goa_page.xsl"
		end

	schema_file_name: STRING is
			-- Name of the file containing the Relax NG Schema for this document
		once
			Result := configuration.data_directory + "goa_page.frng"
		end
				
end -- GOA_PAGE_XML_DOCUMENT

