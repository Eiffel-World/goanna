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
		
feature -- Serialization

	serialise (doc: DOM_DOCUMENT) is
			-- Serialize 'doc' to specified output medium.
		require
			output_medium_set: output_medium /= Void
			doc_exists: doc /= Void
		deferred
		end
	
	serialize_element (element: DOM_ELEMENT) is
			-- Serialize 'element' to specified output medium
		require
			output_medium_set: output_medium /= Void
			element_exists: element /= Void
		deferred			
		end
	
feature {NONE} -- Implementation

	
	indent_amount: INTEGER
			-- Line indent amount
	
	Default_indent: INTEGER is 4
			-- Default indentation amount		
			
	line_separator: STRING
			-- Line separator
			
	Default_line_separator: STRING is "%R%N"
			-- Default line separator

invariant

	positive_indent: indent_amount >= 0
	line_separator_exists: line_separator /= Void
	
end -- class DOM_SERIALIZER
