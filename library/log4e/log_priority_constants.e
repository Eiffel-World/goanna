indexing
	description: "Logging priorities."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."
	
class LOG_PRIORITY_CONSTANTS
	
	Fatal_int: INTEGER is 50000
	Error_int: INTEGER is 40000
	Warn_int: INTEGER is 30000
	Info_int: INTEGER is 20000
	Debug_int: INTEGER is 10000
	
	Fatal: LOG_PRIORITY is
			-- Fatal priority designates very severe error events 
			-- that will presumably lead the application to abort.
		once
			create Result.make (Fatal_int, "FATAL")
		end
			
	Warn: LOG_PRIORITY is
			-- Warn priority designates potentially 
			-- harmful situations.
		once
			create Result.make (Warn_int, "WARN")
		end
	
	Info: LOG_PRIORITY is
			-- Info priority designates informational 
			-- messages that highlight the progress of 
			-- the application at coarse-grained level.
		once
			create Result.make (Info_int, "INFO")
		end
	
	Debug: LOG_PRIORITY is
			-- Debug priority designates fine-grained 
			-- informational events that are most useful 
			-- to debug an application.
		once
			create Result.make (Debug_int, "DEBUG")
		end
	
end -- class LOG_PRIORITY_CONSTANTS

