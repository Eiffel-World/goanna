indexing
	description: "Logging appender that writes to standard a file that is rolled when it reaches a certain size."
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
		
creation
	
	make
	
feature -- Initialisation
	
	make (new_name: STRING; max_size, number_of_backups: INTEGER; appending: BOOLEAN) is
			-- Create a new file appender on the file 
			-- with 'new_name'. Roll the log over to a backup file when it reaches 'max_size'
			-- bytes in size. Keep a maximum of 'number_of_backups' backup files.
			-- Append to an existing log file if 'appending'.
		require
			name_exists: new_name /= Void
			name_not_empty: not new_name.is_empty
			sensible_max_size: max_size >= 1
			positive_number_of_backups: number_of_backups >= 0
		do
			maximum_file_size := max_size
			max_number_of_backups := number_of_backups
			file_appender_make (new_name, appending)
		ensure
			log_file_open: stream.is_open_write
		end
		
feature -- Basic Operations
		
	do_append (event: LOG_EVENT) is
			-- Log event on this appender.
		do
			if rollover_required then
				rollover
			end
			stream.put_string (layout.format (event))
			stream.flush
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
		
			Result := stream.count >= maximum_file_size 
		end
	
	rollover is
			-- Rollover the current file by renaming (if 
			-- backups are required) or deleting. Open a 
			-- new file with the same name.
		local
			i: INTEGER
			file: PLAIN_TEXT_FILE
		do
  			-- do we need to make a backup
  			if max_number_of_backups > 0 then		
  				-- roll all existing backup files to 
  				-- next number
  				from
  					i := max_number_of_backups
  				until
  					i < 1
  				loop
  					create file.make (name + "." + i.out)
  					if file.exists then
  						file.change_name (name + "." + (i + 1).out)
  					end
  					i := i - 1
  				end
				
				-- remove the oldest backup if not keeping infinite number of backups
				if max_number_of_backups > 0 then
					create file.make (name + "." + (max_number_of_backups + 1).out)
	  				if file.exists then
	  					file.delete
	  				end		
				end
  				
  				-- rename current log file
  				stream.close
  				stream.change_name (name + ".1" )
				
  				-- re-open log
  				open_log
			end
		end

end -- class LOG_ROLLING_FILE_APPENDER
