indexing

	description: "Eiffel code generator for DOM structuros"
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class CODE_GENERATOR

creation

	make

feature -- Initialisation

	make (name: STRING; destination: STRING) is
			-- Create a new code generator to produce Eiffel code
			-- on 'destination.
		require
			name_exists: name /= Void
			destination_exists: destination/= Void
		do
			doc_name := name
			doc_name.to_upper
			create {PLAIN_TEXT_FILE} dest.make_open_write (destination)
		end

feature -- Generation

	generate (doc: DOM_DOCUMENT) is
			-- Create an Eiffel class to represent 'doc'
		require
			doc_exists: doc /= Void
		do
			document := doc
			create eiffel_code.make (doc_name + Xmle_class_name_extension)
			--build_indexing_clause
			build_inheritance_clause
			build_creation_routines
			build_build_document_routine
			eiffel_code.write (dest)
			dest.close
		end

feature {NONE} -- Implementation

	Xmle_class_name_extension: STRING is "_XMLE"

	doc_name: STRING
			-- Name of document

	dest: IO_MEDIUM
			-- Output medium to generate code to.

	document: DOM_DOCUMENT
			-- The document to produce

	eiffel_code: EIFFEL_CLASS
			-- The Eiffel code representation.

	build_indexing_clause is
			-- Generate indexing clause
		do
		end

	build_inheritance_clause is
			-- Build inheritance clause
		do
		end

	build_creation_routines is
			-- build creation clause and creation routines
		local
			feature_group: EIFFEL_FEATURE_GROUP
			make_feature: EIFFEL_ROUTINE
		do
			eiffel_code.add_creation_procedure_name ("make")
			-- build make procedure
			create feature_group.make ("Initialisation")
			eiffel_code.add_feature_group (feature_group)
			create make_feature.make ("make")
			make_feature.add_body_line ("build_document")
			feature_group.add_feature (make_feature)
		end
	
	build_build_document_routine is
			-- build the build document routine
		do
		end	

end -- class CODE_GENERATOR

