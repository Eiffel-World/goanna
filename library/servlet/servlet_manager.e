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

creation
	make

feature -- Initialization

	make is
			-- Initialise with no servlets.
		do
			create servlets.make (5)
		end
	
feature -- Access

	servlet (name: STRING): K is
			-- Retrieve the servlet registered under 'name'
		require
			name_exists: name /= Void
			servlet_registered: has_registered_servlet (name)
		do
			Result := servlets.item (name)
		ensure
			result_exists: Result /= Void
		end
	
	default_servlet: K is
			-- Retrieve the default servlet
		require
			default_servlet_registered: has_default_servlet
		do
			Result := internal_default_servlet
		end
		
feature -- Status report

	has_registered_servlet (name: STRING): BOOLEAN is
			-- Is a servlet registered under 'name'?
		require
			name_exists: name /= Void
		do
			Result := servlets.has (name)
		end
	
	has_default_servlet: BOOLEAN is
			-- Is a default servlet registered?
		do
			Result := internal_default_servlet /= Void
		end
		
feature -- Status setting

	register_servlet (new_servlet: K; name: STRING) is
			-- Register 'servlet' for 'name'
		require
			servlet_exists: new_servlet /= Void
			name_exists: name /= Void
		do
			servlets.force (new_servlet, name)
		end

	register_default_servlet (def_servlet: K) is
			-- REgister 'servlet' as the default servlet
		require
			servlet_exists: def_servlet /= Void
		do
			internal_default_servlet := def_servlet
		end
		
feature {NONE} -- Implementation

	servlets: DS_HASH_TABLE [K, STRING]
			-- Managed servlets.

	internal_default_servlet: K
			-- Default servlet
			
end -- class SERVLET_MANAGER
