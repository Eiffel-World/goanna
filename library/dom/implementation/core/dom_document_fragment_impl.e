indexing
	description: "Document fragment implementation"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Document Object Model (DOM) Core Implementation"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class DOM_DOCUMENT_FRAGMENT_IMPL

inherit

	DOM_DOCUMENT_FRAGMENT

	DOM_PARENT_NODE
		rename
			make as parent_node_make
		export
			{NONE} parent_node_make
		end
		
creation

	make

feature {DOM_DOCUMENT} -- Factory creation

	make (doc: DOM_DOCUMENT_IMPL) is
			-- Create new document fragment
		do
			parent_node_make
			set_owner_document (doc)
		end

feature -- from DOM_NODE

   node_type: INTEGER is
      once
         Result := Document_fragment_node
      end

	node_name: DOM_STRING is
		once
			!! Result.make_from_string ("#document-fragment")
		end

end -- class DOM_DOCUMENT_FRAGMENT_IMPL
