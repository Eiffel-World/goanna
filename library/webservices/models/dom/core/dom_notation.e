indexing
	description: "Notation"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Document Object Model (DOM) Core"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class DOM_NOTATION

inherit

   DOM_NODE

feature

	public_id: DOM_STRING is
			-- The public identifier of this notation. If the public identifier was 
			-- not specified, this is Void.
		deferred
		end

	system_id: DOM_STRING is
			-- The system identifier of this notation. If the system identifier was
			-- not specified, this is Void.
		deferred
		end
  
end -- class DOM_NOTATION
