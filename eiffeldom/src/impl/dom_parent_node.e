indexing
	license: "Eiffel Forum Freeware License", "see forum.txt";
	date: "$Date$";
	revision: "$Revision$";
	key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_PARENT_NODE

inherit
	
	DOM_NODE_IMPL
		redefine
			make,
			first_child,
			last_child, 
			has_child_nodes,
			normalize	
		end
		
feature {DOM_NODE}

	make is
			-- Initialise this parent node
		do
			Precursor
			create {DOM_NODE_LIST_IMPL} child_nodes.make
		end

feature

   first_child: DOM_NODE is
         -- The first child of this node.
         -- If there is no such node, this returns `Void'.
	  do
		  Result := child_nodes.first
	  end

   last_child: DOM_NODE is
         -- The last child of this node.
         -- If there is no such node, this returns `Void'.
	  do
		  Result := child_nodes.last
	  end
   
	has_child_nodes: BOOLEAN is
         -- This is a convenience method to allow easy determination
         -- of whether a node has any children.
         -- Return Value
         --    True    if the node has any children,
         --    False   if the node has no children.
	  do
		  Result := not child_nodes.empty
      end

	normalize is
			-- Puts all Text modes in the full depth of the sub-tree underneath
			-- this Node, including attribute nodes, into a "normal" form
			-- where only stucture (eg, elements, comments, processing
			-- instructions, CDATA sections and entity references) separates
			-- Text nodes, ie, there are neither adjacent Text nodes nor empty
			-- Text nodes.
			--| No children to normalize at this level.
		do
		end

invariant

	child_nodes_exist: child_nodes /= Void

end -- class DOM_PARENT_NODE
