indexing
	description: "Logging appender on which logging events can be appended."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."
	
deferred class LOG_APPENDER
	
feature -- Initialisation
	
	make (new_name: STRING) is
			-- Create new appender with 'name'
			--| Descendants should either call this 
			--| routine or declare it as a creation routine.
		require
			new_name_exists: new_name /= Void
		do
			name := new_name
		end
	
feature -- Status Report
	
	name: STRING
			-- Name of this appender that uniquely 
			-- identifies it.
	
	
feature -- Status Setting
	
	close is
			-- Release any resources for this appender.
		deferred
		end
	
	do_append (event: LOG_EVENT) is
			-- Log event on this appender.
		deferred
		end
	
	set_name (new_name: STRING) is
			-- Set the name of this appender
		require
			name_exists: new_name /= Void
		do
			name := new_name
		end
	
end -- class LOG_APPENDER

