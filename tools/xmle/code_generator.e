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
			-- construct all required names
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
			build_xmle_document_wrapper
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

	document_wrapper: XMLE_DOCUMENT_WRAPPER
			-- The document storage wrapper

	document: DOM_DOCUMENT
			-- The document to produce

	xmle_document_class: EIFFEL_CLASS
			-- The Eiffel code representation.

	build_xmle_document_wrapper is
			-- Construct the wrapper object.
		do
			create document_wrapper.make (document)
		end

	build_xmle_document_class is
			-- Generate the code for the XMLE document wrapper class.
		local
			dest: IO_MEDIUM
		do
			create xmle_document_class.make (class_name)
			build_indexing_clause
			build_inheritance_clause
			build_creation_routine
			build_bdom_file_name_constant
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
		do
			xmle_document_class.add_creation_procedure_name ("make")
		end
	
	build_bdom_file_name_constant is
			-- build the constant holding the name of the binary DOM file
		local
			group: EIFFEL_FEATURE_GROUP
			attr: EIFFEL_ATTRIBUTE
		do
			create group.make ("Implementation")
			xmle_document_class.add_feature_group (group)
			create attr.make ("bdom_file_name", "STRING")
			attr.set_value ("%"" + bdom_file_name + "%"")
			group.add_feature (attr)
		end	

	store_document is
			-- Store the document object structure in the file 'bdom_file_name'.
		do
			document_wrapper.store_by_name (bdom_file_name)
		end

end -- class CODE_GENERATOR

