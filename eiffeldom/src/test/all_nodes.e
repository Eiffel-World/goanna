indexing

	description: "Test class for compiling all DOM classes"

class ALL_NODES

creation

	make

feature

	make is
		local
			discard: DOM_NODE
		do
			-- bootstrap implementation
			create {DOM_IMPLEMENTATION_IMPL} impl

			-- create document
			doc := impl.create_document (create {DOM_STRING}.make_from_string ("http://test"),
				create {DOM_STRING}.make_from_string ("HTML"), Void)
			comment := doc.create_comment (create {DOM_STRING}.make_from_string ("This is a comment."))
			discard := doc.document_element.append_child (comment)
			head := doc.create_element (create {DOM_STRING}.make_from_string ("HEAD"))
			head.set_attribute (create {DOM_STRING}.make_from_string ("id"), 
				create {DOM_STRING}.make_from_string ("header"))
			head.set_attribute (create {DOM_STRING}.make_from_string ("align"), 
				create {DOM_STRING}.make_from_string ("center"))
			discard := doc.document_element.append_child (head)
			node_impl ?= doc
			create writer
			print (writer.to_string(node_impl))
		end

	impl: DOM_IMPLEMENTATION_IMPL
	doc: DOM_DOCUMENT
	writer: DOM_WRITER
	comment: DOM_COMMENT
	head: DOM_ELEMENT

	-- unused attributes used to compile all DOM classes

	attr_impl: DOM_ATTR_IMPL
	character_data_impl: DOM_CHARACTER_DATA_IMPL
	comment_impl: DOM_COMMENT_IMPL
	document_fragment_impl: DOM_DOCUMENT_FRAGMENT_IMPL
	element_impl: DOM_ELEMENT_IMPL
	exception_impl: DOM_EXCEPTION_IMPL
	named_node_map_impl: DOM_NAMED_NODE_MAP_IMPL
	node_impl: DOM_NODE_IMPL
	node_list_impl: DOM_NODE_LIST_IMPL
	string_impl: DOM_STRING
	text_impl: DOM_TEXT_IMPL

	document_type_impl: DOM_DOCUMENT_TYPE_IMPL
	entity_reference_impl: DOM_ENTITY_REFERENCE_IMPL
	processing_instruction_impl: DOM_PROCESSING_INSTRUCTION_IMPL
	cdata_impl: DOM_CDATA_SECTION_IMPL
	entity_impl: DOM_ENTITY_IMPL
	notation_impl: DOM_NOTATION_IMPL
	parent_node_impl: DOM_PARENT_NODE
	child_node_impl: DOM_CHILD_NODE

end
