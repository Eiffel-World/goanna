indexing
	description: "Registry of objects keyed by name"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Utility"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	GOA_REGISTRY [G]

create

	make

feature -- Initialization

	make is
			-- Initialise empty registry
		do
			create elements.make_default
		end
		
feature -- Access
	
	get (name: STRING): G is
			-- Retrieve element registered under 'name'
		require
			name_exists: name /= Void
			element_registered: has (name)
		do
			Result := elements.item (name)
		end
	
	has (name: STRING): BOOLEAN is
			-- Is a element registered under 'name'?
		require
			name_exists: name /= Void
		do
			Result := elements.has (name)
		end

	elements: DS_HASH_TABLE [G, STRING]
			-- Collection of elements indexed by name.
			
feature -- Status setting

	register (element: G; name: STRING) is
			-- Register 'element' with 'name'
		require
			name_exists: name /= Void
			element_exists: element /= Void
		do
			elements.force (element, name)
		ensure
			element_registered: has (name)
		end

invariant
	
	elements_exists: elements /= Void

end -- class GOA_REGISTRY
