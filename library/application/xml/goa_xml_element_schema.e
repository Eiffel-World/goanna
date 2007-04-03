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

	is_valid_content (the_fragment: ARRAY [INTEGER]): BOOLEAN is
			-- Does the_content represent a (valid) and complete content for this element?
		local
			al: DS_ARRAYED_LIST [INTEGER]
		do
			create al.make_from_array (the_fragment)
			al.start
			Result := content.is_valid_content_impl (al) and then al.after
		end

	is_valid_content_fragment (the_fragment: ARRAY [INTEGER]): BOOLEAN is
			-- Does the_fragment represent a (valid) portion of the schema?
		local
			al: DS_ARRAYED_LIST [INTEGER]
		do
			create al.make_from_array (the_fragment)
			al.start
			Result := content.is_valid_content_impl (al)
		end


feature {NONE} -- Implementation

	content: GOA_XML_DEERRED_SCHEMA_ELEMENT


feature {NONE} -- Creation

	make (new_content: GOA_XML_DEERRED_SCHEMA_ELEMENT) is
			-- creation
		require
			new_content_not_void: new_content /= Void
		do
			content := new_content
		end


invariant
	content_not_void: content /= Void

end -- class GOA_XML_ELEMENT_SCHEMA
