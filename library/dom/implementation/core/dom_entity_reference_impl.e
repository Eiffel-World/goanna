indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

class DOM_ENTITY_REFERENCE_IMPL

inherit

	DOM_ENTITY_REFERENCE

	DOM_CHILD_AND_PARENT_NODE
		rename
			make as child_parent_make
		end

creation

	make

feature {DOM_DOCUMENT} -- Factory creation

	make (owner_doc: DOM_DOCUMENT; new_name: DOM_STRING) is
			-- Create a new entity reference node
		do
			child_parent_make
			set_owner_document (owner_doc)
			name := new_name
		end

feature

	name: DOM_STRING
			-- The name of the entity reference.

feature -- from DOM_NODE
   
	node_name: DOM_STRING is
         -- The name of this node, depending on its type.
      do
		  Result := name
      end

   node_type: INTEGER is
         -- A code representing the type of the underlying object.
      once
		  Result := Entity_reference_node
      end

end -- class DOM_ENTITY_REFERENCE_IMPL
