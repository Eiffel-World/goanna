indexing
	description: "Objects that represent an XML-RPC call and response struct parameter values."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XRPC_STRUCT_VALUE

inherit
	
	XRPC_VALUE

creation

	make, unmarshall

feature -- Initialisation

	make (new_value: like value) is
			-- Create struct type from 'new_value'. 
		require
			new_value_exists: new_value /= Void
		do
			type := Struct_type
			value := new_value
		end

	unmarshall (node: DOM_NODE) is
			-- Unmarshall struct value from XML node.
		do
		end

feature -- Mashalling

	marshall: STRING is
			-- Serialize this struct param to XML format
		local
			c: DS_HASH_TABLE_CURSOR [XRPC_VALUE, STRING]
		do	
			create Result.make (300)
			Result.append ("<value><struct>")
			from
				c := value.new_cursor
				c.start
			until
				c.off
			loop
				Result.append ("<member><name>")
				Result.append (c.key)
				Result.append ("</name>")
				Result.append (c.item.marshall)
				Result.append ("</member>")
				c.forth
			end
			Result.append ("</struct></value>")
		end

feature -- Access

	value: DS_HASH_TABLE [XRPC_VALUE, STRING]
		-- Structure value
		
end -- class XRPC_STRUCT_VALUE
