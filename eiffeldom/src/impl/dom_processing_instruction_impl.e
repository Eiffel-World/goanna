indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

class DOM_PROCESSING_INSTRUCTION_IMPL

inherit

	DOM_PROCESSING_INSTRUCTION

	DOM_CHARACTER_DATA_IMPL
		redefine
			node_name, node_type, node_value
		end

feature

	target: DOM_STRING
			-- The target of this processing instruction. XML defines this as being
			-- the first token following the markup that begins the processing 
			-- instruction.
	
feature -- from DOM_NODE

	node_type: INTEGER is
		once
			Result := Processing_instruction_node
		end
	
	node_name: DOM_STRING is
		do
			Result := target
		end

	node_value: DOM_STRING is
		do
			Result := data
		end

end -- class DOM_PROCESSING_INSTRUCTION_IMPL
