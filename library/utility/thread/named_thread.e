indexing
	description: "Named threads."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "utility thread"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	NAMED_THREAD

inherit
	
	THREAD
	
	GS_APPLICATION_LOGGER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (new_name: STRING) is
			-- Initialize `Current' with specified name.
		require
			new_name_exists: new_name /= Void
		do
			name := new_name
		end

feature -- Access

	name: STRING
			-- Symbolic name for this thread

feature -- Status setting

	set_name (new_name: STRING) is
			-- Set name to 'new_name
		require
			new_name_exists: new_name /= Void
		do
			name := new_name
		end

invariant

	name_exists: name /= Void

end -- class NAMED_THREAD
