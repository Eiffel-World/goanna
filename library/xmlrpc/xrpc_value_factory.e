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
				unmarshall_ok := False
				unmarshall_error_code := Param_value_type_element_missing
			end
		end

invariant
	
	unmarshall_error: not unmarshall_ok implies unmarshall_error_code > 0

end -- class XRPC_VALUE_FACTORY
