indexing
   project: "Eiffel binding for the Level 2 Document Object Model: Core";
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

class DOM_IMPLEMENTATION_IMPL

inherit

	DOM_IMPLEMENTATION

feature

	create_document (namespace_uri, qualified_name: DOM_STRING; 
		doctype: DOM_DOCUMENT_TYPE): DOM_DOCUMENT is
			-- Creates an XML DOCUMENT object of the specified type with
			-- its document element. 
			-- Introduced in DOM Level 2.
			-- Parameters:
			--	`namespace_uri' - The namespace URI of the document element to create.
			--	`qualified_name' - The qualified name of the document element to be created.
			--	`doctype' - The type of document to be created or Void. 
		local
			discard: DOM_NODE
		do
			create {DOM_DOCUMENT_IMPL} Result.make (doctype)
			discard := Result.append_child (Result.create_element_ns (namespace_uri, qualified_name))
		end

	create_document_type (qualified_name, public_id, system_id: DOM_STRING): DOM_DOCUMENT_TYPE is
			-- Creates an empty DOM_DOCUMENT_TYPE node. Entity declarations 
			-- and notations are not made available. Entity reference expansions
			-- and default attribute additions do not occur. 
			-- Introduced in DOM Level 2.
			-- Parameters:
			--	`qualified_name' - The qualified name of the document type to be created.
			--	`publid_id' - The external subset public identifier.
			--	`system_id' - The external subset system identifier.
		do	
			create {DOM_DOCUMENT_TYPE_IMPL} Result.make (Void, qualified_name, public_id, system_id)
		end

	has_feature (feature_name: DOM_STRING; version: DOM_STRING) : BOOLEAN is
			-- Test if the DOM implementation implements a specific feature.
			-- Parameters
			--  'feature_name' - The package name of the feature to test.
			--    In Level 1, the legal values are "HTML" and "XML" (case-insensitive).
			--  'version'  - This is the version number of the package name
			--    to test. In Level 1, this is the string "1.0".
			--    In Level 2, this is the string "2.0".
			--    If the version is not specified, supporting any
			--    version of the feature will cause the method to
			--    return True.
			-- Return Value
			--    True if the feature is implemented in the specified version,
			--    False otherwise.
		do
		end

end -- class DOM_IMPLEMENTATION_IMPL
