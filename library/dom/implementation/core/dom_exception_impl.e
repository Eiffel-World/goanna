indexing
	description: "Exception implementation"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Document Object Model (DOM) Core Implementation"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class DOM_EXCEPTION_IMPL

inherit

   DOM_EXCEPTION

feature

   code: INTEGER 
         -- An integer indicating the type of error generated

end -- class DOM_EXCEPTION_IMPL
