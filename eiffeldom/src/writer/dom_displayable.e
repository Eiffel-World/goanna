indexing
	description: "DOM objects that can be displayed."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOM_DISPLAYABLE

inherit

	DOM_NODE_TYPE

feature -- Transformation

	output is
			-- Convenience function for debugging.
			-- String representation of node.
		do
			output_indented (0)
		end

feature {DOM_WRITER, DOM_NODE} -- Implementation

	output_indented (level: INTEGER) is
			-- Indented string representation of node.
		require
			positive_level: level >= 0
		deferred
		end

feature {NONE}

	make_indent (level: INTEGER): STRING is
			-- Create indentation string for 'level'
		require
			positive_level: level >= 0
		do
			create Result.make (level * 2)
			if level > 0 then
				Result.fill_character (' ')
			end
		ensure
			result_exists: Result /= Void
		end

	line_separator: STRING is
			-- Platform dependant line separator
		once
			Result := "%R%N"
		end

	node_type_string (type: INTEGER): STRING is
			-- Node type as string
		do
			inspect type
			when Attribute_node then
				Result := "Attribute"
			when Cdata_section_node then
				Result := "CDATASection"
			when Comment_node then
				Result := "Comment"
			when Document_fragment_node then
				Result := "DocumentFragment"
			when Document_node then
				Result := "Document"
			when Document_type_node then
				Result := "DocumentType"
			when Element_node then
				Result := "Element"
			when Entity_node then
				Result := "Entity"
			when Entity_reference_node then
				Result := "EntityReference"
			when Notation_node then
				Result := "Notation"
			when Processing_instruction_node then
				Result := "ProcessingInstruction"
			when Text_node then
				Result := "Text"
			else
				Result := "Unknown"
			end
		end

	non_void_string (str: UCSTRING): UCSTRING is
			-- If 'str' is Void, return the string "Void"
			-- Otherwise return 'str'
		do
			if str = Void then
				create Result.make_from_string ("Void")
			else
				Result := str
			end
		end

end -- class DOM_DISPLAYABLE
