indexing
	description: "Objects that represent an XML-RPC call and response array parameter values."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XRPC_ARRAY_VALUE

inherit
	
	XRPC_VALUE

create

	make, make_from_array, unmarshall

feature -- Initialisation

	make (new_value: like value) is
			-- Create array value from 'new_value'. 
		require
			new_value_exists: new_value /= Void
		do
			type := Array_type
			value := new_value
			unmarshall_ok := True
		end

	make_from_array (array: ARRAY [ANY]) is
			-- Create array value from 'array'. Recursivly convert all
			-- basic types in array to XRPC_VALUE objects.
		require
			array_exists: array /= Void
			-- no_void_values: array.linear_representation.for_all ((e: ANY): BOOLEAN do Result := e /= Void end)
		local
			i: INTEGER
		do
			type := Array_type
			create value.make (array.lower, array.upper)
			from
				i := array.lower
			until
				i > array.upper
			loop
				value.put (Value_factory.build (array.item (i)), i)
				i := i + 1
			end
			unmarshall_ok := True
		end
		
	unmarshall (node: DOM_ELEMENT) is
			-- Unmarshall array value from XML node.
		local
			data: DOM_ELEMENT
			values: DOM_NODE_LIST
			next: DOM_ELEMENT
			i, length: INTEGER
			unmarshalled: XRPC_VALUE
		do
			unmarshall_ok := True
			type := Array_type
			-- child element must be <data>
			data ?= node.first_child
			if data.node_name.is_equal (Data_element) then
				-- unmarshall each value
				if data.has_child_nodes then
					values := data.child_nodes
					length := values.length
					create value.make (1, length)
					from
						i := 0
					until
						i >= length or not unmarshall_ok
					loop
						next ?= values.item (i)
						check
							next_is_element: next /= Void
						end
						if next.node_name.is_equal (Value_element) then
							-- unmarshall value and store in array
							unmarshalled := Value_factory.unmarshall (next)
							if unmarshalled.unmarshall_ok then
								value.put (unmarshalled, i + 1)
							else
								unmarshall_ok := False
								unmarshall_error_code := unmarshalled.unmarshall_error_code
							end
						else
							unmarshall_ok := False
							unmarshall_error_code := Array_contains_unexpected_element
						end
						i := i + 1
					end
				else
					unmarshall_ok := False
					unmarshall_error_code := Array_contains_no_values
				end
				
			else
				unmarshall_ok := False
				unmarshall_error_code := Array_data_element_missing
			end
		end

feature -- Mashalling

	marshall: STRING is
			-- Serialize this array param to XML format
		local
			i: INTEGER
		do	
			create Result.make (300)
			Result.append ("<value><array><data>")
			from
				i := value.lower
			until
				i > value.upper
			loop
				Result.append (value.item (i).marshall)
				i := i + 1
			end
			Result.append ("</data></array></value>")
		end

feature -- Access

	value: ARRAY [XRPC_VALUE]
			-- Array value
	
feature -- Conversion

	as_object: ANY is
			-- Return value as an object. ie, extract the actual 
			-- object value from the XRPC_VALUE.
		local
			array: ARRAY [ANY]
			i: INTEGER
		do
			create array.make (value.lower, value.upper)
			from
				i := value.lower
			until
				i > value.upper
			loop
				array.force (value.item (i).as_object, i)
				i := i + 1
			end
			Result := array
		end	
		
end -- class XRPC_ARRAY_VALUE
