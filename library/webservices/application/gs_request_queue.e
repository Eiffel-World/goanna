indexing
	description: "Thread safe queue of pending requests"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	
	GS_REQUEST_QUEUE

inherit
	
	ANY
		redefine
			default_create
		end
		
feature -- Initialisation

	default_create is
			-- Initialize
		do
			create {DS_LINKED_QUEUE[STRING]} queue.make_default
		end
		
feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	queue: DS_QUEUE [STRING]
	
invariant
	
	queue_exists: queue /= Void

end -- class GS_REQUEST_QUEUE
