indexing
   project: "Eiffel binding for the Level 2 Document Object Model: Core";
   license: "Eiffel Forum Freeware License", "see forum.txt";
   date: "$Date$";
   revision: "$Revision$";
   key: "DOM", "Document Object Model", "DOM Core";

deferred class DOM_IMPLEMENTATION

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
		require
			namespace_uri_exists: namespace_uri /= Void
			qualified_name_exists: qualified_name /= Void
			not_invalid_character_err: valid_qualified_name_chars (qualified_name)
			not_namespace_err: well_formed_namespace_qualified_name (namespace_uri, qualified_name)
			not_wrong_document_err: -- TODO: check for doctype created with different implementation
		deferred
		ensure
			valid_result: Result /= Void
			-- namespace_set: Result.namespace.equals (namespace_uri)
			-- qualified_name_set: Result.qualified_name.equals (qualified_name)
			doctype_set_if_specified: Result.doctype /= Void implies 
				Result.doctype.owner_document = Result
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
		require
			qualified_name_exists: qualified_name /= Void
			public_id_exists: public_id /= Void
			system_id_exists: system_id /= Void
			not_invalid_character_err: valid_qualified_name_chars (qualified_name)
			not_namespace_err: well_formed_qualified_name (qualified_name)	
		deferred
		ensure
			valid_result: Result /= Void
			owner_document_void: Result.owner_document = Void
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
		require
			valid_feature_name: feature_name /= Void
		deferred
		end

feature -- Non DOM Utility 

	create_empty_document (doctype: DOM_DOCUMENT_TYPE): DOM_DOCUMENT is
			-- Creates an XML DOCUMENT object of the specified type.
			-- Non DOM utility routine.
			-- Parameters:
			--	`doctype' - The type of document to be created or Void. 
		require
			not_wrong_document_err: -- TODO: check for doctype created with different implementation
		deferred
		ensure
			valid_result: Result /= Void
			doctype_set_if_specified: Result.doctype /= Void implies 
				Result.doctype.owner_document = Result
		end

feature -- Validation Utility 

	valid_qualified_name_chars (qualified_name: DOM_STRING): BOOLEAN is
			-- Does 'qualified_name' contain valid characters?
		do
			Result := True
		end

	well_formed_qualified_name (qualified_name: DOM_STRING): BOOLEAN is
			-- Is 'qualified_name' well formed?
		do
			Result := True
		end

	well_formed_namespace_qualified_name (namespace_uri, qualified_name: DOM_STRING): BOOLEAN is
			-- Is 'qualified_name' a well formed name within 'namespace_uri'?
		do
			Result := True
		end

end -- class DOM_IMPLEMENTATION
