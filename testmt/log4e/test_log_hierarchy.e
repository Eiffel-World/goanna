indexing

	description: "Test features of class LOG_HIERARCHY"
	library:    "Goanna log4e Test Harnesses"
	author:     "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright:  "Copyright (c) 2001, Glenn Maughan and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

deferred class TEST_LOG_HIERARCHY

inherit

	TS_TEST_CASE

	LOG_PRIORITY_CONSTANTS
		export
			{NONE} all
		end

	LOG_FILTER_CONSTANTS
		export
			{NONE} all
		end
		
feature -- Test

		
	test_externally_rolled_appender is
		local
			h: LOG_HIERARCHY
			cat: LOG_CATEGORY
			appender: LOG_APPENDER
			i: INTEGER
		do
			create h.make (Debug_p)
			cat := h.category ("test")			
			create {LOG_EXTERNALLY_ROLLED_FILE_APPENDER} appender.make ("roller.log", 9000, 5, True)
			cat.add_appender (appender)	
			from
				i := 1
			until
				i > 100
			loop
				cat.fatal ("This is fatal")				
				sleep (100)
				i := i + 1
			end
--			cat.fatal ("This is fatal")
--			sleep (5000)
--			cat.error ("This is an error")
--			sleep (5000)
--			cat.warn ("This is a warning")
--			sleep (5000)
--			cat.info ("This is information")
--			sleep (5000)
--			cat.debugging ("This is a test")
		end
		
feature {NONE} -- Implementation
	
	sleep (period: INTEGER) is
			-- Sleep for 'period' milliseconds
		external
			"[
				C macro signature (DWORD) use <windows.h>
			 ]"
		alias
			"Sleep"
		end	
		
end -- class TEST_LOG_HIERARCHY
