indexing
   project: "Eiffel binding for the Level 2 Document Object Model: Core";
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_NODE_IMPL

inherit

	DOM_NODE
		
feature

   node_value: DOM_STRING is
         -- The value of this node, depending on its type.
		 --| Default is Void, subclasses override to return appropriate values.
      do 
	  end

   set_node_value (v: DOM_STRING) is
         -- see `nodeValue'
		 --| Default do nothing. Descendants override.
   	  do
      end

   parent_node: DOM_NODE is
         -- The parent of this node. All nodes, except Document,
         -- DocumentFragment, and Attr may have a parent. However,
         -- if a node has just been created and not yet added to the tree,
         -- or if it has been removed from the tree, this is `Void'.
		 --| Default is Void. Descendants override.
	  do
	  end

   child_nodes: DOM_NODE_LIST 
         -- A NodeList that contains all children of this node.
         -- If there are no children, this is a NodeList containing no nodes.
         -- The content of the returned NodeList is "live" in the sense
         -- that, for instance, changes to the children of the node object
         -- that it was created from are immediately reflected in the nodes
         -- returned by the NodeList accessors; it is not a static snapshot
         -- of the content of the node.

   first_child: DOM_NODE is
         -- The first child of this node.
         -- If there is no such node, this returns `Void'.
	  do
	  end

   last_child: DOM_NODE is
         -- The last child of this node.
         -- If there is no such node, this returns `Void'.
	  do
	  end

   previous_sibling: DOM_NODE is
         -- The node immediately preceding this node.
         -- If there is no such node, this returns `Void'.
	  do
	  end

   next_sibling: DOM_NODE is
         -- The node immediately following this node.
         -- If there is no such node, this returns `Void'.
	  do
	  end

   attributes: DOM_NAMED_NODE_MAP  is
         -- A NamedNodeMap containing the attributes of this node
         -- (if it is an Element) or `Void' otherwise.
	  do
	  end
	
   owner_document: DOM_DOCUMENT 
         -- The Document object associated with this node. This is also
         -- the Document object used to create new nodes. When this node
         -- is a Document this is `Void'.

   insert_before (new_child: DOM_NODE; ref_child: DOM_NODE): DOM_NODE is
         -- Inserts the node newChild before the existing child node
         -- `refChild'. If `refChild' is `Void', insert `newChild' at the end
         -- of the list of children. If `newChild' is a DocumentFragment
         -- object, all of its children are inserted, in the same order,
         -- before `refChild'. If the `newChild' is already in the tree,
         -- it is first removed.
         -- Parameters
         --    newChild   The node to insert.
         --    refChild   The reference node, i.e., the node before
         --               which the new node must be inserted.
         -- Return Value
         --    The node being inserted.
	  do
      end

   replace_child (new_child: DOM_NODE; old_child: DOM_NODE): DOM_NODE is
         -- Replaces the child node `oldChild' with `newChild' in the list
         -- of children, and returns the `oldChild' node. If the `newChild'
         -- is already in the tree, it is first removed.
         -- Parameters
         --    newChild   The new node to put in the child list.
         --    oldChild   The node being replaced in the list.
         -- Return Value
         --    The node replaced.
	  do
      end

   remove_child (old_child: DOM_NODE): DOM_NODE is
         -- Removes the child node indicated by oldChild from the list
         -- of children, and returns it.
         -- Parameters
         --    oldChild   The node being removed.
         -- Return Value
         --    The node removed.
	  do
      end

   append_child (new_child: DOM_NODE): DOM_NODE is
         -- Adds the node `newChild' to the end of the list of children
         -- of this node. If the `newChild' is already in the tree,
         -- it is first removed.
         -- Parameters
         --    newChild   The node to add. If it is a DocumentFragment
         --               object, the entire contents of the document
         --               fragment are moved into the child list
         --               of this node
         -- Return Value
         --    The node added.
	  do
		  child_nodes.extend (new_child)
		  Result := new_child
      end

   has_child_nodes: BOOLEAN is
         -- This is a convenience method to allow easy determination
         -- of whether a node has any children.
         -- Return Value
         --    True    if the node has any children,
         --    False   if the node has no children.
		 --| Default is False.
	  do
      end

   clone_node (deep: BOOLEAN): DOM_NODE is
         -- Returns a duplicate of this node, i.e., serves as a generic copy
         -- constructor for nodes. The duplicate node has no parent
         -- (parentNode returns `Void'). Cloning an Element copies all
         -- attributes and their values, including those generated by the XML
         -- processor to represent defaulted attributes, but this method
         -- does not copy any text it contains unless it is a deep clone,
         -- since the text is contained in a child Text node. Cloning any
         -- other type of node simply returns a copy of this node.
         -- Parameters
         --    deep   If `True', recursively clone the subtree
         --           under the specified node; if `False', clone only
         --           the node itself (and its attributes, if it is
         --           an Element).
         -- Return Value
         --    The duplicate node.
	  do
      end

	normalize is
			-- Puts all Text modes in the full depth of the sub-tree underneath
			-- this Node, including attribute nodes, into a "normal" form
			-- where only stucture (eg, elements, comments, processing
			-- instructions, CDATA sections and entity references) separates
			-- Text nodes, ie, there are neither adjacent Text nodes nor empty
			-- Text nodes.
			--| No children to normalize at this level.
		do
		end

	is_supported (feature_name, version: DOM_STRING): BOOLEAN is
			-- Tests whether the DOM implementation implements a specific
			-- feature and that feature is supported by this node.
		do
			-- Result := owner_document.implementation.has_feature (feature_name, version)
		end

	namespace_uri: DOM_STRING is
			-- The namespace URI of this node, or Void if it is unspecified.
			-- This is not a computed value that is the result of a namespace
			-- lookup based on an examination of the namespace declarations
			-- in scope. It is merely the namespace URI given at creation time.
			-- For nodes of any type other than Element_node and Attribute_node
			-- and nodes created with a DOM Level 1 method, such as 
			-- create_element from the DOM_DOCUMENT interface, this is always
			-- Void.
			-- DOM Level 2.
		do
		end

	ns_prefix: DOM_STRING is
			-- The namespace prefix of this node, or Void if it is unspecified.
			-- DOM Level 2.
		do
		end

	set_prefix (new_prefix: DOM_STRING) is
			-- Set the namespace prefix of this node.
			-- DOM Level 2.
		do
		end

	local_name: DOM_STRING is
			-- Returns the local part of the qualified name of this node.
			-- DOM Level 2.
		do
		end

	has_attributes: BOOLEAN is
			-- Returns whether this node (if it is an element) has any
			-- attributes.
			-- DOM Level 2.
			--| Default is False.
		do
		end

feature {DOM_NODE} -- DOM Status Setting

	set_owner_document (doc: like owner_document) is
			-- Set the owner document of this node
		do
			owner_document := doc
		end

feature -- Validation Utility

	is_right_document (new_child: DOM_NODE): BOOLEAN is
			-- Is 'new_child' from the same document?
		do
			if node_type /= Document_node then
				Result := new_child.owner_document = owner_document
			else
				Result := True
			end
		end

	can_insert (new_child: DOM_NODE): BOOLEAN is
			-- Can 'new_child' be inserted in this node?
		do
			Result := True
		end

	has_node (old_child: DOM_NODE): BOOLEAN is
			-- Does 'old_child' exist in this node?
		do
			Result := True
		end

	readonly: BOOLEAN is
			-- Can this node be modified?
			--| Default is False.
		do
		end

	valid_prefix_chars (new_prefix: DOM_STRING): BOOLEAN is
			-- Does 'new_prefix' consist of valid namespace prefix characters?
		do
			Result := True
		end

	well_formed_prefix (new_prefix: DOM_STRING): BOOLEAN is
			-- Is 'new_prefix' a well formed namespace prefix?
		do
			Result := True
		end

feature -- Output

	output: STRING is
			-- Convenience function for debugging.
			-- String representation of node.
		do
			Result := "[" + node_name + ":" + node_value + "]"
		end
		
end -- class DOM_NODE_IMPL
