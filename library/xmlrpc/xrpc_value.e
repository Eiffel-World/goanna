indexing
	description: "Objects that represent an XML-RPC call and response parameter values."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class

	XRPC_VALUE

inherit
	
	XRPC_ELEMENT
	
feature -- Access

	type: STRING
			-- Type of parameter (used as the tag value)

feature -- Conversion

	as_object: ANY is
			-- Return value as an object. ie, extract the actual 
			-- object value from the XRPC_VALUE.
		deferred
		end
		
invariant
	
	type_exists: unmarshall_ok implies type /= Void
		
end -- class XRPC_VALUE
