indexing
	description: "Objects that represent an XML-RPC call and response parameters."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class

	XRPC_PARAM

inherit
	
	XRPC_ELEMENT
	
creation

	make, unmarshall

feature -- Initialisation

	make (new_value: XRPC_VALUE) is
			-- Create parameter with 'new_value'
		require
			new_value_exists: new_value /= Void
		do
			value := new_value
			unmarshall_ok := True
		end

	unmarshall (node: XM_ELEMENT) is
			-- Unmarshall array value from XML node.
		local
			value_elem: XM_ELEMENT
		do
			unmarshall_ok := True
			-- check for a value child element
			value_elem ?= node.first
			if value_elem /= Void and then value_elem.name.is_equal (Value_element) then
				value := value_factory.unmarshall (value_elem)
				if not value.unmarshall_ok then
					unmarshall_ok := False
					unmarshall_error_code := value.unmarshall_error_code
				end
			else
				unmarshall_ok := False
				unmarshall_error_code := Param_value_element_missing
			end
		end

feature -- Mashalling

	marshall: STRING is
			-- Serialize this array param to XML format
		do	
			create Result.make (1024)
			Result.append ("<param>")
			Result.append (value.marshall)
			Result.append ("</param>")
		end

feature -- Access

	value: XRPC_VALUE
			-- Value of this parameter

invariant

	value_exists: unmarshall_ok implies value /= Void

end -- class XRPC_PARAM
