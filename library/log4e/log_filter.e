indexing
	description: "Filter for log events to determine if they should be logged or not."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	LOG_FILTER

inherit
	
	LOG_FILTER_CONSTANTS

feature -- Status report

	decide (event: LOG_EVENT): INTEGER is
			-- Should 'event' be logged. Return one of Filter_accept,
			-- Filter_reject, or Filter_neutral.
		require
			event_exists: event /= Void
		deferred
		ensure
			valid_result: valid_filter_decision (Result)
		end
		
end -- class LOG_FILTER
