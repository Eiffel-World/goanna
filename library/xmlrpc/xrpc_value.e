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

invariant
	
	type_exists: type /= Void
		
end -- class XRPC_VALUE
