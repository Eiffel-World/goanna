indexing
	description: "Logging appender that writes to standard output."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."
	
class LOG_CONSOLE_APPENDER
	
inherit
	
	LOG_APPENDER
	
creation
	
	make
	
feature -- Status Setting
	
	close is
			-- Release any resources for this appender.
		do
			-- nothing to do.
		end
	
	do_append (event: LOG_EVENT) is
			-- Log event on this appender.
		do
			io.put_string (event.rendered_message)
		end
	
end -- class LOG_CONSOLE_APPENDER
