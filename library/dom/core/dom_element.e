indexing
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_ELEMENT

inherit

   DOM_NODE

feature

   tag_name: DOM_STRING is
         -- The name of the element. For example, in:
         --    <elementExample id="demo">
         --    ...
         --    </elementExample> ,
         -- `tagName' has the value "elementExample". Note that this is
         -- case-preserving in XML, as are all of the operations of the DOM.
         -- The HTML DOM returns the `tagName' of an HTML element in the
         -- canonical uppercase form, regardless of the case in the source
         -- HTML document.
      deferred
      end

   get_attribute (name: DOM_STRING): DOM_STRING is
         -- Retrieves an attribute value by `name'.
         -- Parameters
         --    name   The name of the attribute to retrieve.
         -- Return Value
         --    The Attr value as a string, or the empty string if that
         --    attribute does not have a specified or default value.
	  require
		  name_exists: name /= Void
      deferred
	  ensure
		  result_exists: Result /= Void
      end

   set_attribute (name: DOM_STRING; value: DOM_STRING) is
         -- Adds a new attribute. If an attribute with that `name' is
         -- already present in the element, its `value' is changed to be
         -- that of the `value' parameter. This `value' is a simple string,
         -- it is not parsed as it is being set. So any markup (such as
         -- syntax to be recognized as an entity reference) is treated
         -- as literal text, and needs to be appropriately escaped by the
         -- implementation when it is written out. In order to assign
         -- an attribute `value' that contains entity references, the user
         -- must create an Attr node plus any Text and EntityReference nodes,
         -- build the appropriate subtree, and use setAttributeNode to assign
         -- it as the `value' of an attribute.
         -- Parameters
         --    name    The name of the attribute to create or alter.
         --    value   Value to set in string form.
	  require
		  name_exists: name /= Void
		  value_exists: value /= Void
		  not_invalid_character_err: valid_name_chars (name)
		  not_no_modification_allowed_err: not readonly
      deferred
	  ensure
		  attribute_set: get_attribute (name).is_equal (value)
      end

   remove_attribute (name: DOM_STRING) is
         -- Removes an attribute by `name'. If the removed attribute
         -- has a default value it is immediately replaced.
         -- Parameters
         --    name   The name of the attribute to remove.
	  require
		  name_exists: name /= Void
		  has_attribute: has_attribute (name)
		  not_no_modification_allowed_err: not readonly
      deferred
      end

   get_attribute_node (name: DOM_STRING): DOM_ATTR is
         -- Retrieves an Attr node by `name'.
         -- Parameters
         --    name   The name of the attribute to retrieve.
         -- Return Value
         --    The Attr node with the specified attribute `name' or null
         --    if there is no such attribute.
	  require
		  name_exists: name /= Void
		  has_attribute: has_attribute (name)
      deferred
	  ensure
		  result_exists: Result /= Void
		  result_name_valid: Result.name.is_equal (name)
      end

   set_attribute_node (new_attr: DOM_ATTR): DOM_ATTR is
         -- Adds a new attribute. If an attribute with that name is
         -- already present in the element, it is replaced by the new one.
         -- Parameters
         --    newAttr   The Attr node to add to the attribute list.
         -- Return Value
         --    If the newAttr attribute replaces an existing attribute
         --    with the same name, the previously existing Attr node is
         --    returned, otherwise null is returned.
	  require
		  new_attr_exists: new_attr /= Void
		  not_wrong_document_err: new_attr.owner_document = owner_document
		  not_no_modification_allowed_err: not readonly
		  not_inuse_attribute_err: new_attr.owner_element = Void
      deferred
	  ensure
		  attribute_set: has_attribute (new_attr.name)
      end

   remove_attribute_node (old_attr: DOM_ATTR): DOM_ATTR is
         -- Removes the specified attribute.
         -- Parameters
         --    oldAttr   The Attr node to remove from the attribute list.
         --              If the removed Attr has a default value it is
         --              immediately replaced.
         -- Return Value
         --    The Attr node that was removed.
	  require
		  old_attr_exists: old_attr /= Void
		  not_no_modification_allowed_err: not readonly
		  not_not_found_err: has_attribute (old_attr.name)
      deferred
	  ensure
		  result_exists: Result /= Void
		  result_removed_node: Result.name = old_attr.name
      end

   get_elements_by_tag_name (name: DOM_STRING): DOM_NODE_LIST is
         -- Returns a NodeList of all descendant elements with a given
         -- tag name, in the order in which they would be encountered
         -- in a preorder traversal of the Element tree.
         -- Parameters
         --    name   The name of the tag to match on. The special value
         --           "*" matches all tags.
         -- Return Value
         --    A list of matching Element nodes.
	  require
		  name_exists: name /= Void
      deferred
	  ensure
		  result_exists: Result /= Void
      end

	-- TODO: add getAttributeNS, setAttributeNS, removeAttributeNS,
	-- getAttributeNodeNS, setAttributeNodeNS, getElementsByTagNameNS.

	has_attribute (name: DOM_STRING): BOOLEAN is
			-- Returns true when an attribute with a given name is specified
			-- on this element or has a default value, false otherwise.
			-- DOM Level 2.
		require
			name_exists: name /= Void
		deferred
		end

	-- TODO: add has_attribute_ns

feature -- Validation Utility

	valid_name_chars (new_name: DOM_STRING): BOOLEAN is
			-- Does 'new_name' consist of valid name characters?
		require
			new_name_exists: new_name /= Void
		deferred
		end

end -- class DOM_ELEMENT
