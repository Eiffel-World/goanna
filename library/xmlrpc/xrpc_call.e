indexing
	description: "Objects that represent an XML-RPC call."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XRPC_CALL

inherit
	
	XRPC_ELEMENT
	
creation
	
	make, unmarshall
	
feature -- Initialisation

	make (new_method: STRING) is
			-- Initialise 
		require
			new_method_exists: new_method /= Void
		do
			method_name := new_method
			create params.make_default
		end
		
	unmarshall (node: DOM_NODE) is
			-- Initialise XML-RPC call from DOM element.
		do
		end
	
feature -- Access

	method_name: STRING
			-- Name of method to call
			
	params: DS_LINKED_LIST [XRPC_PARAM]
			-- Call parameters

feature -- Status setting

	set_method_name (new_name: STRING) is
			-- Set method to call to 'new_name'
		require
			new_name_exists: new_name /= Void
		do
			method_name := new_name
		end

	add_param (new_param: XRPC_PARAM) is
			-- Add 'new_param' to the list of parameters to send
			-- with this call.
		require
			new_param_exists: new_param /= Void
		do
			params.force_last (new_param)
		end
	
feature -- Marshalling

	marshall: STRING is
			-- Serialize this call to XML format
		local
			c: DS_LINKED_LIST_CURSOR [XRPC_PARAM]
		do
			create Result.make (300)
			Result.append ("<?xml version=%"1.0%"?><methodCall><methodName>")
			Result.append (method_name)
			Result.append ("</methodName>")
			if not params.is_empty then
				Result.append ("<params>")
				from
					c := params.new_cursor
					c.start
				until
					c.off
				loop
					Result.append (c.item.marshall)
					c.forth
				end
				Result.append ("</params>")
			end
			Result.append ("</methodCall>")
		end
	
invariant
	
	method_name_set: method_name /= Void
	params_exists: params /= Void
	
end -- class XRPC_CALL
