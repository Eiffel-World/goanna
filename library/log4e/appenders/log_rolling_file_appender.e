indexing
	description: "Logging appender that writes to standard output."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."
	
class LOG_ROLLING_FILE_APPENDER
	
inherit
	
	LOG_FILE_APPENDER
		rename
			make as file_appender_make
		export
			{NONE} file_appender_make
		redefine
			do_append
		end
	
	FILE_MANIPULATION
		export
			{NONE} all
		end
	
creation
	
	make
	
feature -- Initialisation
	
	make (new_name: STRING; max_size, number_of_backups: INTEGER) is
			-- Create a new file appender on the file 
			-- with 'name'.
		require
			name_exists: new_name /= Void
			name_not_empty: not new_name.is_empty
			positive_max_size: max_size >= 0
			positive_number_of_backups: number_of_backups >= 0
		do
			file_appender_make (new_name)
			stream := make_file_open_write (new_name)
			maximum_file_size := max_size
			max_number_of_backups := number_of_backups
		ensure
			log_file_open: is_open_write (stream)
		end

feature -- Status Setting
		
	do_append (event: LOG_EVENT) is
			-- Log event on this appender.
		do
			if rollover_required then
				rollover
			end
			stream.put_string (layout.format (event))
			flush (stream)
		end
	
feature {NONE} -- Implementation
	
	maximum_file_size: INTEGER
			-- The maximum size the log file can reach 
			-- before being rolled over.
	
	max_number_of_backups: INTEGER
			-- The number of backup files to keep. If 
			-- zero then no backups will be made.
	
	rollover_required: BOOLEAN is
			-- Has the current log file reached the maximum_file_size?
		do
--			Result := size (stream) 
		end
	
	rollover is
			-- Rollover the current file by renaming (if 
			-- backups are required) or deleting. Open a 
			-- new file with the same name.
		local
			i: INTEGER
--			file: FILE
		do
--  			close_stream (stream)
--  			-- do we need to make a backup
--  			if max_number_of_backups > 0 then
--  				-- remove the oldest backup
--  				create file.name (name + "." + number_of_backups)
--  				if file.exists then
--  					file.remove
--  				end
				
--  				-- roll all existing backup files to 
--  				-- next number
--  				from
--  					i := max_number_of_backups - 1
--  				until
--  					i < 1
--  				loop
--  					create file.make (name + "." + i)
--  					if file.exists then
--  						file.rename_to (name + "." + (i + 1))
--  					end
--  					i := i - 1
--  				end
				
--  				-- rename current log file
--  				file ?= stream
--  				file.rename_to (name + "." + i)
				
--  				-- open new log
--  				stream := make_file_open_write (new_name)
--			end
		end
	
end -- class LOG_ROLLING_FILE_APPENDER
