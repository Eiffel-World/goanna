indexing
	description: "A standard logger with one channel registered under the facility 'general' that %
		%writes to a specified file."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "logging"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	STANDARD_LOGGER

obsolete "Use log4e instead"

inherit

	LOGGER
		rename
			make as logger_make
		export
			{NONE} logger_make
		end
	
	KL_STANDARD_FILES
		export
			{NONE} all
		end
	
	KL_OUTPUT_STREAM_ROUTINES
		export
			{NONE} all
		end
		
creation
	make

feature -- Initialization

	make (log_file_name: STRING) is
			-- Create a standard logger to write to 'log_file_name'
		require
			log_file_name_exists: log_file_name /= Void
		local
			file: like output_stream_type
			new_channel: LOG_CHANNEL
		do
			logger_make
			file := make_file_open_write (log_file_name)
			create new_channel.make (file)
			add_channel (Standard_facility, new_channel)
		end
		
feature -- Facilities

	Standard_facility: STRING is "general"
	
end -- class STANDARD_LOGGER
