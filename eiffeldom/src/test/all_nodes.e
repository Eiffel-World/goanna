indexing

	description: "Test class for compiling all DOM classes"

class ALL_NODES

creation

	make

feature

	make is
		do
			-- bootstrap implementation
			create {DOM_IMPLEMENTATION_IMPL} impl
			-- create document
			doc := impl.create_document (create {DOM_STRING}.make_from_string ("http://test"),
				create {DOM_STRING}.make_from_string ("HTML"), Void)
			node_impl ?= doc
			create writer
			print (writer.to_string(node_impl))
		end

	impl: DOM_IMPLEMENTATION_IMPL
	doc: DOM_DOCUMENT
	node_impl: DOM_NODE_IMPL
	writer: DOM_WRITER

	-- unused attributes used to compile all DOM classes

	attr: DOM_ATTR_IMPL
	character_date: DOM_CHARACTER_DATA_IMPL
	comment: DOM_COMMENT_IMPL
	document_fragment: DOM_DOCUMENT_FRAGMENT_IMPL
	element: DOM_ELEMENT_IMPL
	exception: DOM_EXCEPTION_IMPL
	named_node_map: DOM_NAMED_NODE_MAP_IMPL
	node: DOM_NODE_IMPL
	node_list: DOM_NODE_LIST_IMPL
	string: DOM_STRING
	text: DOM_TEXT_IMPL

	document_type: DOM_DOCUMENT_TYPE_IMPL
	entity_reference: DOM_ENTITY_REFERENCE_IMPL
	processing_instruction: DOM_PROCESSING_INSTRUCTION_IMPL
	cdata: DOM_CDATA_SECTION_IMPL
	entity: DOM_ENTITY_IMPL
	notation: DOM_NOTATION_IMPL
	parent_node: DOM_PARENT_NODE
	child_node: DOM_CHILD_NODE

end
