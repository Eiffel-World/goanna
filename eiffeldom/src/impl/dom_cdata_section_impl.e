indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

class DOM_CDATA_SECTION_IMPL

inherit

	DOM_CDATA_SECTION

	DOM_TEXT_IMPL
		undefine
			node_type, node_name
		end		

creation

	make

end -- class DOM_CDATA_SECTION_IMPL
