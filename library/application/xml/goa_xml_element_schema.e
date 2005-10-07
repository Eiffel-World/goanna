indexing
	description: "A representation of the elements an XML element may contain)"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_XML_ELEMENT_SCHEMA
	
creation
	
	make
	
feature -- Query

	is_valid_content_fragment (the_fragment: ARRAY [INTEGER]): BOOLEAN is
			-- Does the_fragment represent a (valid) portion of the schema?
		local
			lower, upper, index: INTEGER
			required_multiple_element_is_present: BOOLEAN
		do
			lower := the_fragment.lower
			upper := the_fragment.upper
			from
				index := lower
				contents.start
				Result := True
			until
				the_fragment.is_empty or else index > upper or not Result
			loop
				Result := not contents.after and then contents.item_for_iteration.is_valid_element_code (the_fragment.item (index))
				if Result and contents.item_for_iteration.is_multiple_element then
					required_multiple_element_is_present := True
				end
				if not Result and ((not contents.item_for_iteration.is_required) or required_multiple_element_is_present) then
					required_multiple_element_is_present := False
					from
						contents.forth
						Result := not contents.after and then contents.item_for_iteration.is_valid_element_code (the_fragment.item (index))
					until
						contents.after or contents.item_for_iteration.is_required or Result
					loop					
						Result := not contents.after and then contents.item_for_iteration.is_valid_element_code (the_fragment.item (index))
						if not (contents.after or Result) then
							contents.forth
						end
					end
				end
				if Result and then not contents.after and then not contents.item_for_iteration.is_multiple_element then
					contents.forth
					required_multiple_element_is_present := False
				end
				index := index +1
				if contents.after and index <= upper then
					Result := False
				end
			end
			if Result and not contents.after and then contents.item_for_iteration.is_multiple_element then
				contents.forth
			end
		end
		
	is_valid_content (the_content: ARRAY [INTEGER]): BOOLEAN is
			-- Does the_content represent valid and complete content for this element?
		do
			if not the_content.is_empty then
				Result := is_valid_content_fragment (the_content)
			else
				Result := True
				contents.start
			end
			from
			until
				contents.after or not Result
			loop
				Result := not contents.item_for_iteration.is_required
				contents.forth
			end
		end

feature -- Schema Building

	add_required_element (new_element_codes: ARRAY [INTEGER]) is
			-- Add a new required element to this schema
		do
			contents.force_last (create {GOA_XML_SCHEMA_ELEMENT}.make_required (new_element_codes))
		end
		
	add_optional_element (new_element_codes: ARRAY [INTEGER]) is
			-- Add a new optional element to this schema
		do
			contents.force_last (create {GOA_XML_SCHEMA_ELEMENT}.make_optional (new_element_codes))
		end
		
	add_one_or_more_element (new_element_codes: ARRAY [INTEGER]) is
			-- Add a new one_or_more element to the schema
		do
			contents.force_last (create {GOA_XML_SCHEMA_ELEMENT}.make_one_or_more (new_element_codes))
		end
		
	add_zero_or_more_element (new_element_codes: ARRAY [INTEGER]) is
			-- Add a new one_or_more element to the schema
		do
			contents.force_last (create {GOA_XML_SCHEMA_ELEMENT}.make_zero_or_more (new_element_codes))
		end

feature {NONE} -- Implementation

	contents: DS_LINKED_LIST [GOA_XML_SCHEMA_ELEMENT]

feature {NONE} -- Creation

	make is
			-- Creation
		do
			create contents.make
		end

end -- class GOA_XML_ELEMENT_SCHEMA
