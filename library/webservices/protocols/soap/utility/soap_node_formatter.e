indexing
	description: "Objects that serialise SOAP block nodes with optional attributes."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_NODE_FORMATTER

inherit
	
	XM_FORMATTER
		export
			{NONE} all
			{ANY} make, wipe_out, last_string
		redefine
			wipe_out
		end

creation
	
	make
	
feature -- Formatting

	format (el: XM_ELEMENT; blk: SOAP_BLOCK) is
			-- Format 'el' including any optional attributes as defined in 'blk'
		require
			el_exists: el /= Void
			block_exists: blk /= Void
		do
			block := blk
			process_root_element (el)
		end
	
	wipe_out is
			-- Clean up the processor
		do
			Precursor
			block := Void
		end
		
feature {NONE} -- Implementation

	block: SOAP_BLOCK
			-- Block holding optional attribute values
	
	process_root_element (el: XM_ELEMENT) is
		do
			try_process_position (el)
			process_root_start_tag (el)
			process_composite (el)
			process_end_tag (el)
		end
	
	process_root_start_tag (el: XM_ELEMENT) is
		require
			el_not_void: el /= Void
		do
			append ("<")
			process_named (el)
			append (" ")
			process_root_attributes (el)
			append (">")
		end
	
	process_root_attributes (e: XM_ELEMENT) is
			-- Process attributes adding optional attributes as needed.
		local
			cs: DS_BILINEAR_CURSOR [XM_ATTRIBUTE]
		do
			process_attributes (e)
			if block.actor /= Void then
				append ("env:actor=%"")
				append (block.actor.out)
				append ("%" ")
			end
			if block.must_understand /= Void then
				append ("env:mustUnderstand=%"")
				append (block.must_understand.out)
				append ("%" ")
			end
			if block.encoding_style /= Void then
				append (block.encoding_style_attribute)
			end
		end

end -- class SOAP_NODE_FORMATTER
