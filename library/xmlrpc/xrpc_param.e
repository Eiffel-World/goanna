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
		end

	unmarshall (node: DOM_NODE) is
			-- Unmarshall array value from XML node.
		do
		end

feature -- Mashalling

	marshall: STRING is
			-- Serialize this array param to XML format
		local
			i: INTEGER
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

	value_exists: value /= Void

end -- class XRPC_PARAM
