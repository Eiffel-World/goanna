indexing
	description: "Logging appender that writes to standard error."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class 
	LOG_STDERR_APPENDER

inherit

	LOG_APPENDER
		redefine
			layout
		end

creation
	
	make

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
			io.output.flush
		end

	do_append (event: LOG_EVENT) is
			-- Log event on this appender.
		do
			io.put_string (layout.format (event))
		end
	
end -- class LOG_STDERR_APPENDER

