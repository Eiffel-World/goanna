indexing

	description: "Test features of class SOCKET_INPUT_STREAM and SOCKET_OUTPUT_STREAM"
	library:    "Goanna Utility Test Harnesses"
	author:     "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright:  "Copyright (c) 2001, Glenn Maughan and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

deferred class UTILITY_TEST_SOCKET_STREAMS

inherit

	TS_TEST_CASE

feature -- Test

	test_line is
			-- Test socket input streams by writing to and reading from the 'echo'
			-- service.
		local
			socket: TCP_SOCKET
			input: SOCKET_INPUT_STREAM
			output: SOCKET_OUTPUT_STREAM
		do	
			create socket.make_connecting_to_service ("localhost", "echo")
			create input.make (socket)
			create output.make (socket)
			-- write "testing" to echo service
			output.put_line ("testing")
			assert ("socket_write_ok", output.last_write_ok)
			
			-- read "testing" from echo service
			input.read_line
			assert ("socket_read_ok", input.last_read_ok)
			assert_equal ("line-testing", "testing", input.last_string)
			input.read_new_line
			
			-- test closed
			socket.close
			assert ("closed_for_reading", not input.is_open_read)
			assert ("closed_for_writing", not output.is_open_write)
		end

	test_buffer is
			-- Test buffer read sizes than read buffer size
		local
			socket: TCP_SOCKET
			input: SOCKET_INPUT_STREAM
			output: SOCKET_OUTPUT_STREAM
			message: STRING
		do	
			create socket.make_connecting_to_service ("localhost", "echo")
			create input.make (socket)
			input.set_buffer_size (20)
			create output.make (socket)
			
			-- test less than buffer size
			message := "1234567890" -- 10
			output.put_line (message)
			assert ("socket_write_ok", output.last_write_ok)
			input.read_line
			assert ("socket_read_ok", input.last_read_ok)
			assert_equal ("buffer-testing", "1234567890", input.last_string)

			message := "abcdefghij" -- 10
			output.put_line (message)
			assert ("socket_write_ok", output.last_write_ok)
			input.read_line
			assert ("socket_read_ok", input.last_read_ok)
			assert_equal ("buffer-testing", "abcdefghij", input.last_string)
			
			-- test equal to buffer
		end
		
end -- class UTILITY_TEST_SOCKET_STREAMS
