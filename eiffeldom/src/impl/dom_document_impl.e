indexing
	project: "Eiffel binding for the Level 2 Document Object Model: Core";
	license: "Eiffel Forum Freeware License", "see forum.txt";
	date: "$Date$";
	revision: "$Revision$";
	key: "DOM", "Document Object Model", "DOM Core";

class DOM_DOCUMENT_IMPL

inherit

	DOM_DOCUMENT

	DOM_PARENT_NODE
		rename
			make as parent_node_make
		export
			{NONE} parent_node_make
		end

creation

	make

feature {DOM_IMPLEMENTATION_IMPL} -- Factory creation

	make (new_doctype: DOM_DOCUMENT_TYPE) is
			-- Create new document with specified doctype. 
			-- 'doctype' may be Void.
		do
			parent_node_make
			doctype := new_doctype
			if doctype /= Void then
				doctype.set_owner_document (Current)
			end
		ensure
			doctype_set: doctype = new_doctype
			doctype_owner_set: doctype /= Void implies doctype.owner_document = Current
		end

feature

	doctype: DOM_DOCUMENT_TYPE 
			-- The Document Type Declaration associated with this
			-- document. For HTML documents as well as XML documents
			-- without a document type declaration this returns `Void'.

	document_element: DOM_ELEMENT 
    		-- This is a convenience attribute that allows direct access
    		-- to the child node that is the root element of the document.
    		-- For HTML documents, this is the element with the tagName
    		-- "HTML".

   create_element (tag_name: DOM_STRING): DOM_ELEMENT is
         	-- Creates an element of the type specified.
         	-- Parameters
         	--    tagName   The name of the element type to instantiate.
         	--              For XML, this is case-sensitive. For HTML,
         	--              the tagName parameter may be provided in any case,
         	--              but it must be mapped to the canonical uppercase
         	--              form by the DOM implementation.
         	-- Return Value
         	--    A new Element object.
		do
			create {DOM_ELEMENT_IMPL} Result.make (Current, tag_name)
		end

	create_document_fragment: DOM_DOCUMENT_FRAGMENT is
			-- Creates an empty DocumentFragment object.
			-- Return Value
			--    A new DocumentFragment.
		do
			create {DOM_DOCUMENT_FRAGMENT_IMPL} Result.make (Current)
		end

	create_text_node (data: DOM_STRING): DOM_TEXT is
			-- Creates a Text node given the specified string.
			-- Parameters
			--    data   The data for the node.
			-- Return Value
			--    The new Text object.
		do
			create {DOM_TEXT_IMPL} Result.make (Current, data)
		end

	create_comment (data: DOM_STRING): DOM_COMMENT is
			-- Creates a Comment node given the specified string.
			-- Parameters
			--    data   The data for the node.
			-- Return Value
			--    The new Comment object.
		do
			create {DOM_COMMENT_IMPL} Result.make (Current, data)
		end

	create_cdata_section (data: DOM_STRING): DOM_CDATA_SECTION is
			-- Creates a CDATASection node whose value is the specified string.
			-- Parameters
			--    data   The data for the CDATASection [p.43] contents.
			-- Return Value
			--    The new CDATASection [p.43] object.
		do
			create {DOM_CDATA_SECTION_IMPL} Result.make (Current, data)
		end

	create_processing_instruction (target: DOM_STRING; data: DOM_STRING):
		DOM_PROCESSING_INSTRUCTION is
			-- Creates a ProcessingInstruction node given the specified name
			-- and data strings.
			-- Parameters
			--    target   The target part of the processing instruction.
			--    data     The data for the node.
			-- Return Value
			--    The new ProcessingInstruction [p.46] object.
		do
			create {DOM_PROCESSING_INSTRUCTION_IMPL} Result.make (Current, target, data)
		end

	create_attribute (name: DOM_STRING): DOM_ATTR is
			-- Creates an Attr of the given name. Note that the Attr instance
			-- can then be set on an Element using the setAttribute method.
			-- Parameters
			--    name   The name of the attribute.
			-- Return Value
			--    A new Attr object.
		do
			create {DOM_ATTR_IMPL} Result.make (Current, name)
		end

	create_entity_reference (name: DOM_STRING): DOM_ENTITY_REFERENCE is
			-- Creates an EntityReference object.
			-- Parameters
			--    name   The name of the entity to reference.
			-- Return Value
			--    The new EntityReference object.
		do
			create {DOM_ENTITY_REFERENCE_IMPL} Result.make (Current, name)
		end

	get_elements_by_tag_name (tagname: DOM_STRING): DOM_NODE_LIST is
			-- Returns a NodeList of all the Elements with a given tag name
			-- in the order in which they would be encountered in a preorder
			-- traversal of the Document tree.
			-- Parameters
			--    tagname   The name of the tag to match on.
			--              The special value "*" matches all tags.
			-- Return Value
			--    A new NodeList object containing all the matched Elements.
			-- This method raises no exceptions.
		do
		end

	import_node (imported_node: DOM_NODE; deep: BOOLEAN): DOM_NODE is
			-- Imports a node from another document to this document. The returned
			-- has no parent; ('parent_node is Void). The source node is not altered
			-- or removed from the original doeumtnt; this method creates a new copy
			-- of the source node.
			-- For all nodes, importing a node creates a node object owned by the 
			-- importing document, with attribute values identical to the source node's
			-- 'node_name' and 'node_type', plus the attributes related to namespaces
			-- ('prefix', 'local_name', and 'namespace_uri'). As in the 'clone_node'
			-- operation on a DOM_NODE, the source node is not altered.
		do
		end

	create_element_ns (new_namespace_uri, qualified_name: DOM_STRING): DOM_ELEMENT is
			-- Creates an element of the given qualified name and namespace URI.
			-- DOM Level 2.
		do
			create {DOM_ELEMENT_IMPL} Result.make_with_namespace (Current, 
				new_namespace_uri, qualified_name)
		end

feature -- from DOM_NODE
   
	node_name: DOM_STRING is
         -- The name of this node, depending on its type.
      once
		  create Result.make_from_string ("#document")
      end

   node_type: INTEGER is
         -- A code representing the type of the underlying object.
      once
		  Result := Document_node
      end

feature -- Validation Utility

	valid_name_chars (new_name: DOM_STRING): BOOLEAN is
			-- Does 'new_name' consist of valid characters for a document name?
		do
			Result := True
		end

	valid_qualified_name_chars (new_name: DOM_STRING): BOOLEAN is
			-- Does 'new_name' consist of valid characters for a qualified name?
		do
			Result := True
		end

	valid_qualified_name (new_namespace_uri, new_name: DOM_STRING): BOOLEAN is
			-- Is 'new_name' a valid name within 'new_namespace_uri'?
		do
			Result := True
		end

	valid_entity_name (new_name: DOM_STRING): BOOLEAN is
			-- Is 'new_name' a valid name for an entity?
		do
			Result := True
		end

	valid_target_chars (new_target: DOM_STRING): BOOLEAN is
			-- Does 'new_target' consist of valid target characters?
		do
			Result := True
		end
	
	valid_node_name (new_name: DOM_STRING): BOOLEAN is
			-- Is 'new_name' a valid name for a node?
		do
			Result := True
		end

	import_supported (new_node: DOM_NODE): BOOLEAN is
			-- Can 'new_node' be imported into this document?
		do
			Result := True
		end

feature {DOM_IMPLEMENTATION} -- Convenience routines

	set_document_element (e: DOM_ELEMENT) is
			-- Set the root document element.
		do
			document_element := e
		end

end -- class DOM_DOCUMENT_IMPL
