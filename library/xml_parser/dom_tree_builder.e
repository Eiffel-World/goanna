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
	
	UT_STRING_FORMATTER
		export
			{NONE} all
		end
	
creation
   
	make
      
feature {NONE} -- Initialisation

	make is
			do
				make_from_imp (parser)
				create {DOM_IMPLEMENTATION_IMPL} dom_impl
				document := dom_impl.create_empty_document
				current_open_composite := document
			end

feature {ANY} -- Access
   
	document: DOM_DOCUMENT
	
	document_type: DOM_DOCUMENT_TYPE
         
feature {NONE} -- Parser call backs

	on_start_tag (name, ns_prefix: UCSTRING; 
		attributes: DS_BILINEAR [DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]]) is
			-- called whenever the parser findes a start element
		local
			qualified_name, attr_prefix: DOM_STRING
			new_node: DOM_ELEMENT
			pair: DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]
		do
			debug ("parser_events")
				print ("on_start_tag:%R%N%Tname=" + quoted_eiffel_string_out (name.out) 
					+ " ns_prefix=" + quoted_eiffel_string_out (ns_prefix.out))
				print ("%R%N")
				if not attributes.is_empty then
					print ("%Tattributes:%R%N")
					from
						attributes.start
					until
						attributes.off
					loop
						pair := attributes.item_for_iteration
						print ("%T%Tname=" + quoted_eiffel_string_out (pair.first.first.out))
						print (" prefix=" + quoted_eiffel_string_out (pair.first.second.out))
						print (" value=" + quoted_eiffel_string_out (pair.second.out))
						print ("%R%N")
						attributes.forth
					end
				end
			end
--			if ns_prefix.empty then
				new_node := document.create_element (create {DOM_STRING}.make_from_ucstring (name))
--			else
--				create qualified_name.make_from_ucstring (ns_prefix)
--				qualified_name.append_string (":")
--				qualified_name.append_ucstring (name)
--				new_node := document.create_element_ns (current_namespace_uri, qualified_name)
--			end
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
				create attr_prefix.make_from_ucstring (pair.first.second)
--				if attr_prefix.empty then
					new_node.set_attribute (create {DOM_STRING}.make_from_ucstring (pair.first.first), 
						create {DOM_STRING}.make_from_ucstring (pair.second))
