indexing

	description: "Test features of class BASE64_ENCODER"
	library:    "Gobo Eiffel Structure Library"
	author:     "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright:  "Copyright (c) 2001, Glenn Maughan and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

deferred class TEST_BASE64_ENCODER

inherit

	TS_TEST_CASE

feature -- Test

	test_encoding is
			-- Test standard encoding features of BASE64_ENCODER
		local
			encoder: BASE64_ENCODER
		do
			!! encoder
			assert_equal ("empty", "", encoder.encode(""))
			assert_equal ("Hello there!", encoder.encode ("Hello there!"), "SGVsbG8gdGhlcmUh")
			assert_equal ("Hello there!x", encoder.encode ("Hello there!x"), "SGVsbG8gdGhlcmUheA==")
			assert_equal ("Hello there!xx", encoder.encode ("Hello there!xx"), "SGVsbG8gdGhlcmUheHg=")
		end

	test_session_id_encoding is
			-- Test session ID encoding features of BASE^$_ENCODER
		local
			encoder: BASE64_ENCODER
		do
			!! encoder
			assert_equal ("Hello there!", encoder.encode_for_session_key ("Hello there!"), "SGVsbG8gdGhlcmUh")
			assert_equal ("Hello there!x", encoder.encode_for_session_key ("Hello there!x"), "SGVsbG8gdGhlcmUheA..")
			assert_equal ("Hello there!xx", encoder.encode_for_session_key ("Hello there!xx"), "SGVsbG8gdGhlcmUheHg.")
		end

end -- class TEST_BASE64_ENCODER
