indexing
	description: "A stack of DOM_NODES with typed accessor methods"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML Parser"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	DOM_NODE_STACK

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	
	DS_ARRAYED_STACK [DOM_TREE_NODE]

create
	make, make_equal, make_default

feature -- Access

	item_node_as_element: DOM_ELEMENT is
			-- Return current item as an element
		do
			Result ?= item.node
			check 
				is_element_node: Result /= Void
			end
		end

	find_namespace_uri_qname (qname: DOM_STRING): DOM_STRING is
			-- Find a namespace URI bound to the prefix of 'qname' if one exists.
		require
			qname_exists: qname /= Void
		local
			i: INTEGER
			c: UCCHAR
		do
			-- extract prefix
			c.make_from_character (':')
			i := qname.index_of (c, 1)
			if i /= 0 then
				Result := find_namespace_uri (qname.substring (1, i - 1), Void)
			else
				create Result.make (0)
			end
		end
		
	find_namespace_uri (ns_prefix: DOM_STRING; current_node: DOM_TREE_NODE): DOM_STRING is
			-- Find a namespace URI bound to 'ns_prefix'. Start the search in 
			-- 'current_node', if specified, then traverse stack of nodes.
			-- Return an empty string if not found
		require
			ns_prefix_exists: ns_prefix /= Void
		local
			items: like Current
			found: BOOLEAN
		do
			-- search current node for prefix
			if current_node /= Void then
				Result := current_node.find_namespace_uri (ns_prefix)
			else
				create Result.make (0)
			end
			if Result.is_empty then
				items := clone (Current)
				from
				until
					items.is_empty or found
				loop
					Result := items.item.find_namespace_uri (ns_prefix)
					if not Result.is_empty then
						found := True
					else
						items.remove
					end
				end
			end
		ensure
			empty_uri_if_not_found: Result /= Void
		end
		
end -- class DOM_NODE_STACK
