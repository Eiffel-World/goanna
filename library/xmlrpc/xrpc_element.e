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
			{ANY} valid_scalar_type, valid_array_type, valid_struct_type
		end
	
feature -- Initialization

	unmarshall (node: DOM_ELEMENT) is
			-- Initialise XML-RPC element from DOM node.
		require
			node_exists: node /= Void
		deferred			
		end

feature -- Status report

	unmarshall_ok: BOOLEAN
			-- Was unmarshalling performed successfully?
			
	unmarshall_error_code: INTEGER
			-- Error code of unmarshalling error. Available if not
			-- 'unmarshall_ok'. See XRPC_CONSTANTS for error codes. 
			
feature -- Mashalling

	marshall: STRING is
			-- Serialize this element to XML format
		deferred	
		end

feature {NONE} -- Implementation

	get_named_element (parent: DOM_ELEMENT; name: DOM_STRING): DOM_ELEMENT is
			-- Search for and return first element with tag name 'name'. Return
			-- Void if not found.
		require
			parent_exists: parent /= Void
			name_exists: name /= Void
		local
			number_children, index: INTEGER
			child_nodes: DOM_NODE_LIST
			child: DOM_ELEMENT
			found: BOOLEAN
		do
			if parent.has_child_nodes then
				from
					child_nodes := parent.child_nodes
					number_children := child_nodes.length
					index := 0
				variant
					number_children - index + 1
				until		
					index >= number_children or found
				loop
					child ?= child_nodes.item (index)
					check
						node_is_element: child /= Void
					end
					if child.node_name.is_equal (name) then
						Result := child
						found := True
					end
					index := index + 1			
				end
			end
		end

invariant
	
	unmarshall_error: not unmarshall_ok implies unmarshall_error_code > 0
	
end -- class XRPC_ELEMENT
