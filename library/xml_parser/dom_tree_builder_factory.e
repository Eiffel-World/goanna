indexing
	description: "A DOM tree based XML parser factory"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML Parser"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	DOM_TREE_BUILDER_FACTORY

inherit

	XM_PARSER_FACTORY
		export
			{NONE} all
		end
   
feature -- Factory methods

	create_parser: DOM_TREE_BUILDER is
			-- Create a dom tree builder that uses the Expat XML
			-- parser
		do
			--create Result.make (new_expat_event_parser_imp)
			create Result.make (new_eiffel_event_parser_imp)
		end 
      
end -- class DOM_TREE_BUILDER_FACTORY
