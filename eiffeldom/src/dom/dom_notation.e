indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_NOTATION

inherit

   DOM_NODE

feature

	public_id: DOM_STRING is
			-- The public identifier of this notation. If the public identifier was 
			-- not specified, this is Void.
		deferred
		end

	system_id: DOM_STRING is
			-- The system identifier of this notation. If the system identifier was
			-- not specified, this is Void.
		deferred
		end
  
end -- class DOM_NOTATION
