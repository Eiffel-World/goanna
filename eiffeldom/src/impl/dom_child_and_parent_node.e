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
			parent_node
		end
		
	DOM_CHILD_NODE
		undefine
			make,
			first_child,
			last_child, 
			has_child_nodes,
			normalize	
		end

end -- class DOM_CHILD_AND_PARENT_NODE
