indexing
   title : "Collections of nodes that can be accessed by name. %
           %NamedNodeMaps are not maintained in any particular order. %
           %Objects contained in an object implementing NamedNodeMap %
           %may also be accessed by an ordinal index, but this is %
           %simply to allow convenient enumeration of the contents %
           %of a NamedNodeMap, and does not imply that the DOM specifies %
           %an order to these Nodes.";
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

class DOM_NAMED_NODE_MAP_IMPL

inherit

	DOM_NAMED_NODE_MAP
		undefine
			is_equal, copy
		end

	HASH_TABLE [DOM_NODE, DOM_STRING]
		rename
			count as length,
			make as hashtable_make,
			ds_item as get_named_item,
			item as hash_item,
			has as has_named_item
		end

creation

	make

feature -- Factory creation

	make (new_owner: like owner_node) is
			-- Create new named node map for 'owner_node'
		require
			owner_node_exists: new_owner /= Void
		do
			hashtable_make (5)
			set_owner_node (new_owner)
		end
			
feature

	owner_node: DOM_NODE
			-- The owner of this node map.

	set_owner_node (new_owner: like owner_node) is
			-- Set the owner node
		require
			new_owner_exists: new_owner /= Void
		do
			owner_node := new_owner
		end

   set_named_item (arg: DOM_NODE): DOM_NODE is
         -- Adds a node using its nodeName attribute.
         -- As the nodeName attribute is used to derive the name
         -- which the node must be stored under, multiple nodes
         -- of certain types (those that have a "special" string value)
         -- cannot be stored as the names would clash. This is seen
         -- as preferable to allowing nodes to be aliased.
         -- Parameters
         --    arg   A node to store in a named node map.
         --          The node will later be accessible
         --          using the value of the nodeName attribute
         --          of the node. If a node with that name
         --          is already present in the map, it is replaced
         --          by the new one.
         -- Return Value
         --    If the new Node replaces an existing node with the same name
         --    the previously existing Node is returned, otherwise null
         --    is returned.
	  do
		  put (arg, arg.node_name)
		  Result := arg
      end

   remove_named_item (name: DOM_STRING): DOM_NODE is
         -- Removes a node specified by `name'. If the removed node
         -- is an Attr with a default value it is immediately replaced.
         -- Parameters
         --    name   The name of a node to remove.
         -- Return Value
         --    The node removed from the map.
		 -- Note: precondition 'not_not_found_err' is not standard DOM.
	  do
		  Result := get_named_item (name)
		  remove (name)
      end

	get_named_item_ns (namespace_uri, local_name: DOM_STRING): DOM_NODE is
			-- Retrieves a node specified by local name and namespace URI.
			-- DOM Level 2.
			-- Note: precondition 'has_item' is not standard DOM.
		do
		end

	set_named_item_ns (arg: DOM_NODE): DOM_NODE is
			-- Adds a node using its namespace_uri and local_name. If a node
			-- with that namespace URI and local name is already present in this
			-- map, it is replaced by the new one.
			-- DOM Level 2.
		do
      	end

	remove_named_item_ns (namespace_uri, local_name: DOM_STRING): DOM_NODE is
			-- Removes a node specified by local name and namespace URI.
			-- A removed attribute may be known to have a default value when
			-- this map contains the attributes attached to an element,
			-- as returned by the attributes attribute fo the DOM_NODE interface.
			-- If so, an attribute immediately appears containing teh default
			-- value as well as the corresponding namespace URI, local name,
			-- and prefix when applicable.
			-- DOM Level 2.
			-- Note: precondition 'not_not_found_err' is not standard DOM.
		do
      	end
		
	has_named_item_ns (namespace_uri, local_name: DOM_STRING): BOOLEAN is
			-- Does an item named 'local_name' in 'namespace_uri' 
			-- exist in this map?
		do
		end

   item (index: INTEGER): DOM_NODE is
         -- Returns the `index'th item in the map. If index is greater
         -- than or equal to the number of nodes in the map,
         -- this returns null.
         -- Parameters
         --    index   Index into the map.
         -- Return Value
         --    The node at the `index'th position in the NamedNodeMap,
         --    or null if that is not a valid index.
      local
		  normalized_index: INTEGER
		  local_keys: ARRAY [DOM_STRING]
	  do
		  normalized_index := index + 1
		  if normalized_index <= local_keys.count then
			  Result := get_named_item (local_keys.item (normalized_index))
		  end
      end

end -- class DOM_NAMED_NODE_MAP_IMPL
