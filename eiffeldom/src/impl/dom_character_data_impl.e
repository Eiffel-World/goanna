indexing
   title: "Accessing character data in the DOM. For clarity this set %
          %is defined here rather than on each object that uses these %
          %attributes and methods. No DOM objects correspond directly %
          %to CharacterData, though Text and others do inherit %
          %the interface from it. All offsets in this interface start from 0.";
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_CHARACTER_DATA_IMPL

inherit

	DOM_CHARACTER_DATA

	DOM_CHILD_NODE
		redefine
			set_node_value, node_value
		end

feature {DOM_DOCUMENT} -- Factory creation

	make (new_owner: DOM_DOCUMENT; new_data: DOM_STRING) is
			-- Create character data
		require
			owner_exists: new_owner /= Void
			new_data_exists: new_data /= Void
		do
			set_owner_document (new_owner)
			set_data (new_data)
		end

feature

   data: DOM_STRING 
         -- The character data of the node that implements this interface.
         -- The DOM implementation may not put arbitrary limits on the amount
         -- of data that may be stored in a CharacterData node. However,
         -- implementation limits may mean that the entirety of a node's data
         -- may not fit into a single DOMString. In such cases, the user
         -- may call substringData to retrieve the data in appropriately
         -- sized pieces.

   set_data (v: DOM_STRING) is
         -- see `data'
	  do
			data := v
      end

   length: INTEGER is 
         	-- The number of characters that are available through data
         	-- and the substringData method below. This may have the value
         	-- zero, i.e., CharacterData nodes may be empty.
		do
			Result := data.count
		end
	
   substring_data (offset: INTEGER; count: INTEGER): DOM_STRING is
         -- Extracts a range of data from the node.
         -- Parameters
         --    offset   Start offset of substring to extract.
         --    count    The number of characters to extract.
         -- Return Value
         --    The specified substring. If the sum of `offset' and `count'
         --    exceeds the `length', then all characters to the end of the
         --    data are returned.
	  do
	  	  Result := data.substring (offset, offset + count)
      end

   append_data (arg: DOM_STRING) is
         -- Append the string to the end of the character data of the node.
         -- Upon success, data provides access to the concatenation
         -- of data and the DOM_String specified.
         -- Parameters
         --    arg   The DOM_String to append.
	  do
		  data.append_ucstring (arg)
      end

   insert_data (offset: INTEGER; arg: DOM_STRING) is
         -- Insert a string at the specified character offset.
         -- Parameters
         --    offset   The character offset at which to insert.
         --    arg      The DOMString to insert.
	  do
		  data.insert (arg, offset)
      end

   delete_data (offset: INTEGER; count: INTEGER) is
         -- Remove a range of characters from the node. Upon success,
         -- data and length reflect the change.
         -- Parameters
         --    offset   The offset from which to remove characters.
         --    count    The number of characters to delete. If the sum
         --             of `offset' and `count' exceeds `length' then
         --             all characters from offset to the end of the data
         --             are deleted.
	  do
--		  data.replace_substring (create {DOM_STRING}.make_from_string (""), offset, 
--			  offset + count)
      end

   replace_data (offset: INTEGER; count: INTEGER; arg: DOM_STRING) is
         -- Replace the characters starting at the specified character
         -- `offset' with the specified string.
         -- Parameters
         --    offset   The offset from which to start replacing.
         --    count    The number of characters to replace. If the sum
         --             of `offset' and `count' exceeds `length', then all
         --             characters to the end of the data are replaced
         --             (i.e., the effect is the same as a remove method call
         --             with the same range, followed by an append method
         --             invocation).
         --    arg      The DOMString with which the range must be replaced.
	  do
--		  data.replace_substring (arg, offset, offset + count)
      end

feature -- from DOM_NODE

	node_value: DOM_STRING is
		do
			Result := data
		end

	set_node_value (v: DOM_STRING) is
			-- Set the node value
		do
			set_data (v)
		end

end -- class DOM_CHARACTER_DATA_IMPL
