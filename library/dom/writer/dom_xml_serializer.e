indexing
	description: "Objects that can serializer XML documents"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "DOM Serialization"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	DOM_XML_SERIALIZER

inherit
	DOM_SERIALIZER
	
	DOM_NODE_TYPE
		export
			{NONE} all
		end
	
	HTTP_UTILITY_FUNCTIONS
		export
			{NONE} all
		end
			
creation
	make

feature -- Serialization

	serialize (doc: DOM_DOCUMENT) is
			-- Serialize 'doc' to specified output medium.
		local
			doc_nodes: DOM_NODE_LIST
			index: INTEGER
		do
			-- output document declaration
			output.put_string ("<?xml version=%"1.0%" encoding=%"ISO-8859-1%" standalone=%"yes%"?>")
			from
				doc_nodes := doc.child_nodes
			variant
				doc_nodes.length - index
			until
				index >= doc_nodes.length
			loop
				serialize_new_line
				serialize_node_recurse (doc_nodes.item (index), 0)
				index := index + 1
			end
		end

	serialize_node (node: DOM_NODE) is
			-- Serialize 'node' to specified output medium
		do
			serialize_node_recurse (node, 0)		
		end
		
	serialize_element (element: DOM_ELEMENT) is
			-- Serialize 'element' to specified output medium
		do
			serialize_element_recurse (element, 0)					
		end
		
feature {NONE} -- Implementation

	serialize_element_recurse (element: DOM_ELEMENT; indent_level: INTEGER) is
			-- Serialize 'element' to specified output medium
		local
			i: INTEGER
			attrs: DOM_NAMED_MAP [DOM_ATTR]
			attr: DOM_ATTR
			attr_name, attr_value: DOM_STRING
			child_nodes : DOM_NODE_LIST
		do			
			-- output this element, its attributes, and recursively, all of its children
			serialize_indent (indent_level)
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
						output.put_string (encode (attr_value.out))
						output.put_string ("%" ")		
					end
					i := i + 1
				end	
			end
			-- children
			if element.has_child_nodes then
				-- close start tag
				output.put_string (">")
				serialize_new_line
				from
					child_nodes := element.child_nodes
					i := 0
				until
					i >= child_nodes.length
				loop
					serialize_node_recurse (child_nodes.item (i), indent_level + indent_amount)
					i := i + 1
				end	
				-- close tag
				serialize_new_line
				serialize_indent (indent_level)
				output.put_string ("</")
				output.put_string (element.tag_name.out)
				output.put_string (">")
				serialize_new_line
			else
				-- close start tag as an empty element
				output.put_string ("/>")
				serialize_new_line		
			end			
		end
	
	serialize_node_recurse (node: DOM_NODE; indent_level: INTEGER) is
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
				serialize_element_recurse (element, indent_level)
			when Text_node then
				serialize_text (node, indent_level)
			when Cdata_section_node then
				serialize_cdata_section (node, indent_level)
			when Comment_node then
				serialize_comment (node, indent_level)
			when Document_type_node then
				serialize_doctype (node, indent_level)
			else
				debug ("unhandled_node_types")
					print ("Unhandled node type: " + node.generator + " name: " + node.node_name.out)
					print ("%R%N")
				end
				-- TODO: handle other types
			end		
		end
				
	serialize_text (text: DOM_NODE; indent_level: INTEGER) is
			-- Serialize 'text' to output stream
		do
			serialize_indent (indent_level)
			output.put_string (encode (text.node_value.out))
		end
	
	serialize_comment (comment: DOM_NODE; indent_level: INTEGER) is
			-- Serialize 'comment' to output stream
		do
			serialize_indent (indent_level)
			output.put_string ("<!-- ")
			output.put_string (comment.node_value.out)
			output.put_string (" -->")
			serialize_new_line
		end
	
	serialize_cdata_section (cdata: DOM_NODE; indent_level: INTEGER) is
			-- Serialize 'cdata' to output stream			
		do
			serialize_indent (indent_level)
			output.put_string ("<!CDATA[")
			output.put_string (cdata.node_value.out)
			output.put_string ("]]>")
			serialize_new_line
		end
	
	serialize_doctype (doctype: DOM_NODE; indent_level: INTEGER) is
			-- Serialize 'doctype' to output stream
		local
			doctype_node: DOM_DOCUMENT_TYPE
			child_nodes: DOM_NODE_LIST
			i: INTEGER
		do
			doctype_node ?= doctype
			check
				doctype_exists: doctype_node /= Void
			end
			serialize_indent (indent_level)
			output.put_string ("<!DOCTYPE ")
			output.put_string (doctype_node.name.out)
			if doctype_node.system_id /= Void then
				output.put_string (" " + doctype_node.system_id.out)
			end
			if doctype_node.public_id /= Void then
				output.put_string (" " + doctype_node.public_id.out)
			end
			if doctype_node.has_child_nodes then
				-- serialize internal subset
				output.put_string ("[")
				serialize_new_line
				from
					child_nodes := doctype_node.child_nodes
					i := 0
				until
					i >= child_nodes.length
				loop
					serialize_node_recurse (child_nodes.item (i), indent_level + indent_amount)
					i := i + 1
				end	
				-- close tag
				serialize_new_line
				serialize_indent (indent_level)
				output.put_string ("]>")
				serialize_new_line
			else
				-- close external subse
				output.put_string (">")
				serialize_new_line		
			end			
		end
		
	serialize_indent (level: INTEGER) is
			-- 
		local
			indent: STRING
		do
			if not is_compact_format then
				if level > 0 then
					create indent.make (level)
					indent.fill_blank
					output.put_string (indent)	
				end
			end
		end
	
	serialize_new_line is
			-- Write a new line to the output depending on format.
		do
			if not is_compact_format then
				output.put_string ("%R%N")
			end
		end
	
end -- class DOM_XML_SERIALIZER
