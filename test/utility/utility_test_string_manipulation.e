indexing

	description: "Test features of class STRING_MANIPULATION"
	library:    "Goanna Utility Test Harnesses"
	author:     "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright:  "Copyright (c) 2001, Glenn Maughan and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

deferred class UTILITY_TEST_STRING_MANIPULATION

inherit

	TS_TEST_CASE

	STRING_MANIPULATION
		export
			{NONE} all
		end
		
feature -- Test

	test_last_index_of is
		local
			str: STRING
		do
			str := "test.one.two"
			assert_equal ("two_positions", last_index_of (str, '.', str.count), 9)
			str := "test.one"
			assert_equal ("one_position", last_index_of (str, '.', str.count), 5)
			str := "test"
			assert_equal ("no_positions", last_index_of (str, '.', str.count), 0)
			str := "test."
			assert_equal ("at_end", last_index_of (str, '.', str.count), 5)
			str := "test.one.two"
			assert_equal ("start_before_end", last_index_of (str, '.', 8), 5)
			str := "."
			assert_equal ("one_char", last_index_of (str, '.', str.count), 1)
		end	

end -- class UTILITY_TEST_STRING_MANIPULATION
