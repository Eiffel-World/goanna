indexing

	description: "Test features of class HTTP_UTILITY_FUNCTIONS"
	library:    "Goanna Utility Test Harnesses"
	author:     "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright:  "Copyright (c) 2001, Glenn Maughan and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

deferred class UTILITY_TEST_HTTP_UTILITY_FUNCTIONS

inherit

	TS_TEST_CASE

	HTTP_UTILITY_FUNCTIONS
		export
			{NONE} all
		end

feature -- Test

	test_digit_from_hex is
		do
			-- note % must be preceeded by another %
			assert_equal ("empty", "", decode_url(""))
			assert_equal ("decode_plus", "this is a test", decode_url ("this+is+a+test"))
			assert_equal ("decode_percent_chars", "this is a test", decode_url ("this%%20is%%20a%%20test"))
		end

	test_encode is
			-- Test HTTP encoding
		do
			-- note % must be preceeded by another %
			assert_equal ("empty", "", encode (""))
			assert_equal ("less_than", "&lt;", encode ("<"))
			assert_equal ("greater_than", "&gt;", encode (">"))
			assert_equal ("ampersand", "&amp;", encode ("&"))
			assert_equal ("quote", "&#39;", encode ("'"))
			assert_equal ("doublequote", "&quot;", encode ("%""))
			assert_equal ("backslash", "&#92;", encode ("\"))
			assert_equal ("normal", "abcdefghijklmnopqrstuvwxyz", encode ("abcdefghijklmnopqrstuvwxyz"))
			assert_equal ("combined", "a&amp;b&lt;c&gt;d&#39;e&quot;f&#92;", encode ("a&b<c>d'e%"f\"))
		end
		
	
end -- class UTILITY_TEST_HTTP_UTILITY_FUNCTIONS

