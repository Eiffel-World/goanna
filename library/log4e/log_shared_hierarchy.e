indexing
	description: "Logging appender that writes to Unix syslog via a UDP socket."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	LOG_SHARED_HIERARCHY

inherit
	
	LOG_PRIORITY_CONSTANTS
		export
			{NONE} all
		end
		
feature -- Access

	log_hierarchy: LOG_HIERARCHY is
			-- Shared logging hierarchy.
			-- Will have Debug logging priority by default.
			-- NOTE: No appenders will be created in this hierarchy.
			-- You will need to create and set appenders before log messages
			-- will appear.
		once
			create Result.make (Debug_p)
		end
		
feature -- Logging

	debugging (category: STRING; message: ANY) is
			-- Log a 'message' object with the priority Debug
			-- on the named 'category'.
			-- Will create the category if it does not already
			-- exist.
		require
			category_name_exists: category /= Void
			message_exists: message /= Void
		do
			if log_hierarchy.is_enabled_for (Debug_p) then
				log_hierarchy.category (category).debugging (message)
			end
		end
	
	warn (category: STRING; message: ANY) is
			-- Log a 'message' object with the priority Warn
			-- on the named 'category'.
			-- Will create the category if it does not already
			-- exist.
		require
			category_name_exists: category /= Void
			message_exists: message /= Void
		do
			if log_hierarchy.is_enabled_for (Warn_p) then
				log_hierarchy.category (category).warn (message)
			end
		end
	
	info (category: STRING; message: ANY) is
			-- Log a 'message' object with the priority Info
			-- on the named 'category'.
			-- Will create the category if it does not already
			-- exist.
		require
			category_name_exists: category /= Void
			message_exists: message /= Void
		do
			if log_hierarchy.is_enabled_for (Info_p) then
				log_hierarchy.category (category).info (message)
			end
		end
	
	error (category: STRING; message: ANY) is
			-- Log a 'message' object with the priority Error
			-- on the named 'category'.
			-- Will create the category if it does not already
			-- exist.
		require
			category_name_exists: category /= Void
			message_exists: message /= Void
		do
			if log_hierarchy.is_enabled_for (Error_p) then
				log_hierarchy.category (category).error (message)
			end
		end
	
	fatal (category: STRING; message: ANY) is
			-- Log a 'message' object with the priority Fatal
			-- on the named 'category'.
			-- Will create the category if it does not already
			-- exist.
		require
			category_name_exists: category /= Void
			message_exists: message /= Void
		do
			if log_hierarchy.is_enabled_for (Fatal_p) then
				log_hierarchy.category (category).fatal (message)
			end
		end
	
	log (category: STRING; event_priority: LOG_PRIORITY; message: ANY) is
			-- Log a 'message' object with the given 'event_priority' on
			-- the named 'category'.
			-- Will create the category if it does not already
			-- exist.
		require
			category_name_exists: category /= Void
			event_priority_exists: event_priority /= Void
			message_exists: message /= Void
		do
			if log_hierarchy.is_enabled_for (event_priority) then
				log_hierarchy.category (category).log (event_priority, message)
			end
		end	

end -- class LOG_SHARED_HIERARCHY
