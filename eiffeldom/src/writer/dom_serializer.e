indexing
	description: "Objects that can serialize a DOM to a STRING"
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOM_SERIALIZER

feature -- Initialization

	make is
			-- Create a new DOM serializer using the default format.
		do
			indent_amount := Default_indent
			line_separator := Default_line_separator
		end
		
feature -- Status report

	output: IO_MEDIUM
			-- Output stream to serialize to.

	indent_amount: INTEGER
			-- Line indent amount

	line_separator: STRING
			-- Line separator

	is_compact_format: BOOLEAN
			-- Is the serializer using the compact format.
			
feature -- Status setting

	set_output (output_medium: IO_MEDIUM) is
			-- Set the output stream that this serializer will write to.
		require
			output_medium_exists: output_medium /= Void			
		do
			output := output_medium
		ensure
			output_set: output = output_medium
		end
	
	set_compact_format is
			-- Set compact format
		do
			is_compact_format := True
		end
	
	set_pretty_format is
			-- Set pretty (indented) format
		do
			is_compact_format := False
		end
	
feature -- Serialization

	serialize (doc: DOM_DOCUMENT) is
			-- Serialize 'doc' to specified output medium.
		require
			output_exists: output /= Void
			doc_exists: doc /= Void
		deferred
		end
	
	serialize_node (node: DOM_NODE) is
			-- Serialize 'node' to specified output medium
		require
			output_exists: output /= Void
			node_exists: node /= Void
		deferred
		end
		
	serialize_element (element: DOM_ELEMENT) is
			-- Serialize 'element' to specified output medium
		require
			output_exists: output /= Void
			element_exists: element /= Void
		deferred			
		end
	
feature {NONE} -- Implementation
		
	Default_indent: INTEGER is 4
			-- Default indentation amount		
						
	Default_line_separator: STRING is "%R%N"
			-- Default line separator

invariant

	positive_indent: indent_amount >= 0
	line_separator_exists: line_separator /= Void
	
end -- class DOM_SERIALIZER
