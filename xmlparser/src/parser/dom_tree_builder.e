indexing
	description:	"A DOM tree based XML parser"

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
				document := dom_impl.create_document (create {DOM_STRING}.make_from_string ("http://test"),
					create {DOM_STRING}.make_from_string ("*TEMPROOT*"), Void)
				current_open_composite := document.document_element
			end

feature {ANY} -- Access
   
	document: DOM_DOCUMENT
         
feature {NONE} -- Parser call backs

	on_start_tag (name, ns_prefix: UCSTRING; 
		attributes: DS_BILINEAR [DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]]) is
			-- called whenever the parser findes a start element
		local
			new_element: DOM_ELEMENT
		do
			debug ("parser_events")
				print ("on_start_tag: '" + name.out + "'") 
				print ("%R%N")
			end
			current_node := document.create_element (create {DOM_STRING}.make_from_string (name.out)) -- TODO: change to create_element_ns
			current_open_composite := current_open_composite.append_child (current_node)
		end

	on_content (chr_data: UCSTRING) is
			-- called whenever the parser findes character data
		local
			discard: DOM_NODE
		do
			debug ("parser_events")
				print ("on_content: '" + chr_data.out + "'")
				print ("%R%N")
			end
			current_node := current_open_composite.append_child (document.create_cdata_section 
					(create {DOM_STRING}.make_from_string (chr_data.out)))
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
			new_element := document.create_processing_instruction (create {DOM_STRING}.make_from_string (target.out), 
				create {DOM_STRING}.make_from_string (data.out))
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
			new_element := document.create_comment (create {DOM_STRING}.make_from_string (com.out))
			if current_open_composite = Void then
				current_node := document.append_child (new_element)
			else
				current_node := current_open_composite.append_child (new_element)
			end
		end

feature {NONE} -- Implementation

	current_node: DOM_NODE
	current_open_composite: DOM_NODE
	
	dom_impl: DOM_IMPLEMENTATION

end -- class DOM_TREE_BUILDER
