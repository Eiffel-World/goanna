indexing
	description: "Objects that represent a SOAP envelope body."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_SOAP_BODY

inherit
	
	GOA_SOAP_ELEMENT

create

	make_last, construct

feature -- Initialisation

	construct is
			-- Initialise body
		do
		ensure
			zero_body_blocks: body_blocks /= Void and then body_blocks.is_empty
		end
		
feature -- Access

	body_blocks: DS_LINKED_LIST [GOA_SOAP_BLOCK]
			-- Body blocks (zero or more).
	
feature -- Status setting

	add_body_block (a_block: GOA_SOAP_BLOCK) is
			-- Add `a_block' to the list of body blocks in this body.
		require
			new_block_exists: a_block /= Void
		do
			body_blocks.force_last (a_block)
		ensure
			block_added: body_blocks.has (a_block)
		end
		
invariant
	
--	body_blocks_exist: unmarshall_ok implies body_blocks /= Void
	
end -- class GOA_SOAP_BODY
