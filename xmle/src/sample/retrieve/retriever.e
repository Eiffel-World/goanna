indexing
   description: "XMLE DOM document retriever and displayer"

class
	RETRIEVER

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
			doc: XMLE_DOCUMENT_WRAPPER
			writer: DOM_WRITER
		do
			-- check arguments
			parse_arguments
			if arguments_ok then
				-- retrieve the object
				file.open_read
				doc ?= file.retrieved
				-- print the tree
				node_impl ?= doc.document
				create writer
				writer.output(node_impl)
			else
				show_usage
			end
		end
   
feature {NONE} -- Implementation

	arguments_ok: BOOLEAN
			-- Were the command line arguments parsed sucessfully?

	name: STRING

	file_name: STRING
			-- Name of file to parse.

	file: FILE
			-- File to read document from.

	parse_arguments is
			-- Parse and validate the command line arguments
		local
			str: STRING
		do
			if arguments.argument_count = 1 then
				name := arguments.argument (1)
				create {RAW_FILE} file.make (name + ".bdom")
				if file.exists and file.is_readable then
					arguments_ok := True
					file_name := name + ".bdom"
				end
			end
		end

	show_usage is
			-- Output usage message to user
		local
			str: STRING
		do
			create str.make_from_string ("Usage: retriever <xmleclassname>")
			print (str)
		end 

feature {NONE} -- DOM storage references

	dom_storage_refs: XMLE_DOM_STORAGE_REFS

end -- class RETRIEVER
