indexing
	description: "Objects that represent a SOAP envelope header."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_HEADER

inherit
	
	SOAP_ELEMENT

create
	make, unmarshall

feature -- Initialisation

	make is
			-- Initialise header
		do
			create header_blocks.make_default
			unmarshall_ok := True
		ensure
			zero_header_blocks: header_blocks /= Void and then header_blocks.is_empty
		end
		
	unmarshall (node: XM_ELEMENT) is
			-- Initialise SOAP header from DOM node.
		local
			c: DS_BILINEAR_CURSOR [XM_NODE]
			elem: XM_ELEMENT
			new_block: SOAP_BLOCK
		do
			check
				header_node: node.name.is_equal (Header_element_name) and node.namespace.is_equal (Ns_name_env)
			end
			make
			unmarshall_ok := True
			unmarshall_encoding_style_attribute (node)
			if unmarshall_ok then
				-- unmarshall all child elements as header blocks.
				from
					c := node.new_cursor
					c.start
				until
					c.off or not unmarshall_ok
				loop
					elem ?= c.item
					if elem /= Void then
						create new_block.unmarshall (elem)
						if new_block.unmarshall_ok then
							add_header_block (new_block)	
						else
							unmarshall_ok := False
							unmarshall_fault := new_block.unmarshall_fault
						end		
					end
					c.forth
				end
			end
		end
	
feature -- Access

	header_blocks: DS_LINKED_LIST [SOAP_BLOCK]
			-- Header blocks (zero or more).

feature -- Status setting

	add_header_block (new_block: SOAP_BLOCK) is
			-- Add 'new_block' to the list of header blocks in this
			-- header.
		require
			new_block_exists: new_block /= Void
		do
			header_blocks.force_last (new_block)
		ensure
			block_added: header_blocks.has (new_block)
		end
		
feature -- Marshalling

	marshall: STRING is
			-- Serialize this header to XML format
		local
			c: DS_LINKED_LIST_CURSOR [SOAP_BLOCK]
		do
			create Result.make (100)
			-- start Header element
			Result.append ("<env:Header")
			-- add encoding style namespace and attribute if it exists
			if encoding_style /= Void then
				Result.append (encoding_style_attribute)
			end
			Result.append (">")
			-- marshall header blocks
			from
				c := header_blocks.new_cursor
				c.start
			until
				c.off
			loop
				Result.append (c.item.marshall)
				c.forth
			end
			
			Result.append ("</env:Header>")
		end
		
invariant
	
	header_blocks_exist: unmarshall_ok implies header_blocks /= Void
	
end -- class SOAP_HEADER
