indexing
	description: "Simple layout using formatted with 'priority - message'"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	LOG_SIMPLE_LAYOUT

inherit
	
	LOG_LAYOUT
	
feature -- Rendering

	format (event: LOG_EVENT): STRING is
			-- Format contents of 'event' according to this layout's
			-- formatting rules. 
			-- Format is: priority - message
		do
			Result := clone (event.priority.level_str)
			Result.append (" - ")
			Result.append (event.rendered_message)
			Result.append ("%R%N")
		end
				
end -- class LOG_SIMPLE_LAYOUT
