indexing
	description: "Test features of class CHARACTER_MANIPULATION"
	library:    "Goanna Utility Test Harnesses"
	author:     "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright:  "Copyright (c) 2001, Glenn Maughan and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

deferred class UTILITY_TEST_CHARACTER_MANIPULATION

inherit

	TS_TEST_CASE

	CHARACTER_MANIPULATION
		export
			{NONE} all
		end

feature -- Test

	test_set_char_code is
		local
			char: CHARACTER_REF
		do
			create char
			assert_equal ("zero", 0, set_char_code (char, 0).code)
			assert_equal ("middle", 128, set_char_code (char, 128).code)
			assert_equal ("high", 255, set_char_code (char, 255).code)
		end

	test_char_to_lower is
		do
			assert_equal ("a", 'a', char_to_lower ('A'))
			assert_equal ("m", 'm', char_to_lower ('M'))
			assert_equal ("z", 'z', char_to_lower ('Z'))
			assert_equal ("same", 'a', char_to_lower ('a'))
			assert_equal ("digit", '0', char_to_lower ('0'))
		end
		
end -- class TEST_CHARACTER_MANIPULATION
