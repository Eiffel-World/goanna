indexing
	description: "Entity reference"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Document Object Model (DOM) Core"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class DOM_ENTITY_REFERENCE

inherit

	DOM_NODE

feature

	name: DOM_STRING is
			-- Name of the entity reference
		deferred
		end

end -- class DOM_ENTITY_REFERENCE
