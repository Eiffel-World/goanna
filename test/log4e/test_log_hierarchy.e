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

	test_log_hierarchy is
		local
			h: LOG_HIERARCHY
			cat: LOG_CATEGORY
			appender: LOG_APPENDER
			filter: LOG_FILTER
		do
			create h.make (Debug_p)
			cat := h.category ("test")
			
			create {LOG_STDOUT_APPENDER} appender.make ("stdout")
			cat.add_appender (appender)
			create {LOG_PRIORITY_RANGE_FILTER} filter.make (Info_p, Error_p, true)
			appender.add_filter (filter)
			
			create {LOG_STDERR_APPENDER} appender.make ("stderr")
			cat.add_appender (appender)
			create {LOG_PRIORITY_MATCH_FILTER} filter.make (Error_p, true)
			appender.add_filter (filter)
			
--			cat.debugging ("This is a test")
--			cat.error ("This is an error")
--			cat.warn ("This is a warning")
--			cat.fatal ("This is fatal")
--			cat.info ("This is information")
		end

	test_priority_match_filter is
		local
			h: LOG_HIERARCHY
			cat: LOG_CATEGORY
			filter: LOG_FILTER
			event: LOG_EVENT
		do
			-- create dummy hierarchy and category
			create h.make (Debug_p)
			cat := h.category ("test")

			create {LOG_PRIORITY_MATCH_FILTER} filter.make (Info_p, true)

			create event.make (cat, Info_p, "test event")
			assert_equal ("info_match", filter.decide (event), Filter_accept)
			
			create event.make (cat, Debug_p, "test event")
			assert_equal ("info_not_match_debug", filter.decide (event), Filter_reject)
			create event.make (cat, Warn_p, "test event")
			assert_equal ("info_not_match_warn", filter.decide (event), Filter_reject)
			create event.make (cat, Error_p, "test event")
			assert_equal ("info_not_match_error", filter.decide (event), Filter_reject)
			create event.make (cat, Fatal_p, "test event")
			assert_equal ("info_not_match_fatal", filter.decide (event), Filter_reject)	

			create {LOG_PRIORITY_MATCH_FILTER} filter.make (Info_p, false)
			
			create event.make (cat, Info_p, "test event")
			assert_equal ("info_match", filter.decide (event), Filter_reject)
			
			create event.make (cat, Debug_p, "test event")
			assert_equal ("info_not_match_debug", filter.decide (event), Filter_accept)
			create event.make (cat, Warn_p, "test event")
			assert_equal ("info_not_match_warn", filter.decide (event), Filter_accept)
			create event.make (cat, Error_p, "test event")
			assert_equal ("info_not_match_error", filter.decide (event), Filter_accept)
			create event.make (cat, Fatal_p, "test event")
			assert_equal ("info_not_match_fatal", filter.decide (event), Filter_accept)	
		end
		
	test_priority_range_filter is
		local
			h: LOG_HIERARCHY
			cat: LOG_CATEGORY
			filter: LOG_FILTER
			event: LOG_EVENT
		do
			-- create dummy hierarchy and category
			create h.make (Debug_p)
			cat := h.category ("test")

			-- Range includes Info, Warn and Error
			create {LOG_PRIORITY_RANGE_FILTER} filter.make (Info_p, Error_p, true)

			create event.make (cat, Info_p, "test event")
			assert_equal ("info_match", filter.decide (event), Filter_accept)
			create event.make (cat, Warn_p, "test event")
			assert_equal ("warn_match", filter.decide (event), Filter_accept)
			create event.make (cat, Error_p, "test event")
			assert_equal ("error_match", filter.decide (event), Filter_accept)

			create event.make (cat, Fatal_p, "test event")
			assert_equal ("fatal_not_match", filter.decide (event), Filter_reject)
			create event.make (cat, Debug_p, "test event")
			assert_equal ("debug_not_match", filter.decide (event), Filter_reject)
			
			-- Range includes Info, Warn and Error. Neutral on range match.
			create {LOG_PRIORITY_RANGE_FILTER} filter.make (Info_p, Error_p, false)
			
			create event.make (cat, Info_p, "test event")
			assert_equal ("info_match", filter.decide (event), Filter_neutral)
			create event.make (cat, Warn_p, "test event")
			assert_equal ("warn_match", filter.decide (event), Filter_neutral)
			create event.make (cat, Error_p, "test event")
			assert_equal ("error_match", filter.decide (event), Filter_neutral)

			create event.make (cat, Fatal_p, "test event")
			assert_equal ("fatal_not_match", filter.decide (event), Filter_reject)
			create event.make (cat, Debug_p, "test event")
			assert_equal ("debug_not_match", filter.decide (event), Filter_reject)
			
			-- Range includes Info, Warn and Error and Fatal. Neutral on range match.
			create {LOG_PRIORITY_RANGE_FILTER} filter.make (Info_p, Void, true)
			
			create event.make (cat, Info_p, "test event")
			assert_equal ("info_match", filter.decide (event), Filter_accept)
			create event.make (cat, Warn_p, "test event")
			assert_equal ("warn_match", filter.decide (event), Filter_accept)
			create event.make (cat, Error_p, "test event")
			assert_equal ("error_match", filter.decide (event), Filter_accept)
			create event.make (cat, Fatal_p, "test event")
			assert_equal ("fatal_not_match", filter.decide (event), Filter_accept)

			create event.make (cat, Debug_p, "test event")
			assert_equal ("debug_not_match", filter.decide (event), Filter_reject)
		
			-- Range includes Debug, Info, Warn and Error. Neutral on range match.
			create {LOG_PRIORITY_RANGE_FILTER} filter.make (Void, Error_p, true)
			
			create event.make (cat, Info_p, "test event")
			assert_equal ("info_match", filter.decide (event), Filter_accept)
			create event.make (cat, Warn_p, "test event")
			assert_equal ("warn_match", filter.decide (event), Filter_accept)
			create event.make (cat, Error_p, "test event")
			assert_equal ("error_match", filter.decide (event), Filter_accept)
			create event.make (cat, Debug_p, "test event")
			assert_equal ("debug_not_match", filter.decide (event), Filter_accept)

			create event.make (cat, Fatal_p, "test event")
			assert_equal ("fatal_not_match", filter.decide (event), Filter_reject)		
		end
		
end -- class TEST_LOG_HIERARCHY
