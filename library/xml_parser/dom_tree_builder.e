indexing
	description:	"A DOM tree based XML parser"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML Parser"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	DOM_TREE_BUILDER

inherit
   
   XML_EVENT_PARSER
		redefine
			on_attribute_declaration,
			on_default,
			on_default_expanded,
			on_element_declaration,
			on_end_cdata_section,
			on_end_doctype,
			on_end_namespace_declaration,
			on_entity_declaration,
			on_not_standalone,
			on_notation_declaration,
			on_start_cdata_section,
			on_start_doctype,
			on_start_namespace_declaration,
			on_xml_declaration,
			on_start_tag,
			on_content,
			on_end_tag,
			on_processing_instruction,
			on_comment
		end
creation
   
	make
      
feature {NONE} -- Initialisation

	make is
			do
				make_from_imp (parser)
				create {DOM_IMPLEMENTATION_IMPL} dom_impl
				document := dom_impl.create_empty_document (Void)
				current_open_composite := document
			end

feature {ANY} -- Access
   
	document: DOM_DOCUMENT
         
feature {NONE} -- Parser call backs

	on_start_tag (name, ns_prefix: UCSTRING; 
		attributes: DS_BILINEAR [DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]]) is
			-- called whenever the parser findes a start element
		local
			new_node: DOM_ELEMENT
			pair: DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]
		do
			debug ("parser_events")
				print ("on_start_tag: name='" + name.out + "' ns_prefix='" + ns_prefix.out + "'") 
				print ("%R%N")
			end
			new_node := document.create_element (create {DOM_STRING}.make_from_ucstring (name)) -- TODO: change to create_element_ns
			-- set new node as root document element if not already set.
			if document_element = Void then
				document_element := new_node
				document.set_document_element (document_element)
			end
			current_node ?= new_node
			current_open_composite := current_open_composite.append_child (current_node)
			-- add the node attributes
			-- attributes are stored with DS_PAIR [DS_PAIR [name, prefix], value]]
			from
				attributes.start
			until
				attributes.off
			loop
				pair := attributes.item_for_iteration
				new_node.set_attribute (create {DOM_STRING}.make_from_ucstring (pair.first.first), 
					create {DOM_STRING}.make_from_ucstring (pair.second))

				attributes.forth
			end
		end

	on_content (chr_data: UCSTRING) is
			-- called whenever the parser findes character data
		do
			debug ("parser_events")
				print ("on_content: '" + chr_data.out + "'")
				print ("%R%N")
			end
			current_node := current_open_composite.append_child (document.create_text_node 
					(create {DOM_STRING}.make_from_ucstring (chr_data)))
		end

	on_end_tag (name, ns_prefix: UCSTRING) is
			-- called whenever the parser findes an end element
		do
			debug ("parser_events")
				print ("on_end_tag: name='" + name.out + "' ns_prefix='" + ns_prefix.out + "'")
				print ("%R%N")
			end
			-- if the current node is Void then the parent node has ended
			current_open_composite := current_open_composite.parent_node
			current_node := current_open_composite
		end
   
	on_processing_instruction (target, data: UCSTRING) is
			-- called whenever the parser findes a processing instruction.
		local
			new_element: DOM_NODE
		do
			debug ("parser_events")
				print ("on_processing_instruction: target='" + target.out + "' data='" + data.out + "'")
				print ("%R%N")
			end
			new_element := document.create_processing_instruction (create {DOM_STRING}.make_from_ucstring (target), 
				create {DOM_STRING}.make_from_ucstring (data))
			if current_open_composite = Void then
				current_node := document.append_child (new_element)
			else
				current_node := current_open_composite.append_child (new_element)
			end
		end
   
	on_comment (com: UCSTRING) is
			-- called whenever the parser finds a comment.
		local
			new_element: DOM_NODE
		do
			debug ("parser_events")
				print ("on_comment: " + com.out)
				print ("%R%N")
			end
			new_element := document.create_comment (create {DOM_STRING}.make_from_ucstring (com))
			if current_open_composite = Void then
				current_node := document.append_child (new_element)
			else
				current_node := current_open_composite.append_child (new_element)
			end
		end

	on_element_declaration (name: UCSTRING; model: POINTER) is
		do
			debug ("parser_events")
				print ("on_element_declaration: name=" + name.out)
				print (" model=" + model.out)
				print ("%R%N")
			end
		end
		
	on_attribute_declaration (element_name, attribute_name, 
			attribute_type, default_value: UCSTRING; is_required: BOOLEAN) is
		do
			debug ("parser_events")
				print ("on_attribute_declaration: element_name=" + element_name.out)
				print (" attribute_name=" + attribute_name.out + " attribute_type=" + attribute_type.out)
				print (" default_value=" + default_value.out + " is_required=" + is_required.out)
				print ("%R%N")
			end
		end

	on_xml_declaration (xml_version, encoding: UCSTRING; standalone: INTEGER) is
		do
			debug ("parser_events")
				print ("on_xml_declaration: xml_version=" + xml_version.out + " encoding=" + encoding.out)
				print (" standalone=" + standalone.out)
				print ("%R%N")
			end
		end

	on_entity_declaration (entity_name: UCSTRING; is_parameter_entity: BOOLEAN; 
			value: UCSTRING; value_length: INTEGER; base, system_id, public_id, notation_name: UCSTRING) is
		do
			debug ("parser_events")
				print ("on_entity_declaration: entity_name=" + entity_name.out)
				print (" is_parameter_entity=" + is_parameter_entity.out + " value=" + value.out)
				print (" value_length=" + value_length.out + " base=" + base.out + " public_id=" + public_id.out)
				print (" notation_name=" + notation_name.out)
				print ("%R%N")
			end
		end
		
	on_start_cdata_section is
		do
			debug ("parser_events")
				print ("on_start_cdata_section")
				print ("%R%N")
			end
		end

	on_end_cdata_section is
		do
			debug ("parser_events")
				print ("on_end_cdata_section")
				print ("%R%N")
			end
		end

	on_default (data: UCSTRING) is
		do
			debug ("parser_events")
				print ("on_default: data=" + data.out)
				print ("%R%N")
			end
		end

	on_default_expanded (data: UCSTRING) is
		do
		end

	on_start_doctype (name, system_id, public_id: UCSTRING; has_internal_subset: BOOLEAN) is
			-- This is called for the start of the DOCTYPE declaration, before
			-- any DTD or internal subset is parsed.
		do
			debug ("parser_events")
				print ("on_start_doctype: name=" + name.out)
				if system_id /= Void then
					print (" system_id=" + system_id.out)
				end 
				if public_id /= Void then
					print (" public_id=" + public_id.out)
				end
				print (" has_internal_subset=" + has_internal_subset.out)
				print ("%R%N")
			end
		end

	on_end_doctype is
			-- This is called for the start of the DOCTYPE declaration when the
			-- closing > is encountered, but after processing any external subset.
		do
			debug ("parser_events")
				print ("on_end_doctype")
				print ("%R%N")
			end
		end

	on_notation_declaration (notation_name, base, system_id, public_id: UCSTRING) is
		do
			debug ("parser_events")
				print ("on_notation_declaration: notation_name=" + notation_name.out)
				print (" base=" + base.out + " system_id=" + system_id.out + " public_id=" + public_id.out)
				print ("%R%N")
			end
		end

	on_start_namespace_declaration (namespace_prefix, uri: UCSTRING) is
		do
			debug ("parser_events")
				print ("on_start_namespace_declaration: namespace_prefix=" + namespace_prefix.out)
				print (" uri=" + uri.out)
				print ("%R%N")
			end
		end

	on_end_namespace_declaration (namespace_prefix: UCSTRING) is
		do
			debug ("parser_events")
				print ("on_end_namespace_declaration: namespace_prefix=" + namespace_prefix.out)
				print ("%R%N")
			end
		end

	on_not_standalone: BOOLEAN is
		do
			debug ("parser_events")
				print ("on_not_standalone")
				print ("%R%N")
			end
		end
		
feature {NONE} -- Implementation

	current_node: DOM_NODE
	current_open_composite: DOM_NODE
	document_element: DOM_ELEMENT
	
	dom_impl: DOM_IMPLEMENTATION

	parser: EXPAT_EVENT_PARSER is
		once
			create Result
		end
      
end -- class DOM_TREE_BUILDER
