indexing
	description: "An item in an XML_ELEMENT_SCHEMA"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_XML_SCHEMA_ELEMENT

creation

	make_optional, make_required, make_zero_or_more, make_one_or_more

feature -- Query

	is_required: BOOLEAN
			-- Is this element required to be present for the parent element to be valid?

	is_multiple_element: BOOLEAN
			-- May this element be present multiple times in a valid parent element?

	is_valid_element_code (element_code: INTEGER): BOOLEAN is
			-- Does element_code represent a valid element at this location in the parent element?
		do
			Result := element_codes.has (element_code)
		end

feature {NONE} -- Implementation

	element_codes: ARRAY [INTEGER]
			-- The codes of all elements that are valid at this location in the parent element

feature {NONE} -- Creation

	make_optional (new_element_codes: ARRAY[INTEGER]) is
			-- Make an optional element
		require
			valid_new_element_codes: new_element_codes /= Void
		do
			is_required := False
			is_multiple_element := False
			element_codes := clone (new_element_codes)
		ensure
			element_codes_updated: equal (element_codes, new_element_codes)
		end

	make_required (new_element_codes: ARRAY[INTEGER]) is
			-- Make a required element
		require
			valid_new_element_codes: new_element_codes /= Void
		do
			element_codes := clone (new_element_codes)
			is_required :=  True
			is_multiple_element := False
		ensure
			element_codes_updated: equal (element_codes, new_element_codes)
		end

	make_zero_or_more (new_element_codes: ARRAY[INTEGER]) is
			-- Make a zero or element
		require
			valid_new_element_codes: new_element_codes /= Void
		do
			element_codes := clone (new_element_codes)
			is_required := False
			is_multiple_element := True
		ensure
			element_codes_updated: equal (element_codes, new_element_codes)
		end

	make_one_or_more (new_element_codes: ARRAY[INTEGER]) is
			-- Make a one or more element
		require
			valid_new_element_codes: new_element_codes /= Void
		do
			element_codes := clone (new_element_codes)
			is_required := True
			is_multiple_element := True
		ensure
			element_codes_updated: equal (element_codes, new_element_codes)
		end

invariant

	valid_element_codes: element_codes /= Void

end -- class GOA_XML_SCHEMA_ELEMENT
