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

creation

	make, unmarshall

feature -- Initialisation

	make (new_value: like value) is
			-- Create array type from 'new_value'. 
		require
			new_value_exists: new_value /= Void
		do
			type := Array_type
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
			
end -- class XRPC_ARRAY_VALUE
