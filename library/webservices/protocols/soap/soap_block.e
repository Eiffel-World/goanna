indexing
	description: "Objects that represent a SOAP block (for header and body elements)."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_BLOCK

inherit

	SOAP_ELEMENT

create
	make, unmarshall

feature -- Initialization

	make (block_node: like node) is
				-- Initialise block with 'block_node' as the block element.
				-- The node should not already contain encoding, actor or must_understand
				-- attributes.
			require
				block_node_exists: block_node /= Void
			do
				node := block_node
				unmarshall_ok := True
			ensure
				no_encoding_style: encoding_style = Void
				no_actor: actor = Void
				no_must_understand: must_understand = Void
			end

	unmarshall (init_node: XM_ELEMENT) is
			-- Initialise SOAP header from DOM node.
		do
			unmarshall_ok := True
			unmarshall_encoding_style_attribute (init_node)
			if unmarshall_ok then
				unmarshall_actor_attribute (init_node)
				if unmarshall_ok then
					unmarshall_must_understand_attribute (init_node)
					if unmarshall_ok then
						-- save node
						node := init_node			
					end
				end
			end
		end
	
feature -- Access
			
	actor: UC_STRING
			-- Actor for this block. Void if unspecified 
			-- (ie.implicitly targeted at the ultimate SOAP receiver
			
	must_understand: BOOLEAN_REF
			-- Must understand flag. Void if unspecified.
	
	node: XM_ELEMENT
			-- The XML element of this block
			
feature -- Status setting
	
	set_actor (new_actor: like actor) is
			-- Set 'actor' to 'new_actor'
		require
			new_actor_exists: new_actor /= Void
		do
			actor := new_actor
		end
	
	set_must_understand (flag: BOOLEAN) is
			-- Set 'must_understand' to value of 'flag'.
			-- Do not call this method to leave unspecified.
		do
			create must_understand
			must_understand.set_item (flag)
		end

	set_node (new_node: like node) is
			-- Set 'node' to 'new_node'
		require
			new_node_exists: new_node /= Void
		do
			node := new_node
		end
		
feature -- Marshalling

	marshall: STRING is
			-- Serialize this block to XML format
		do
			formatter.wipe_out
			formatter.format (node, Current)
			Result := formatter.last_string.out
		end
	
feature {NONE} -- Implementation

	formatter: SOAP_NODE_FORMATTER is
			-- XML node formatter
		once
			create Result.make
		end
	
	unmarshall_actor_attribute (new_node: XM_ELEMENT) is
			-- Search for optional actor attribute, unmarshall and set
			-- actor if found. Notify of unmarshalling error by setting
			-- 'unmarshall_ok'.
			--| actor attribute is explicitly encoded as an XMLSchema anyURI.
		require
			node_exists: new_node /= Void
		local
			str: UC_STRING
		do
			if new_node.has_attribute_by_name (Actor_attr) then
				value_factory.unmarshall_for_type (new_node.attribute_by_name (Actor_attr).value, 
					Ns_name_xs, Xsd_anyuri)
				if not value_factory.unmarshall_ok then
					unmarshall_ok := False
					unmarshall_fault := value_factory.unmarshall_fault
				else
					str ?= value_factory.last_value.as_object
					set_actor (str)
				end
			end
		end
	
	unmarshall_must_understand_attribute (new_node: XM_ELEMENT) is
			-- Search for optional mustUnderstand attribute, unmarshall and set
			-- must_understand if found. Notify of unmarshalling error by setting
			-- 'unmarshall_ok'.
			--| actor attribute is explicitly encoded as an XMLSchema boolean.
		require
			node_exists: new_node /= Void
		local
			bool: BOOLEAN_REF
		do
			if new_node.has_attribute_by_name (Must_understand_attr) then
				value_factory.unmarshall_for_type (new_node.attribute_by_name (Must_understand_attr).value, 
					Ns_name_xs, Xsd_boolean)
				if not value_factory.unmarshall_ok then
					unmarshall_ok := False
					unmarshall_fault := value_factory.unmarshall_fault
				else
					bool ?= value_factory.last_value.as_object
					set_must_understand (bool.item)
				end
			end
		end
		
invariant
	
	node_exists: unmarshall_ok implies node /= Void
	
end -- class SOAP_BLOCK
