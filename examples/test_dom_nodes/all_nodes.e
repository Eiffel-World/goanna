indexing
	description: "Test class for compiling all DOM classes"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class ALL_NODES

creation

	make

feature

	make is
		local
			discard: DOM_NODE
			str, str2: DOM_STRING
		do
			-- bootstrap implementation
			!DOM_IMPLEMENTATION_IMPL! impl

			-- create document
			!! str.make_from_string ("http://test")
			!! str2.make_from_string ("HTML")
			doc := impl.create_document (str, str2, Void)
			!! str.make_from_string ("This is a comment.")
			comment := doc.create_comment (str)
			discard := doc.document_element.append_child (comment)
			!! str.make_from_string ("HEAD")
			head := doc.create_element (str)
			!! str.make_from_string ("id")
			!! str2.make_from_string ("header")
			head.set_attribute (str, str2)
			!! str.make_from_string ("align")
			!! str.make_from_string ("center")
			head.set_attribute (str, str2)
			discard := doc.document_element.append_child (head)
			node_impl ?= doc
			!! writer
			writer.output(node_impl)
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
