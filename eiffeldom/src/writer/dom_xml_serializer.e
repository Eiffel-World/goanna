indexing
	description: "Objects that can serializer XML documents"
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	DOM_XML_SERIALIZER

inherit
	DOM_SERIALIZER
	
	DOM_NODE_TYPE
		export
			{NONE} all
		end
		
create
	make

feature -- Serialization

	serialize (doc: DOM_DOCUMENT) is
			-- Serialize 'doc' to specified output medium.
		do
			-- output document declaration
			output.put_string ("<?xml version=%"1.0%" encoding=%"ISO-8859-1%" standalone=%"yes%"?>")
			output.put_new_line
			serialize_node (doc.document_element)
		end
	
	serialize_element (element: DOM_ELEMENT) is
			-- Serialize 'element' to specified output medium
		local
			i: INTEGER
			attrs: DOM_NAMED_MAP [DOM_ATTR]
			attr: DOM_ATTR
			attr_name, attr_value: DOM_STRING
			child_nodes : DOM_NODE_LIST
		do			
			-- output this element, its attributes, and recursively, all of its children
			output.put_string ("<")
			output.put_string (element.tag_name.out)
			-- attributes
			if element.has_attributes then
				output.put_string (" ")
				from
					attrs := element.attributes
					i := 0
				until
					i >= attrs.length
				loop
					attr := attrs.item (i)
					attr_name := attr.name
					attr_value := attr.value
					if attr_value = Void then
						create attr_value.make_from_string ("")
					end
					-- print the attribute if it was specified
					if attr.specified then
						output.put_string (attr_name.out)
						output.put_string ("=%"")
						output.put_string (attr_value.out)
						output.put_string ("%" ")	
					end
					i := i + 1
				end	
			end
			-- children
			if element.has_child_nodes then
				-- close start tag
				output.put_string (">")
				output.put_new_line
				from
					child_nodes := element.child_nodes
					i := 0
				until
					i >= child_nodes.length
				loop
					serialize_node (child_nodes.item (i))
					i := i + 1
				end	
				-- close tag
				output.put_string ("</")
				output.put_string (element.tag_name.out)
				output.put_string (">")
				output.put_new_line
			else
				-- close start tag as an empty element
				output.put_string ("/>")
				output.put_new_line			
			end			
		end
	
	serialize_node (node: DOM_NODE) is
			-- Serialize 'node' to specified output medium
		local
			element: DOM_ELEMENT
		do
			-- check node type and serialize accordingly
			inspect
				node.node_type
			when Element_node then
				element ?= node
				check
					node_type_correct: element /= Void
				end
				serialize_element (element)
			when Text_node then
				serialize_text (node)
			when Cdata_section_node then
				serialize_cdata_section (node)
			when Comment_node then
				serialize_comment (node)
			else
				-- TODO: handle other types
			end		
		end
	
feature {NONE} -- Implementation

	serialize_text (text: DOM_NODE) is
			-- Serialize 'text' to output stream
		do
			output.put_string (text.node_value.out)
		end
	
	serialize_comment (comment: DOM_NODE) is
			-- Serialize 'comment' to output stream
		local
			
		do
			output.put_string ("<!-- ")
			output.put_string (comment.node_value.out)
			output.put_string (" -->")
			output.put_new_line
		end
	
	serialize_cdata_section (cdata: DOM_NODE) is
			-- Serialize 'cdata' to output stream
		local
			
		do
			
		end
	
end -- class DOM_XML_SERIALIZER
