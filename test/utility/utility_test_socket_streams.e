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

	test_echo is
			-- Test socket input streams by writing to and reading from the 'echo'
			-- service.
		local
			socket: TCP_SERVER_SOCKET
			input: SOCKET_INPUT_STREAM
			output: SOCKET_OUTPUT_STREAM
			buffer: STRING
		do	
			create socket.make_connecting_to_service ("localhost", "echo")
			create input.make (socket)
			create output.make (socket)
			from
				buffer := ""
			until
				buffer.is_equal ("end")
			loop
				input.read_string (10)
				buffer := clone (input.last_string)
				io.put_string ("Read: " + buffer + "%N")
			end
		end

	
end -- class UTILITY_TEST_SOCKET_STREAMS
