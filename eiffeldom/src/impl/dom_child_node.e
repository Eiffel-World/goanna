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

   previous_sibling: DOM_NODE
         -- The node immediately preceding this node.
         -- If there is no such node, this returns `Void'.
	 
   next_sibling: DOM_NODE
         -- The node immediately following this node.
         -- If there is no such node, this returns `Void'.
	  
   parent_node: DOM_NODE
         -- The parent of this node. All nodes, except Document,
         -- DocumentFragment, and Attr may have a parent. However,
         -- if a node has just been created and not yet added to the tree,
         -- or if it has been removed from the tree, this is `Void'.
		 --| Default is Void. Descendants override.

feature {DOM_NODE} -- DOM Status Setting

	set_previous_sibling (new_sibling: like previous_sibling) is
			-- Set the previous sibling of this node
		do
			previous_sibling := new_sibling
		end

	set_next_sibling (new_sibling: like next_sibling) is
			-- Set the next sibling of this node
		do
			next_sibling := new_sibling
		end

	set_parent_node (new_parent: like parent_node) is
			-- Set the parent node of this node
		do
			parent_node := new_parent
		end

end -- class DOM_CHILD_NODE
