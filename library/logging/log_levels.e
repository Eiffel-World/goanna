indexing
	description: "Objects that define log level constants"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "logging"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	LOG_LEVELS

feature -- Log levels

	Emergency: INTEGER is 0
		-- Urgent condition that requires immediate attention and indicates
		-- that the system is no longer functioning.
			
	Alert: INTEGER is 1
		-- A condition that should be corrected immediately.
		
	Critical: INTEGER is 2
		-- Critical conditions.
		
	Error: INTEGER is 3
		-- Errors that have been correctly handled.
		
	Warning: INTEGER is 4
		-- Warning messages.
		
	Notice: INTEGER is 5
		-- Conditions that are not error conditions, but should possibly be
		-- handled specially.
		
	Info: INTEGER is 6
		-- Informational messages
		
	Debug0: INTEGER is 7
		-- Messages that contain information normally of use only when debugging.
		-- This is the basic level of debugging. Levels Debug1 through Debug9
		-- are defined to allow more debugging messages.
		
	Debug1: INTEGER is 8
	Debug2: INTEGER is 9
	Debug3: INTEGER is 10
	Debug4: INTEGER is 11
	Debug5: INTEGER is 12
	Debug6: INTEGER is 13
	Debug7: INTEGER is 14
	Debug8: INTEGER is 15
	Debug9: INTEGER is 16
	
	Debugtmp: INTEGER is 17
		-- Temporary debugging; should be contained within a debug statement so that
		-- it is not left in shipped code.
		
	log_level_name (level: INTEGER): STRING is
			-- Symbolic name for log 'level'.
		require
			valid_log_level: valid_log_level (level)
		do
			Result := symbolic_log_level_names.item (level + 1)	
		end
	
	valid_log_level (level: INTEGER): BOOLEAN is
			-- Is 'level' a valid log level?
		do
			Result := level >= 0 and level <= Debugtmp
		end
		
feature {NONE} -- Implementation

	symbolic_log_level_names: ARRAY [STRING] is
			-- Symbolic names for log levels.
		once
			Result := << "EMERGENCY", "ALERT", "CRITICAL", "ERROR", "WARNING", "NOTICE", "INFO",
				"DEBUG", "DEBUG1", "DEBUG2", "DEBUG3", "DEBUG4", "DEBUG5", "DEBUG6", 
				"DEBUG7", "DEBUG8", "DEBUG9", "DEBUGTMP" >>
		end
				        
end -- class LOG_LEVELS
