indexing
	description: "Example for generating class documentation for all Goanna clases"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class ALL_CLASSES

creation

	make

feature 

	make is
		do
			-- test encoder
			create base_64_encoder
			print (base_64_encoder.encode ("Hello there!") + "%R%N")
			print (base_64_encoder.encode ("Hello there!x") + "%R%N")
			print (base_64_encoder.encode ("Hello there!xx") + "%R%N")
			print (base_64_encoder.encode_for_session_key ("Hello there!") + "%R%N")
			print (base_64_encoder.encode_for_session_key ("Hello there!x") + "%R%N")
			print (base_64_encoder.encode_for_session_key ("Hello there!xx") + "%R%N")
		end

feature -- References

	dom: ALL_NODES
	serializer: DOM_XML_SERIALIZER
	factory: DOM_SERIALIZER_FACTORY
	parser: TREE_BUILDER
	xmle: XMLE
	routine: EIFFEL_ROUTINE
	date: DATE_AND_TIME
	base_64_encoder: BASE64_ENCODER
	xmle_document: XMLE_DOCUMENT
	fast_cgi: FAST_CGI_SERVLET_APP
	string_tokenizer: STRING_TOKENIZER
	io_string: IO_STRING
	character_manipulation: CHARACTER_MANIPULATION
	string_manipulation: STRING_MANIPULATION
	httpd: HTTPD
	retriever: RETRIEVER
	
	
end
