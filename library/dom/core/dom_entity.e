indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_ENTITY

inherit

   DOM_NODE

feature

	public_id: DOM_STRING is
			-- The public identifier associated with the entity, if specified.
			-- For parsed entities, this is Void.
		deferred
		end

	system_id: DOM_STRING is
			-- The system identifier associated with the entity, if specified.
			-- If the system identifier was not specified, this is Void.
		deferred
		end

	notation_name: DOM_STRING is
			-- For unparsed entities, the name of the notation for the entity. For
			-- parsed entities, this is Void.
		deferred
		end
	
end -- class DOM_ENTITY
