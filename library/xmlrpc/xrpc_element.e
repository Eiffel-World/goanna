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

	unmarshall (node: XM_ELEMENT) is
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

	get_named_element (parent: XM_ELEMENT; name: UC_STRING): XM_ELEMENT is
			-- Search for and return first element with tag name 'name'. Return
			-- Void if not found.
		require
			parent_exists: parent /= Void
			name_exists: name /= Void
		local
			child_node_cursor: DS_BILINEAR_CURSOR [XM_NODE]
			child: XM_ELEMENT
			found: BOOLEAN
		do
			if not parent.is_empty then
				from
					child_node_cursor := parent.new_cursor
					child_node_cursor.start
				until		
					child_node_cursor.off or found
				loop
					child ?= child_node_cursor.item
					check
						node_is_element: child /= Void
					end
					if child.name.is_equal (name) then
						Result := child
						found := True
					end
					child_node_cursor.forth			
				end
			end
		end

invariant
	
	unmarshall_error: not unmarshall_ok implies unmarshall_error_code > 0
	
end -- class XRPC_ELEMENT
