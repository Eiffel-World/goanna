indexing
	description: "Logging event."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."
	
class LOG_EVENT
	
inherit
	
	DT_SHARED_SYSTEM_CLOCK
--		export
--			{NONE} all
--		end
	
creation
	
	make
	
feature -- Initialisation
	
	make (cat: LOG_CATEGORY; event_priority: LOG_PRIORITY; event_message: ANY) is
			-- Create a new logging event for the 
			-- category 'cat', priority 'event_priority' 
			-- and message object 'event_message'. The 
			-- message will be converted to a string 
			-- using '.out'.
		require
			cat_exists: cat /= Void
			event_priority_exists: event_priority /= Void
			event_message_exists: event_message /= Void
		do
			category := cat
			priority := event_priority
			message := event_message
			rendered_message := render (message)
			time_stamp := System_clock.date_time_now
		end
	
feature -- Status Report
	
	category: LOG_CATEGORY
			-- The category in which this logging event occurred.
	
	priority: LOG_PRIORITY
			-- The logging priority level for this event.
	
	message: ANY
			-- Unrenderred message object
	
	rendered_message: STRING
			-- String representation of 'message' after 
			-- applying layout.
	
	time_stamp: DT_DATE_TIME
			-- Time stamp indicating when event was created.
	
feature {NONE} -- Implementation
	
	render (obj: ANY): STRING is
			-- Render 'obj' by calling '.out' and applying layout 
			-- to the resulting string.
		require
			obj_exists: obj /= Void
		do
			Result := obj.out
		end
	
end -- class LOG_EVENT

