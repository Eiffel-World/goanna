indexing
	description: "Objects that represent a SOAP envelope header."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_SOAP_HEADER

inherit
	
	GOA_SOAP_ELEMENT
		redefine
			validate
		end

create

	make_last, construct

feature -- Initialisation

	construct is
			-- Initialise header
		do
			-- TODO
		ensure
			zero_header_blocks: header_blocks /= Void and then header_blocks.is_empty
		end
		
	
feature -- Access

	header_blocks: DS_LINKED_LIST [GOA_SOAP_HEADER_BLOCK]
			-- Header blocks (zero or more).
	
feature -- Status report

	validation_complete: BOOLEAN
			-- Has `validate' finished?

feature -- Status setting

	add_header_block (a_block: GOA_SOAP_HEADER_BLOCK) is
			-- Add 'a_block' to the list of header blocks in `Current'.
		require
			new_block_ok: a_block /= Void and then a_block.validated
		do
			header_blocks.force_last (a_block)
		ensure
			block_added: header_blocks.has (a_block)
		end
		
	validate is
			-- Validate `Current'.
		local
			child_elements: DS_LIST [XM_ELEMENT]
			a_cursor: DS_LIST_CURSOR [XM_ELEMENT]
			a_block: GOA_SOAP_HEADER_BLOCK
			a_block_cursor: DS_LINKED_LIST_CURSOR [GOA_SOAP_HEADER_BLOCK]
		do
			Precursor
			if validated then check_encoding_style_attribute (Void, Void) end
			if validated then
				create header_blocks.make_default
				child_elements := elements
				from 
					a_cursor := elements.new_cursor; a_cursor.start
				until not validated or else a_cursor.after loop
					a_block ?= a_cursor.item
					if a_block = Void then
						set_validation_fault (Receiver_fault, "Receiver failed to process env:Header correctly", Void, Void)
					elseif not a_block.has_namespace then
						set_validation_fault (Sender_fault, "Header block lacks namespace", Void, Void)
					else
						header_blocks.force_last (a_block)
					end
					a_cursor.forth
				end
			end
			if validated then
				from
					a_block_cursor := header_blocks.new_cursor; a_block_cursor.start
				until not validated or else a_block_cursor.after loop
					a_block := a_block_cursor.item
					a_block.validate
					if not a_block.validated then
						validated := False
						validation_fault := a_block.validation_fault
					end
					a_block_cursor.forth
				end
			end
			validation_complete := True
		end

invariant
	
header_blocks_exist: validation_complete and then validated implies header_blocks /= Void
	
end -- class SOAP_GOA_HEADER