--				else
--					create qualified_name.make_from_ucstring (attr_prefix)
--					qualified_name.append_string (":")
--					qualified_name.append_ucstring (pair.first.first)
--					new_node.set_attribute_ns (current_namespace_uri, qualified_name, 
--						create {DOM_STRING}.make_from_ucstring (pair.second))
--				end
				attributes.forth
			end
		end

	on_content (chr_data: UCSTRING) is
			-- called whenever the parser finds character data
		local
			normalized: UCSTRING
		do
			debug ("parser_events")
				print ("on_content:%R%N%Tchr_data=" + quoted_eiffel_string_out (chr_data.out))
				print ("%R%N")
			end
			-- normalize the character data if we are not in a CDATA section
			-- if there is anything left then add it to the current composite.
			if not in_cdata_section then
				normalize (chr_data)
			end
			if not chr_data.empty then
				current_node := current_open_composite.append_child (document.create_text_node 
						(create {DOM_STRING}.make_from_ucstring (chr_data)))
			end
		end

	on_end_tag (name, ns_prefix: UCSTRING) is
			-- called whenever the parser findes an end element
		do
			debug ("parser_events")
				print ("on_end_tag:%R%N%Tname=" + quoted_eiffel_string_out (name.out) + " ns_prefix=" 
					+ quoted_eiffel_string_out (ns_prefix.out))
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
				print ("on_processing_instruction:%R%N%Ttarget=" + quoted_eiffel_string_out (target.out) + " data=" 
					+ quoted_eiffel_string_out (data.out))
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
				print ("on_comment:%R%N%Tcom=" + quoted_eiffel_string_out (com.out))
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
				print ("on_element_declaration:%R%N%Tname=" + quoted_eiffel_string_out (name.out))
				print (" model=" + quoted_eiffel_string_out (model.out))
				print ("%R%N")
			end
		end
		
	on_attribute_declaration (element_name, attribute_name, 
			attribute_type, default_value: UCSTRING; is_required: BOOLEAN) is
		do
			debug ("parser_events")
				print ("on_attribute_declaration:%R%N%Telement_name=" + quoted_eiffel_string_out (element_name.out))
				print (" attribute_name=" + quoted_eiffel_string_out (attribute_name.out) + " attribute_type=" + quoted_eiffel_string_out (attribute_type.out))
				print (" default_value=" + quoted_eiffel_string_out (default_value.out) + " is_required=" + is_required.out)
				print ("%R%N")
			end
		end

	on_xml_declaration (xml_version, encoding: UCSTRING; standalone: INTEGER) is
		do
			debug ("parser_events")
				print ("on_xml_declaration:R%N%Txml_version=" + quoted_eiffel_string_out (xml_version.out) 
					+ " encoding=" + quoted_eiffel_string_out (encoding.out))
				print (" standalone=" + standalone.out)
				print ("%R%N")
			end
		end

	on_entity_declaration (entity_name: UCSTRING; is_parameter_entity: BOOLEAN; 
			value: UCSTRING; value_length: INTEGER; base, system_id, public_id, notation_name: UCSTRING) is
		do
			debug ("parser_events")
				print ("on_entity_declaration:%R%N%Tentity_name=" + quoted_eiffel_string_out (entity_name.out))
				print (" is_parameter_entity=" + is_parameter_entity.out + " value=" + quoted_eiffel_string_out (value.out))
				print (" value_length=" + value_length.out + " base=" + quoted_eiffel_string_out (base.out) 	
					+ " public_id=" + quoted_eiffel_string_out (public_id.out))
				print (" notation_name=" + quoted_eiffel_string_out (notation_name.out))
				print ("%R%N")
			end
		end
		
	on_start_cdata_section is
		do
			debug ("parser_events")
				print ("on_start_cdata_section")
				print ("%R%N")
			end
			in_cdata_section := True
		end

	on_end_cdata_section is
		do
			debug ("parser_events")
				print ("on_end_cdata_section")
				print ("%R%N")
			end
			in_cdata_section := False
		end

	on_default (data: UCSTRING) is
		do
			debug ("parser_events")
				print ("on_default:%R%N%Tdata=" + quoted_eiffel_string_out (data.out))
				print ("%R%N")
			end
		end

	on_default_expanded (data: UCSTRING) is
		do
			debug ("parser_events")
				print ("on_default_expanded:%R%N%Tdata=" + quoted_eiffel_string_out (data.out))
				print ("%R%N")
			end
		end

	on_start_doctype (name, system_id, public_id: UCSTRING; has_internal_subset: BOOLEAN) is
			-- This is called for the start of the DOCTYPE declaration, before
			-- any DTD or internal subset is parsed.
		local
			uc_public_id, uc_system_id: DOM_STRING
		do
			debug ("parser_events")
				print ("on_start_doctype:%R%N%Tname=" + quoted_eiffel_string_out (name.out))
				if system_id /= Void then
					print (" system_id=" + quoted_eiffel_string_out (system_id.out))
				end 
				if public_id /= Void then
					print (" public_id=" + quoted_eiffel_string_out (public_id.out))
				end
				print (" has_internal_subset=" + has_internal_subset.out)
				print ("%R%N")
			end
			-- create new document type
			if system_id /= Void then
				create uc_system_id.make_from_ucstring (system_id)
			else
				create uc_system_id.make_from_string ("")
			end
			if public_id /= Void then
				create uc_public_id.make_from_ucstring (public_id)
			else
				create uc_public_id.make_from_string ("")
			end
			document_type := dom_impl.create_document_type (create {DOM_STRING}.make_from_ucstring (name), 
				uc_public_id, uc_system_id)
		end

	on_end_doctype is
			-- This is called for the start of the DOCTYPE declaration when the
			-- closing > is encountered, but after processing any external subset.
		do
			debug ("parser_events")
				print ("on_end_doctype")
				print ("%R%N")
			end
			-- store the doctype
			document_type.set_owner_document (document)
			document.set_doctype (document_type)
		end

	on_notation_declaration (notation_name, base, system_id, public_id: UCSTRING) is
		do
			debug ("parser_events")
				print ("on_notation_declaration:%R%N%Tnotation_name=" + quoted_eiffel_string_out (notation_name.out))
				print (" base=" + quoted_eiffel_string_out (base.out) + " system_id=" + quoted_eiffel_string_out (system_id.out)
					+ " public_id=" + quoted_eiffel_string_out (public_id.out))
				print ("%R%N")
			end
		end

	on_start_namespace_declaration (namespace_prefix, uri: UCSTRING) is
		do
			debug ("parser_events")
				print ("on_start_namespace_declaration:%R%N%T")
				if (namespace_prefix /= Void) then
					print ("namespace_prefix=" + quoted_eiffel_string_out (namespace_prefix.out) + " ")
				else
					print ("(default) ");
				end
				print ("uri=" + quoted_eiffel_string_out (uri.out))
				print ("%R%N")
			end
			if namespace_prefix /= Void then
				create current_namespace_prefix.make_from_ucstring (namespace_prefix)				
			end
			create current_namespace_uri.make_from_ucstring (uri)
		end

	on_end_namespace_declaration (namespace_prefix: UCSTRING) is
		do
			debug ("parser_events")
				print ("on_end_namespace_declaration:%R%N%T")
				if namespace_prefix /= Void then
					print ("namespace_prefix=" + quoted_eiffel_string_out (namespace_prefix.out))
				else
					print ("(default)")
				end
				print ("%R%N")
			end
			current_namespace_prefix := Void
			current_namespace_uri := Void
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
	
	in_cdata_section: BOOLEAN
	
	current_namespace_prefix: DOM_STRING
	
	current_namespace_uri: DOM_STRING
	
	document_element: DOM_ELEMENT
	
	dom_impl: DOM_IMPLEMENTATION

	parser: DOM_EVENT_PARSER is
		once
			create Result
		end
      
	normalize (str: UCSTRING) is
			-- Remove leading and trailing whitespace from 'str'
			-- Modifies 'str' parameter
		require
			str_exists: str /= Void
		do
			str.left_adjust
			str.right_adjust
		ensure
			normalized_exists: str /= Void
		end
		
end -- class DOM_TREE_BUILDER
