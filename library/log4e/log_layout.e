indexing
	description: "Abstract notion of an event layout formatter."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class

	LOG_LAYOUT

feature -- Rendering

	format (event: LOG_EVENT): STRING is
			-- Format contents of 'event' according to this layout's
			-- formatting rules
		require
			event_exists: event /= Void
		deferred
		ensure
			formatted_exists: Result /= Void
		end
		
end -- class LOG_LAYOUT
