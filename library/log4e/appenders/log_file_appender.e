indexing
	description: "Logging appender that writes to a file."
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
		rename
			make as appender_make
		export
			{NONE} appender_make
		end
	
creation
	
	make
	
feature -- Initialisation
	
	make (new_name: STRING; appending: BOOLEAN) is
			-- Create a new file appender on the file 
			-- with 'name'.
		do
			appender_make (new_name)
			append_mode := appending
			open_log
			is_open := True
		ensure
			log_stream_open: stream.is_open_write
		end
	
feature -- Status Report

	append_mode: BOOLEAN
			-- Append to file or create new file?

feature -- Basic Operations
		
	close is
			-- Release any resources for this appender.
		do
			if not stream.is_closed then
				stream.put_string (layout.footer)
				stream.close
				is_open := False
			end
		end
	
	do_append (event: LOG_EVENT) is
			-- Log event on this appender.
		do
			stream.put_string (layout.format (event))
			stream.flush
		end
	
feature -- Stream
	
	stream: KL_TEXT_OUTPUT_FILE
			-- Stream to write log events to

feature {NONE} -- Implementation

	open_log is
			-- Open the log file taking into account 'append_mode'
		do
			if append_mode then
				create stream.make (name)
				stream.open_append
			else
				create stream.make (name)		
				stream.open_write
			end	
			if not stream.is_open_write then
				internal_log.error ("Failed to open file stream: " + name)
			end
			stream.put_string (layout.header)
		end
		
end -- class LOG_FILE_APPENDER
