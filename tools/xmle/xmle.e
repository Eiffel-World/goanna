indexing
	description: "XML to Eiffel Compiler"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XMLE Tool"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XMLE

inherit

	KL_SHARED_ARGUMENTS
		export
			{NONE} all
		end
      
creation
	make

feature -- Initialization

	make is
		do
			-- check arguments
			parse_arguments
			if arguments_ok then
				create parser.make
				parser.parse_from_file_name (file_name)
				parser.document.normalize
				if parser.last_error = parser.Xml_err_none then
					generate_eiffel_code (parser.document)
				else
					display_parser_error
				end
			else
				show_usage
			end
		end
   
feature {NONE} -- Implementation

	parser: DOM_TREE_BUILDER

	arguments_ok: BOOLEAN
			-- Were the command line arguments parsed sucessfully?

	file_name: UCSTRING
			-- Name of file to parse.

	parse_arguments is
			-- Parse and validate the command line arguments
		local
			str: STRING
			file: FILE
		do
			if arguments.argument_count = 1 then
				str := arguments.argument (1)
				create {PLAIN_TEXT_FILE} file.make (str)
				if file.exists and file.is_readable then
					arguments_ok := True
					create file_name.make_from_string (str)
				end
			end
		end

	show_usage is
			-- Output usage message to user
		local
			str: STRING
		do
			create str.make_from_string ("Usage: xmle <xmlfilename>")
			print (str)
		end 

	display_parser_error is
			-- Output parsing error
		do
			print ("XML parser error: " + parser.last_error.out
				+ " (" + parser.last_error_description + ")")
			print ("At line: " + parser.last_line_number.out + " column: "
				+ parser.last_column_number.out)
		end

	generate_eiffel_code (document: DOM_DOCUMENT) is
			-- Generate an XMLE Eiffel class to build the parsed DOM structure
		require
			document_exists: document /= Void
		local
			code_generator: CODE_GENERATOR
		do
			create code_generator.make (document.document_element.node_name.out)
			code_generator.generate (document)
		end

feature {NONE} -- DOM object references

	dom_storage_refs: XMLE_DOM_STORAGE_REFS

end -- class XMLE
