indexing

	description: "A container for a DOM_NODE and its namespace declarations, if any"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML Parser"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	DOM_TREE_NODE

inherit
	
	UT_STRING_FORMATTER
		export
			{NONE} all
		end
		
creation
	
	make_with_attributes, make_with_node
	
feature
	
	make_with_attributes (attributes: DS_BILINEAR [DOM_ATTR]) is
			-- Create new holder and extract namespace declarations from
			-- 'attributes'.
		require
			attributes_exist: attributes /= Void
		do
			
		end
		
	make_with_node (new_node: like node) is
			-- Create new tree node holding 'new_node'
		require
			node_exists: new_node /= Void
		do
			set_node (new_node)
		end
		
feature -- Status
	
	node: DOM_NODE
			-- The node
	
	namespaces: DS_HASH_TABLE [DOM_STRING, DOM_STRING]
			-- Namespaces declared within the scope of this node
			
feature -- Status setting

	set_node (new_node: like node) is
			-- Set 'node' to 'new_node'
		require
			node_exists: new_node /= Void
		do
			node := new_node
		end
	
	find_namespace_uri (ns_prefix: UCSTRING): DOM_STRING is
			-- Find a namespace URI bound to 'ns_prefix'. Return
			-- an empty string if not found.
		require
			ns_prefix_exists: ns_prefix /= Void
		do
			if namespaces = Void then
				create Result.make (0)
			else
			
			end
			debug ("find_namespace")
				print ("Found namespace for prefix '" + ns_prefix.out + "' = " + quoted_eiffel_string_out (Result.out) + "%R%N")
			end
		ensure
			empty_uri_if_not_found: Result /= Void
		end
		
end -- class DOM_TREE_NODE
