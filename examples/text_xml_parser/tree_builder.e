indexing
	description: "DOM tree builder"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	TREE_BUILDER

inherit

	KL_SHARED_ARGUMENTS
		export
			{NONE} all
		end
      
creation
	make

feature -- Initialization

	make is
		local
			node_impl: DOM_NODE_IMPL
			writer: DOM_WRITER
		do
			-- check arguments
			parse_arguments
			if arguments_ok then
				create parser.make
				parser.parse_from_file_name (file_name)
				-- print the tree
				node_impl ?= parser.document
				create writer
				writer.output(node_impl)
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
			create str.make_from_string ("Usage: tree_builder <xmlfilename>")
			print (str)
		end -- class TREE_BUILDER

end -- class TREE_BUILDER