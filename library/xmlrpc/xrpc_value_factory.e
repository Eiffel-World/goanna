indexing
	description: "Factory that correctly unmarshalls value objects."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class

	XRPC_VALUE_FACTORY

inherit
	
	XRPC_CONSTANTS
		export
			{NONE} all
		end

creation
	
	make
	
feature -- Initialisation

	make is
			-- Initialise
		do
			unmarshall_ok := True
		end
		
feature -- Status report

	unmarshall_ok: BOOLEAN
			-- Was unmarshalling performed successfully?
			
	unmarshall_error_code: INTEGER
			-- Error code of unmarshalling error. Available if not
			-- 'unmarshall_ok'. See XRPC_CONSTANTS for error codes. 
	
feature -- Factory

	unmarshall (node: DOM_ELEMENT): XRPC_VALUE is
			-- Unmarshall value
		local
			node_elem: DOM_ELEMENT
			type_elem: DOM_ELEMENT
		do
			unmarshall_ok := True	
			-- peek at value type to correctly unmarshall
			type_elem ?= node.first_child
			if type_elem /= Void then
				if type_elem.node_name.is_equal (Array_element) then
					create {XRPC_ARRAY_VALUE} Result.unmarshall (type_elem)
				elseif type_elem.node_name.is_equal (Struct_element) then
					create {XRPC_STRUCT_VALUE} Result.unmarshall (type_elem)
				else
					create {XRPC_SCALAR_VALUE} Result.unmarshall (type_elem)
				end	
				if not Result.unmarshall_ok then
					unmarshall_ok := False
					unmarshall_error_code := Result.unmarshall_error_code
				end
			else
				-- must be an untyped string, pass the value down
				create {XRPC_SCALAR_VALUE} Result.unmarshall (node)
				if not Result.unmarshall_ok then
					unmarshall_ok := False
					unmarshall_error_code := Result.unmarshall_error_code
				end
			end
		end

	build (value: ANY): XRPC_VALUE is
			-- Build a new XML-RPC value from 'value'. Return Void if 'value' is not
			-- a valid XML-RPC type.
		require
			value_exists: value /= Void
		local
			array: ARRAY [ANY]
			struct: DS_HASH_TABLE [ANY, STRING]
		do
			-- check type and create appropriate concrete value type
			if valid_scalar_type (value) then
				create {XRPC_SCALAR_VALUE} Result.make (value)
			elseif valid_array_type (value) then
				array ?= value
				create {XRPC_ARRAY_VALUE} Result.make_from_array (array)
			elseif valid_struct_type (value) then	
				struct ?= value
				create {XRPC_STRUCT_VALUE} Result.make_from_struct (struct)
			end
		ensure
			value_exists_if_valid_type: valid_scalar_type (value) 
				or valid_array_type (value)
				or valid_struct_type (value)
				implies Result /= Void
		end
		
invariant
	
	unmarshall_error: not unmarshall_ok implies unmarshall_error_code > 0

end -- class XRPC_VALUE_FACTORY
