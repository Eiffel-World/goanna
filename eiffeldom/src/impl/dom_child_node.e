indexing
	license: "Eiffel Forum Freeware License", "see forum.txt";
	date: "$Date$";
	revision: "$Revision$";
	key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_CHILD_NODE

inherit
	
	DOM_NODE_IMPL
		redefine
			previous_sibling,
			next_sibling,
			parent_node,
			set_parent_node
		end
		
feature

   previous_sibling: DOM_NODE is
         -- The node immediately preceding this node.
         -- If there is no such node, this returns `Void'.
	  do
	  end

   next_sibling: DOM_NODE is
         -- The node immediately following this node.
         -- If there is no such node, this returns `Void'.
	  do
	  end

   parent_node: DOM_NODE
         -- The parent of this node. All nodes, except Document,
         -- DocumentFragment, and Attr may have a parent. However,
         -- if a node has just been created and not yet added to the tree,
         -- or if it has been removed from the tree, this is `Void'.
		 --| Default is Void. Descendants override.

	set_parent_node (new_parent: like parent_node) is
			-- Set the parent node of this node
		do
			parent_node := new_parent
		end

end -- class DOM_CHILD_NODE
