indexing
  title: "The abstraction of an ordered collection of nodes, %
         %without defining or constraining how this collection %
         %is implemented.",
         "The items are accessible via an integral index, starting from 0.";
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Version: $";
   key: "DOM", "Document Object Model", "DOM Core";

class DOM_NODE_LIST_IMPL

inherit

	DOM_NODE_LIST
		undefine
			copy, is_equal
		end

	ARRAYED_LIST [DOM_NODE]
		rename
			make as arrayed_list_make,
			item as cursor_item,
			count as length
		end

creation

	make

feature -- Creation

	make is
			-- Create new empty node list.
		do
			arrayed_list_make (0)
		end

feature -- Access

	item (i: INTEGER): DOM_NODE is
         -- Returns the `index'th item in the collection. If `index'
         -- is greater than or equal to the number of nodes in the list,
         -- this returns `Void'.
         -- Parameters
         --    index   Index into the collection.
         -- Return Value
         --    The node at the `index'th position in the NodeList,
         --    or `Void' if that is not a valid index.
	  local 
		  adjusted_index: INTEGER
      do
		  -- adjust index and check if valid
		  adjusted_index := i + 1
		  if valid_index (adjusted_index) then
			  Result := Void
		  else
			  Result := i_th (adjusted_index)
		  end
      end


end -- class DOM_NODE_LIST_IMPL
