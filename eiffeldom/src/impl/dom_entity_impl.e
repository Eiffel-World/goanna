indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

class DOM_ENTITY_IMPL

inherit

	DOM_ENTITY

	DOM_PARENT_NODE

feature

	public_id: DOM_STRING is
			-- The public identifier associated with the entity, if specified.
			-- For parsed entities, this is Void.
		do
		end

	system_id: DOM_STRING is
			-- The system identifier associated with the entity, if specified.
			-- If the system identifier was not specified, this is Void.
		do
		end

	notation_name: DOM_STRING is
			-- For unparsed entities, the name of the notation for the entity. For
			-- parsed entities, this is Void.
		do
		end
	
feature -- from DOM_NODE

	node_type: INTEGER is
		once
			Result := Entity_node
		end

	node_name: DOM_STRING is
		do
			Result := notation_name
		end

end -- class DOM_ENTITY_IMPL
