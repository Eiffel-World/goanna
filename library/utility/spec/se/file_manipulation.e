indexing

	description: "File manipulation utilities"
	library:    "Goanna utility"
	author:     "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright:  "Copyright (c) 2001, Glenn Maughan and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"
	
class FILE_MANIPULATION
	
inherit
	
	FILE_TOOLS
		rename
			rename_to as file_rename_to
			delete as file_delete
		export
			{NONE} all
		end
	
feature 
	
	rename_to (old_path, new_path: STRING) is
			-- Rename 'old_path' to 'new_path'.
		require
			old_path_exists: old_path /= Void
			new_path_exists: new_path /= Void
		do
			file_rename_to (old_path, new_path)
		end
			
	delete (path: STRING) is
			-- Delete file at 'path'
		require
			path_exists: path /= Void
		do
			file_delete (path)
		end
		
end -- class FILE_MANIPULATION
