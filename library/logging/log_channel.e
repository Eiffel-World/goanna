indexing
	description: "Objects that log messages for a particular facility"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "logging"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	LOG_CHANNEL

inherit

	LOG_LEVELS
	
creation
	make

feature -- Initialization

	make (medium: IO_MEDIUM) is
			-- Create new log channel to write to 'medium'
		require
			medium_exists: medium /= Void
			medium_open_write: medium.is_open_write
		do
			sink := medium 
			set_filter (Emergency, Debug9)
		end
	
	make_filter (medium: IO_MEDIUM; min_level, max_level: INTEGER) is
			-- Create a new log channel to write log message with level between
			-- 'min_level' and 'max_level' to 'medium'.
		require
			medium_exists: medium /= Void
			medium_open_write: medium.is_open_write
			valid_log_filter: valid_log_level (min_level) 
				and valid_log_level (max_level)
				and min_level <= max_level
		do
			sink := medium
			set_filter (min_level, max_level)
		end
					
feature -- Status setting

	set_filter (min_level, max_level: INTEGER) is
			-- Set log level filter to 'min_level' and 'max_level'.
		require
			valid_log_filter: valid_log_level (min_level) 
				and valid_log_level (max_level)
				and min_level <= max_level
		do
			min_filter := min_level
			max_filter := max_level
		end

	write (level: INTEGER; message: STRING) is
			-- Write 'message' at log level 'level' to output medium.
		require
			valid_log_level: valid_log_level (level)
			message_exists: message /= Void
		do
			if level >= min_filter and level <= max_filter then
				sink.put_string (format (level, message))
				sink.put_new_line
			end
		end
		
feature {NONE} -- Implementation
	
	sink: IO_MEDIUM
			-- The sink to write messages to
		
	min_filter, max_filter: INTEGER
			-- Log level filter range.
	
	format (level: INTEGER; message: STRING): STRING is
			-- Format the message for logging
		local
			date: DATE_AND_TIME
		do
			create Result.make (100)
			create date.make_to_now
			Result.append (date.out)
			Result.append (" (" + log_level_name (level) + "): ")
			Result.append (message)
		end
					
end -- class LOG_CHANNEL
