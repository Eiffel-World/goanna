indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

class DOM_TEXT_IMPL

inherit

	DOM_TEXT

	DOM_CHARACTER_DATA_IMPL
		undefine
			attributes
		end

creation

	make

feature

   split_text (offset: INTEGER): DOM_TEXT is
         -- Breaks this Text node into two Text nodes at the specified
         -- `offset', keeping both in the tree as siblings. This node
         -- then only contains all the content up to the `offset' point.
         -- And a new Text node, which is inserted as the next sibling
         -- of this node, contains all the content at and after
         -- the `offset' point.
         -- Parameters
         --    offset   The offset at which to split, starting from 0.
         -- Return Value
         --    The new Text node.
	  do
      end

end -- class DOM_TEXT_IMPL
