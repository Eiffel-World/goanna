indexing
	description: "Objects that represent an XML-RPC fault."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XRPC_FAULT

inherit
	
	XRPC_ELEMENT
	
creation
	
	make, unmarshall
	
feature -- Initialisation

	make (new_code: INTEGER; new_string: STRING) is
			-- Initialise 
		require
			new_string_exists: new_string /= Void
		do
			code := new_code
			string := new_string
		end
		
	unmarshall (node: DOM_NODE) is
			-- Initialise XML-RPC call from DOM element.
		do
		end
	
feature -- Access

	code: INTEGER
			-- Fault code

	string: STRING
			-- Fault string

feature -- Status setting

	set_code (new_code: INTEGER) is
			-- Set new fault code
		do
			code := new_code
		end

	set_string (new_string: STRING) is
			-- Set new fault string
		do
			string := new_string
		end

feature -- Marshalling

	marshall: STRING is
			-- Serialize this fault to XML format
		do
			create Result.make (200)
			Result.append ("<?xml version=%"1.0%"?><methodResponse><fault><value><struct><member><name>faultCode</name><value><int>")
			Result.append (code.out)
			Result.append ("</int></value></member><member><name>faultString</name><value><string>")
			Result.append (string)
			Result.append ("</string></value></member></struct></value></fault></methodResponse>")
		end

invariant
	
	string_exists: string /= Void
	
end -- class XRPC_FAULT
