indexing
	description: "Test features of class BIT_MANIPULATION"
	library:    "Goanna Utility Test Harnesses"
	author:     "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright:  "Copyright (c) 2001, Glenn Maughan and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

deferred class UTILITY_TEST_BIT_MANIPULATION

inherit

	TS_TEST_CASE

	BIT_MANIPULATION
		export
			{NONE} all
		end

feature -- Test

	test_bit_shift_right is
		do
			assert_equal ("right_one", 64, bit_shift_right (128, 1))
			assert_equal ("right_two", 32, bit_shift_right (128, 2))
			assert_equal ("right_zero", 128, bit_shift_right (128, 0))		
		end

	test_bit_shift_left is
		do
			assert_equal ("left_one", 2, bit_shift_left (1, 1))
			assert_equal ("left_two", 4, bit_shift_left (1, 2))
			assert_equal ("left_zero", 1, bit_shift_left (1, 0))
		end

	test_bit_and is
		do
			assert_equal ("and_1_2", 0, bit_and (1, 2))
			assert_equal ("and_3_1", 1, bit_and (3, 1))
		end		
	
end -- class TEST_BIT_MANIPULATION

