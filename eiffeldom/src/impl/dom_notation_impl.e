indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_NOTATION_IMPL

inherit

	DOM_NOTATION

	DOM_NODE_IMPL
				
feature

	public_id: DOM_STRING
			-- The public identifier of this notation. If the public identifier was 
			-- not specified, this is Void.
		
	system_id: DOM_STRING
			-- The system identifier of this notation. If the system identifier was
			-- not specified, this is Void.
		
feature -- from DOM_NODE

	node_type: INTEGER is
		once
			Result := Notation_node
		end
  
end -- class DOM_NOTATION_IMPL
