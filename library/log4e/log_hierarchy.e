indexing
	description: "Hierarchy of logging categories."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."
	
class LOG_HIERARCHY
	
inherit
	
	LOG_PRIORITY_CONSTANTS
	
creation
	
	make
	
feature -- Initialisation
	
	make (priority: LOG_PRIORITY) is
			-- Create a category hierarchy with a 
			-- root category with priority 'priority'.
		do
			create root.make (Current, "root")
			root.set_priority (priority)
			disabled := Disable_off
		end
	
feature -- Category Factory
	
	category (cat_name: STRING): LOG_CATEGORY is
			-- Return a category for 'name'. Initialise a new 
			-- category instance if necessary.
		require
			cat_name_exists: cat_name /= Void
		local
			new_cat: LOG_CATEGORY
		do
			if categories.has (cat_name) then
				Result := categories.item (cat_name)
			else
				create new_cat.make (Current, cat_name)
				categories.put (new_cat, cat_name)
				set_category_parents (new_cat)
			end
		ensure
			category_exists: has (cat_name)
		end
				
feature -- Status Report
	
	root: LOG_CATEGORY
			-- Root category of this hierarchy
	
	disabled: INTEGER
			-- Globally disabled priority level. Disable_off if no priorities
			-- are disabled.
	
	has (name: STRING): BOOLEAN is
			-- Does a category with 'name' exist in this hierarchy?
		require
			name_exists: name /= Void
		do
			Result := categories.has (name)
		end
	
	Disable_off: INTEGER is -1
			-- Priority disabled off
	
feature -- Status Setting
	
	disable (priority: LOG_PRIORITY) is
			-- Disable all logging for level 'priority'
		require
			priority_exists: priority /= Void
		do
			disabled := priority.level
		ensure
			priority_disabled: disabled = priority.level
		end
	
	disable_debug is
			-- Disable debug logging
		do
			disabled := Debug_int
		end
	
	disable_info is
			-- Disable info logging
		do
			disabled := Info_int
		end
	
	disable_all is
			-- Disable all logging
		do
			disable := Fatal_int
		end
	
	enable_all is
			-- Enable all logging
		do
			disabled := Disable_off
		end
	
	clear is
			-- Clear all categories from this hierarchy
		do
			categories.clear_all
		end
	
feature {NONE} -- Implementation
	
	categories: DS_HASH_TABLE [LOG_CATEGORY, STRING]
			-- Table of categories indexed by their fully qualified
			-- names.
	
	set_category_parents (new_cat: LOG_CATEGORY) is
			-- Split 'new_cat' name and check that 
			-- appropriate parents exist. Create a new 
			-- parent category if necessary.
		require
			new_cat_exists: new_cat /= Void
		local
			cat_name, sub_name: STRING
			surrogate: LOG_CATEGORY
		do
			cat_name := new_cat.name
			-- if this is a category with no sub parts 
			-- then set its parent to the root
			if cat_name.occurrences ('.') = 0 then
				new_cat.set_parent (root)
			else
				-- if the new category's name is "w.x.y.z", 
				-- recurse through "w.x.y", "w.x" and "w" but 
				-- not "w.x.y.z". If a parent does 
				-- not exist with the sub category 
				-- then create it
				sub_name := cat_name.substring (1, cat_name.last_index_of ('.'))
				if not categories.has (sub_name) then
					surrogate := category (sub_name)
					new_cat.set_parent (surrogate)
				else
					new_cat.set_parent (categories.item (sub_name))
				end
			end
		end
	
end -- class LOG_HIERARCHY
