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
		
inherit
	
	LOG_FILTER_CONSTANTS
--		export
--			{NONE} all
--		end
	
	LOG_SHARED_LOG_LOG
	
feature -- Initialisation
	
	make (new_name: STRING) is
			-- Create new appender with 'name'
			--| Descendants should either call this 
			--| routine or declare it as a creation routine.
		require
			new_name_exists: new_name /= Void
		do
			name := new_name
			create filters.make
		end
	
feature -- Status Report
	
	name: STRING
			-- Name of this appender that uniquely 
			-- identifies it.

	layout: LOG_LAYOUT is
			-- Layout used to format events for this appender. May be Void
			-- if no layout is used.
		deferred
		end

feature -- Status Setting
	
	close is
			-- Release any resources for this appender.
		deferred
		end
	
	append (event: LOG_EVENT) is
			-- Log event on this appender.
		require
			event_exists: event /= Void
		local
			done, accept: BOOLEAN
			c: DS_LINKED_LIST_CURSOR [LOG_FILTER]
		do
			-- filter event through filters to determine
			-- if it should be logged
			if filters.is_empty then
				do_append (event)
			else
				from
					c := filters.new_cursor
					c.start
				until
					c.off or done
				loop
					inspect c.item.decide (event)
					when Filter_accept then
						done := True
						accept := True
					when Filter_reject then
						done := True
					else -- Filter_neutral
						c.forth	
						if c.off then
							done := True
							accept := True
						end
					end	
				end
				if accept then
					do_append (event)
				end
			end
		end
	
	set_name (new_name: STRING) is
			-- Set the name of this appender
		require
			name_exists: new_name /= Void
		do
			name := new_name
		end
	
	add_filter (filter: LOG_FILTER) is
			-- Add 'filter' to the list of filters to 
			-- apply when determining if a log event will
			-- be processed by this appender.
		require
			filter_exists: filter /= Void
			filter_not_added: not has_filter (filter)
		do
			filters.force_last (filter)
		ensure
			filter_added: has_filter (filter)
		end
		
	has_filter (filter: LOG_FILTER): BOOLEAN is
			-- Is 'filter' in the list of filters for this
			-- appender?
		require
			filter_exists: filter /= Void
		do
			Result := filters.has (filter)
		end
		
	remove_filter (filter: LOG_FILTER) is
			-- Remove 'filter' from the list of filters for this
			-- appender.
		require
			filter_exists: filter /= Void
			filter_added: has_filter (filter)
		do
			filters.delete (filter)
		ensure
			filter_removed: not has_filter (filter)
		end
		
feature {NONE} -- Implementation

	do_append (event: LOG_EVENT) is
			-- Append 'event' to this appender
		require
			event_exists: event /= Void
		deferred
		end
		
	filters: DS_LINKED_LIST [LOG_FILTER]
			-- Filters that determine if a log event is processed for this
			-- appender or not.
			
end -- class LOG_APPENDER

