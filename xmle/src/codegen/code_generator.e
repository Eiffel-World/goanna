indexing

	description: "Eiffel code generator for DOM structuros"
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class CODE_GENERATOR

inherit

	DOM_NODE_TYPE
		export
			{NONE} all
		end

creation

	make

feature -- Initialisation

	make (name: STRING) is
			-- Create a new code generator to produce XMLE classes.
		require
			name_exists: name /= Void
		do
			document_name := name
			create class_name.make_from_string (document_name + Xmle_class_name_extension)
			class_name.to_upper
			create class_file_name.make_from_string (class_name + Xmle_class_extension)
			class_file_name.to_lower
			create bdom_file_name.make_from_string (class_name + Xmle_dom_storage_extension) 
			bdom_file_name.to_lower
		end

feature -- Generation

	generate (doc: DOM_DOCUMENT) is
			-- Create an Eiffel class to represent 'doc'
		require
			doc_exists: doc /= Void
		do
			document := doc
			build_xmle_document_class
			store_document
		end

feature {NONE} -- Implementation

	Xmle_class_name_extension: STRING is "_XMLE"
	Xmle_document_type: STRING is "XMLE_DOCUMENT"
	Xmle_class_extension: STRING is ".e"
	Xmle_dom_storage_extension: STRING is ".bdom"

	document_name: STRING
			-- Generic name of document.

	class_name: STRING
			-- Class type of generated XMLE class.

	class_file_name: STRING
			-- Name of file to store XMLE wrapper class.

	bdom_file_name: STRING
			-- Name of file to store binary representation of document.

	document: DOM_DOCUMENT
			-- The document to produce

	xmle_document_class: EIFFEL_CLASS
			-- The Eiffel code representation.

	build_xmle_document_class is
			-- Generate the code for the XMLE document wrapper class.
		local
			dest: IO_MEDIUM
		do
			create xmle_document_class.make (class_name)
			build_indexing_clause
			build_inheritance_clause
			build_creation_routine
			build_retrieve_document_routine
			create {PLAIN_TEXT_FILE} dest.make_open_write (class_file_name)
			xmle_document_class.write (dest)
			dest.close
		end

	build_indexing_clause is
			-- Generate indexing clause
		do
		end

	build_inheritance_clause is
			-- Build inheritance clause
		do
			xmle_document_class.add_parent (Xmle_document_type)
		end

	build_creation_routine is
			-- build creation clause and creation routines
		local
			feature_group: EIFFEL_FEATURE_GROUP
			make_feature: EIFFEL_ROUTINE
		do
			xmle_document_class.add_creation_procedure_name ("make")
			-- build make procedure
			create feature_group.make ("Initialisation")
			xmle_document_class.add_feature_group (feature_group)
			create make_feature.make ("make")
			make_feature.add_body_line ("retrieve_document")
			feature_group.add_feature (make_feature)
		end
	
	build_retrieve_document_routine is
			-- build the retrieve document routine
		local
			feature_group: EIFFEL_FEATURE_GROUP
			build_doc_routine: EIFFEL_ROUTINE
			pair: DS_PAIR [STRING, STRING]
		do
			create feature_group.make ("Implementation")
			feature_group.add_export ("NONE")
			xmle_document_class.add_feature_group (feature_group)
			-- create build document routine
			create build_doc_routine.make ("retrieve_document")
			feature_group.add_feature (build_doc_routine)
			-- add code to retrieve object structure
			create pair.make ("bdom_file", "RAW_FILE")
			build_doc_routine.add_local (pair)
			build_doc_routine.add_body_line ("create bdom_file.make (bdom_file_name)")
			build_doc_routine.add_body_line ("document ?= bdom_file.retrieved")
		end		
	
	store_document is
			-- Store the document object structure in the file 'bdom_file_name'.
		do
			document.store_by_name (bdom_file_name)
		end

end -- class CODE_GENERATOR

