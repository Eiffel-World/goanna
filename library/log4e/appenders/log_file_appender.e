indexing
	description: "Logging appender that writes to standard output."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."
	
class LOG_FILE_APPENDER
	
inherit
	
	LOG_APPENDER
		redefine
			make, layout
		end
	
	KL_OUTPUT_STREAM_ROUTINES
		rename
			close as stream_close
		export
			{NONE} all;
			{ANY} is_open_write
		end
	
creation
	
	make
	
feature -- Initialisation
	
	make (new_name: STRING) is
			-- Create a new file appender on the file 
			-- with 'name'.
		require
			name_exists: new_name /= Void
			name_not_empty: not new_name.is_empty
		do
			Precursor (new_name)
			stream := make_file_open_write (new_name)			
			if not is_open_write (stream) then
				internal_log.error ("Failed to open file stream: " + new_name)
			end
		ensure
			log_file_open: is_open_write (stream)
		end
	
feature -- Status Report

	layout: LOG_LAYOUT is
			-- Use a simple layout for console output
		once
			create {LOG_SIMPLE_LAYOUT} Result
		end

feature -- Status Setting
	
	close is
			-- Release any resources for this appender.
		do
			if not is_closed (stream) then
				stream_close (stream)
			end
		end
	
	do_append (event: LOG_EVENT) is
			-- Log event on this appender.
		do
			stream.put_string (layout.format (event))
			flush (stream)
		end
	
feature -- Stream
	
	stream: like OUTPUT_STREAM_TYPE
			-- Stream to write log events to
	
end -- class LOG_FILE_APPENDER
