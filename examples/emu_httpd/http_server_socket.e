indexing

	author:      "Marcio Marchini <mqm@magma.ca>"
	copyright:   "Copyright (c) 2000, Marcio Marchini"
	thanks:		 "Bedarra (www.bedarra.com) for support of open source; Richie Bielak for Emu"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:        "$Date$"
	revision:    "$Revision$"


class HTTP_SERVER_SOCKET

inherit
	TCP_SERVER_SOCKET
		redefine
			new_connection_socket,
			multiplex_read_callback
		end

	SOCKET_MULTIPLEXER_SINGLETON


creation
    make

feature

	new_connection_socket : HTTP_SERVING_SOCKET is
		-- this is a factory method. Override it to return an instance of a different class
		-- that will represent the connection to the client
		do
			!!Result.make_uninitialized
		end



	multiplex_read_callback is
		-- we got a new client. Register the socket that talks to this client as a
		-- managed socket so that a select can work on it too
		local
			socket : TCP_SOCKET
		do
			io.put_character ('#')
			socket := wait_for_new_connection
			if socket /= Void then
				socket_multiplexer.register_managed_socket_read (socket)
			else
				io.put_character ('V')
				io.put_integer (socket_multiplexer.last_socket_error_code)
				io.put_character (',')
				io.put_integer (socket_multiplexer.last_extended_socket_error_code)
				io.put_character (',')
				io.put_integer (socket_multiplexer.managed_read_count)
				io.put_character ('V')
			end
		end



end -- class HTTP_SERVER_SOCKET

