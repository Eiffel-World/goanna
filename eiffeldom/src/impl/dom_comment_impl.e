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

class DOM_COMMENT_IMPL

inherit

	DOM_COMMENT

	DOM_CHARACTER_DATA_IMPL
		undefine
			attributes
		end

creation

	make

end -- class DOM_COMMENT_IMPL
