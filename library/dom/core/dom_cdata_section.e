indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_CDATA_SECTION

inherit

	DOM_TEXT
		redefine
			node_name, node_type
		end

feature

	node_type: INTEGER is
		once
			Result := Cdata_section_node
		end

	node_name: DOM_STRING is
		once
			!! Result.make_from_string ("#cdata-section")
		end

end -- class DOM_CDATA_SECTION
