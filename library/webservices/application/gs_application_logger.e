indexing
	description: "Thread safe shared logger"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class

	GS_APPLICATION_LOGGER
	
inherit
	
	LOG_PRIORITY_CONSTANTS
		export
			{NONE} all
			{ANY} is_equal, standard_is_equal
		end

	KL_SHARED_ARGUMENTS
		export
			{NONE} all
		end

feature -- Access

	Log_hierarchy: LOG_HIERARCHY is
			-- Shared log hierarchy with predefined
			-- categories for server logging.
			-- Direct access to this object is not thread safe.
			-- This object has process (multi-thread) scope.
		indexing
			once_status: global
		local
			appender: LOG_APPENDER
			layout: LOG_LAYOUT
		once
			create Result.make (Debug_p)
			create {LOG_FILE_APPENDER} appender.make (Application_log, True)
			create {LOG_PATTERN_LAYOUT} layout.make ("&d [&-6p] &c - &m%N")
			appender.set_layout (layout)
			Result.root.add_appender (appender)
			create {LOG_STDOUT_APPENDER} appender.make ("stdout")
			appender.set_layout (layout)
			Result.root.add_appender (appender)
		end
	
	Logger: LOG_CATEGORY is
			-- Internal logging category.
			-- Direct access to this object is not thread safe.
		once
			Result := Log_hierarchy.category (Server_category)
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
				log_mutex.lock
				log_hierarchy.category (category).debugging (message)
				log_mutex.unlock
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
				log_mutex.lock
				log_hierarchy.category (category).warn (message)
				log_mutex.unlock
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
				log_mutex.lock
				log_hierarchy.category (category).info (message)
				log_mutex.unlock
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
				log_mutex.lock
				log_hierarchy.category (category).error (message)
				log_mutex.unlock
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
				log_mutex.lock
				log_hierarchy.category (category).fatal (message)
				log_mutex.unlock
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
				log_mutex.lock
				log_hierarchy.category (category).log (event_priority, message)
				log_mutex.unlock
			end
		end	

feature {NONE} -- Implementation

	log_mutex: MUTEX is
			-- Mutual exclusion variable for logging thread safety.
			-- This object has process (multi-thread) scope.
		indexing
			once_status: global
		once
			create Result
		end
		
	Server_category: STRING is "server"

	Application_log: STRING is
			-- Construct application log from system name and ".log" extension.
			-- Any leading path and extension will be removed. eg. The log file
			-- for 'd:\dev\httpd.exe' will be 'httpd.log' not 'd:\dev\httpd.exe.log'
		local
			app_name: STRING
		once
			app_name := clone (Arguments.argument (0))
			create Result.make (app_name.count + 4)
			Result.append (app_name)
			Result.append (".log")
		end
	
invariant
	
	logger_mutex_initialized: log_mutex /= Void
	
end -- class GS_APPLICATION_LOGGER
