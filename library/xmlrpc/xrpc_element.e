indexing
	description: "Abstract objects that represent general XML-RPC element facilities."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class

	XRPC_ELEMENT

inherit
	
	XRPC_CONSTANTS
		export
			{NONE} all
		end
	
feature -- Initialization

	unmarshall (node: DOM_NODE) is
			-- Initialise XML-RPC element from DOM node.
		require
			node_exists: node /= Void
		deferred			
		end

feature -- Mashalling

	marshall: STRING is
			-- Serialize this element to XML format
		deferred	
		end

end -- class XRPC_ELEMENT
