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

feature -- Test

	test_log_hierarchy is
		local
			h: LOG_HIERARCHY
			cat: LOG_CATEGORY
			appender: LOG_CONSOLE_APPENDER
		do
			create h.make (Debug_p)
			cat := h.category ("test")
			create appender.make ("console")
			cat.add_appender (appender)
			cat.debugging ("This is a test")
			cat.error ("This is an error")
			cat.warn ("This is a warning")
			cat.fatal ("This is fatal")
			cat.info ("This is information")
		end

end -- class TEST_LOG_HIERARCHY
