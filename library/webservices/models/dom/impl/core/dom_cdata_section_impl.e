indexing
	description: "CDATA section implementation"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Document Object Model (DOM) Core Implementation"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class DOM_CDATA_SECTION_IMPL

inherit

	DOM_CDATA_SECTION

	DOM_TEXT_IMPL
		undefine
			node_type, node_name
		end		

creation

	make

end -- class DOM_CDATA_SECTION_IMPL
