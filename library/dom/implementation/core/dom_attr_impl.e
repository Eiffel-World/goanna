indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

class DOM_ATTR_IMPL

inherit

	DOM_ATTR

	DOM_PARENT_NODE
		rename
			make as parent_make
		redefine
			set_node_value, node_value
		end
			
creation

	make

feature -- Factory creation

	make (owner_doc: DOM_DOCUMENT; new_name: DOM_STRING) is
			-- Create a new attribute node.
		require
			owner_doc_exists: owner_doc /= Void
			new_name_exists: new_name /= Void
		do
			make_without_owner (new_name)
			set_owner_document (owner_doc)
		end

	make_without_owner (new_name: DOM_STRING) is
			-- Create a new attribute node without an owner document.
		require
			new_name_exists: new_name /= Void
		do
			parent_make
			name := new_name
			specified := true
			!DOM_STRING! value.make_from_string ("")
		end

feature

   name: DOM_STRING
         -- The name of this attribute.

   specified: BOOLEAN
         -- If this attribute was explicitly given a value in the original
         -- document, this is `True'; otherwise, it is `False'. Note that
         -- the implementation is in charge of this attribute, not the
         -- user. If the user changes the value of the attribute (even if
         -- it ends up having the same value as the default value) then
         -- the `specified' flag is automatically flipped to `True'. To
         -- re-specify the attribute as the default value from the DTD,
         -- the user must delete the attribute. The implementation will
         -- then make a new attribute available with `specified' set to `False'
         -- and the default value (if one exists).
         -- In summary:
         --    If the attribute has an assigned value in the document
         --    then specified is `True', and the value is the assigned value.
         --    If the attribute has no assigned value in the document and
         --    has a default value in the DTD, then `specified' is `False',
         --    and the value is the default value in the DTD.
         --    If the attribute has no assigned value in the document and
         --    has a value of #IMPLIED in the DTD, then the attribute does
         --    not appear in the structure model of the document.
		 -- DOM Level 2.

   value: DOM_STRING
         -- The value of the attribute is returned as a string. Character
         -- and general entity references are replaced with their values.

   set_value (v: DOM_STRING) is
         -- This creates a Text node with the unparsed contents of the string.
	  do
		  value := v
      end

	owner_element: DOM_ELEMENT 
			-- The element node this attribute is attached to or Void if this 
			-- attribute is not in use.
			-- DOM Level 2.

feature -- from DOM_NODE
   
	node_name: DOM_STRING is
         -- The name of this node, depending on its type.
      do
		  Result := name
      end

	node_value: DOM_STRING is
         -- The value of this node, depending on its type.
      do 
		  Result := value
	  end

   set_node_value (v: DOM_STRING) is
         -- see `value'
   	  do
		  set_value (v)
      end

   node_type: INTEGER is
         -- A code representing the type of the underlying object.
      once
		  Result := Attribute_node
      end

end -- class DOM_ATTR_IMPL
