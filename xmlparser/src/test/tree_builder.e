indexing
   description: "DOM tree builder"

class
	TREE_BUILDER
      
creation
	make

feature -- Initialization

	make is
		local
			file_name: UCSTRING
			node_impl: DOM_NODE_IMPL
			writer: DOM_WRITER
		do
			create parser.make
			create file_name.make_from_string ("..\..\test.xml")
			parser.parse_from_file_name (file_name)

			node_impl ?= parser.document
			create writer
			writer.output(node_impl)
		end
   
feature {NONE} -- Implementation

	parser: DOM_TREE_BUILDER

end -- class TREE_BUILDER
