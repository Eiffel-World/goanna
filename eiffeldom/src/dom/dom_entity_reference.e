indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_ENTITY_REFERENCE

inherit

	DOM_NODE

feature

	name: DOM_STRING is
			-- Name of the entity reference
		deferred
		end

end -- class DOM_ENTITY_REFERENCE
