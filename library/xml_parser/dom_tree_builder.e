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
   
	EXPAT_EVENT_PARSER
		redefine
			make,
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
				Precursor
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
				print ("on_start_tag: '" + name.out + "'") 
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
				print ("on_end_tag: '" + name.out + "'")
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
				print ("on_processing_instruction: " + target.out)
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

feature {NONE} -- Implementation

	current_node: DOM_NODE
	current_open_composite: DOM_NODE
	document_element: DOM_ELEMENT
	
	dom_impl: DOM_IMPLEMENTATION

end -- class DOM_TREE_BUILDER
