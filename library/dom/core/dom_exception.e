indexing
	description: "Exception"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Document Object Model (DOM) Core"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class DOM_EXCEPTION

inherit

   DOM_EXCEPTION_CODE

feature

   code: INTEGER is
         -- An integer indicating the type of error generated
      deferred
      end

end -- class DOM_EXCEPTION
