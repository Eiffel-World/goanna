indexing
   title: "The content of a comment, i.e., all the characters between %
          %the starting '<!--' and ending '-->'. Note that this is %
          %the definition of a comment in XML, and, in practice, HTML, %
          %although some HTML tools may implement the full SGML comment %
          %structure."
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_COMMENT

inherit

   DOM_CHARACTER_DATA

feature -- from DOM_NODE


	node_type: INTEGER is
		once
			Result := Comment_node
		end

	node_name: DOM_STRING is
		once
			!! Result.make_from_string ("#comment")
		end

end -- class DOM_COMMENT
