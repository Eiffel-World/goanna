indexing
	license: "Eiffel Forum Freeware License", "see forum.txt";
	date: "$Date$";
	revision: "$Revision$";
	key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_CHILD_AND_PARENT_NODE

inherit
	
	DOM_PARENT_NODE
		undefine
			previous_sibling,
			next_sibling,
			set_previous_sibling,
			set_next_sibling,
			parent_node,
			set_parent_node
		end
		
	DOM_CHILD_NODE
		undefine
			first_child,
			last_child, 
			has_child_nodes,
			normalize,
			ensure_child_list_exists	
		end

end -- class DOM_CHILD_AND_PARENT_NODE
