indexing
	description: "Objects that manage servlets."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SERVLET_MANAGER [K -> SERVLET]

create
	make

feature -- Initialization

	make is
			-- Initialise with no servlets.
		do
			create servlets.make (5)
		end
	
feature -- Access

	get_servlet (name: STRING): K is
			-- Retrieve the servlet registered under 'name'
		require
			name_exists: name /= Void
			servlet_registered: has_registered_servlet (name)
		do
			Result := servlets.item (name)
		ensure
			result_exists: Result /= Void
		end
	
feature -- Status report

	has_registered_servlet (name: STRING): BOOLEAN is
			-- Is a servlet registered under 'name'?
		require
			name_exists: name /= Void
		do
			Result := servlets.has (name)
		end
	
feature -- Status setting

	register_servlet (servlet: K; name: STRING) is
			-- Register 'servlet' for 'name'
		require
			servlet_exists: servlet /= Void
			name_exists: name /= Void
		do
			servlets.force (servlet, name)
		end

feature {NONE} -- Implementation

	servlets: DS_HASH_TABLE [K, STRING]
			-- Managed servlets.

end -- class SERVLET_MANAGER
