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
			{ANY} make, wipe_out, set_output
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

	append (a_string: STRING) is
			-- Append chracters to stream.
		require
			string_not_void: a_string /= Void
			is_open_write: last_output.is_open_write
		do
			last_output.put_string (a_string)
		end

	ucappend (str: STRING) is
		require
			str_not_void: str /= Void
		do
			append (str)
		end

	process_composite (c: XM_COMPOSITE) is
		require
			c_not_void: c /= Void
		local
			cs: DS_BILINEAR_CURSOR [XM_NODE]
		do
			from
				cs := c.new_cursor
				cs.start
			until
				cs.off
			loop
				cs.item.process (Current)
				cs.forth
			end
		end

	process_end_tag (el: XM_ELEMENT) is
		require
			el_not_void: el /= Void
		do
			append ("</")
			process_named (el)
			append (">")
		end

	process_named (n: XM_NAMED_NODE) is
		require
			n_not_void: n /= Void
		do
			if n.has_namespace then
				append (n.namespace.uri)
				append ("=")
			end
			ucappend (n.name)
		end

	process_position (node: XM_NODE) is
		require
			node_not_void: node /= Void
			position_included: is_position_included
		local
			pos: XM_POSITION
		do
			if position_table.has (node) then
				pos := position_table.item (node)
			end

			append ("<!--")
			if pos /= Void then
				append (pos.out)
			else
				append ("No position info available")
			end
			append ("-->%N")
		end

	position_table: XM_POSITION_TABLE

end -- class SOAP_NODE_FORMATTER
