indexing

	description: "Eiffel code generator for DOM structuros"
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class CODE_GENERATOR

inherit

	DOM_NODE_TYPE
		export
			{NONE} all
		end

creation

	make

feature -- Initialisation

	make (name: STRING; destination: STRING) is
			-- Create a new code generator to produce Eiffel code
			-- on 'destination.
		require
			name_exists: name /= Void
			destination_exists: destination/= Void
		do
			doc_name := name
			doc_name.to_upper
			create {PLAIN_TEXT_FILE} dest.make_open_write (destination)
		end

feature -- Generation

	generate (doc: DOM_DOCUMENT) is
			-- Create an Eiffel class to represent 'doc'
		require
			doc_exists: doc /= Void
		do
			document := doc
			create eiffel_code.make (doc_name + Xmle_class_name_extension)
			--build_indexing_clause
			build_inheritance_clause
			build_creation_routines
			build_build_document_routine
			eiffel_code.write (dest)
			dest.close
		end

feature {NONE} -- Implementation

	Xmle_class_name_extension: STRING is "_XMLE"

	doc_name: STRING
			-- Name of document

	dest: IO_MEDIUM
			-- Output medium to generate code to.

	document: DOM_DOCUMENT
			-- The document to produce

	eiffel_code: EIFFEL_CLASS
			-- The Eiffel code representation.

	build_indexing_clause is
			-- Generate indexing clause
		do
		end

	build_inheritance_clause is
			-- Build inheritance clause
		do
		end

	build_creation_routines is
			-- build creation clause and creation routines
		local
			feature_group: EIFFEL_FEATURE_GROUP
			make_feature: EIFFEL_ROUTINE
		do
			eiffel_code.add_creation_procedure_name ("make")
			-- build make procedure
			create feature_group.make ("Initialisation")
			eiffel_code.add_feature_group (feature_group)
			create make_feature.make ("make")
			make_feature.add_body_line ("build_document")
			feature_group.add_feature (make_feature)
		end
	
	build_build_document_routine is
			-- build the build document routine
		local
			feature_group: EIFFEL_FEATURE_GROUP
			var: DS_PAIR [STRING, STRING]
		do
			create feature_group.make ("Document construction")
			eiffel_code.add_feature_group (feature_group)
			-- create build document routine
			create build_doc.make ("build_document")
			feature_group.add_feature (build_doc)
			-- add creation of implementation
			create var.make ("impl", "DOM_IMPLEMENTATION")
			build_doc.add_local (var)
			build_doc.add_body_line ("create {DOM_IMPLEMENTATION_IMPL}.make")
			add_node_creation (document, 0)
		end		

	build_doc: EIFFEL_ROUTINE
			-- The routine representing the 'build_document' feature.

	add_node_creation (node: DOM_NODE; node_number: INTEGER) is
			-- Add creation instructions to 'build_doc' for 
			-- 'node' and recursively its children. Name the nodes with 'node_number' as
			-- a postfix.
		require
			node_exists: node /= Void
			positive_node_number: node_number >= 0
		local
			next_node_number: INTEGER
			nstr: STRING
			pair: DS_PAIR [STRING, STRING]
		do
			next_node_number := node_number
			nstr := next_node_number.out
			-- check node type and create appropriate local variable and 
			-- creation instruction
			inspect node.node_type
			when Attribute_node then
				-- create attribute node
				--build_doc.add_local (create pair.make ("node" + nstr, "DOM_ATTR")
				
			when Cdata_section_node then

			when Comment_node then
	
			when Document_fragment_node then

			when Document_node then
				create pair.make ("document", "DOM_DOCUMENT")
				build_doc.add_local (pair)
				create pair.make ("node" + nstr, "DOM_NODE")
				build_doc.add_local (pair)
				build_doc.add_body_line ("create dstr.make_from_string (%"%")")
				build_doc.add_body_line ("create dstr2.make_from_string (%"%")")
				build_doc.add_body_line ("document := impl.create_document (dstr, dstr2, Void)")
				build_doc.add_body_line ("node" + nstr + " := document")
			when Document_type_node then

			when Element_node then
					
			when Entity_node then

			when Entity_reference_node then

			when Notation_node then

			when Processing_instruction_node then

			when Text_node then
				
			else

			end
			-- add child node creation
			-- TODO: child nodes should never be Void. Check DOM impl.
			if node.has_child_nodes then
				next_node_number := add_child_creation (node, node_number) 
			end
		end
			
		add_child_creation (parent: DOM_NODE; node_number: INTEGER): INTEGER is
				-- add creation instructions for each child of 'parent'.
				-- Add 'append_node' instructions to add each child.
				-- Return the node number for the next node.
			require
				parent_exists: parent /= Void
				positive_node_number: node_number >= 0
			local
				child_nodes: DOM_NODE_LIST
				i: INTEGER
			do
				from
					Result := node_number + 1
					child_nodes := parent.child_nodes
					i := 0
				variant
					child_nodes.length - i
				until
					i >= child_nodes.length
				loop
					-- recursively add a node creation for the child
					add_node_creation (child_nodes.item (i), node_number)
					-- add instructions to append the newly created child to the parent
					build_doc.add_body_line ("node" + node_number.out + ".append_child (node" + Result.out)
					Result := Result + 1
					i := i + 1
				end
			end

end -- class CODE_GENERATOR

