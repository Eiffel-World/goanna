indexing
	description: "Layout using 'seconds - priority - message'"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	LOG_TIME_LAYOUT

inherit
	
	LOG_SIMPLE_LAYOUT
		redefine
			format
		end
	
creation
	
	make
	
feature -- Initialisation

	make is
			-- Create new time layout and record start
			-- time
		do
			start_time := system_clock.date_time_now
		end
		
feature -- Rendering

	format (event: LOG_EVENT): STRING is
			-- Format contents of 'event' according to this layout's
			-- formatting rules. 
			-- Format is: seconds_since_start - priority - message
		do			
			Result := event.time_stamp.duration (start_time).second_count.out
			Result.append (" - ")
			Result.append (event.priority.level_str)
			Result.append (" - ")
			Result.append (event.rendered_message)
			Result.append ("%N")
		end

feature {NONE} -- Implementation

	start_time: DT_DATE_TIME
			-- Time this log layout was initialised
		
end -- class LOG_TIME_LAYOUT
