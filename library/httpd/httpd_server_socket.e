indexing

	author:      "Marcio Marchini <mqm@magma.ca>"
	copyright:   "Copyright (c) 2000, Marcio Marchini"
	thanks:		 "Bedarra (www.bedarra.com) for support of open source; Richie Bielak for Emu"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:        "$Date$"
	revision:    "$Revision$"


class HTTPD_SERVER_SOCKET

inherit

	TCP_SERVER_SOCKET
		redefine
			new_connection_socket,
			multiplex_read_callback
		end

	SOCKET_MULTIPLEXER_SINGLETON
		export
			{NONE} all
		end

	HTTPD_LOGGER
		export
			{NONE} all
		end
		
creation
    make

feature

	new_connection_socket : HTTPD_SERVING_SOCKET is
			-- this is a factory method. Override it to return an instance of a different class
			-- that will represent the connection to the client
		do
			create Result.make_uninitialized
		end

	multiplex_read_callback is
			-- we got a new client. Register the socket that talks to this client as a
			-- managed socket so that a select can work on it too
		local
			socket : TCP_SOCKET
		do
			debug ("status_output")
				io.put_character ('#')
			end
			socket := wait_for_new_connection
			if socket /= Void then
				socket_multiplexer.register_managed_socket_read (socket)
			else
				log_hierarchy.category (Internal_category).error ("Server socket error: " + socket_multiplexer.last_socket_error_code.out + ","
					+ socket_multiplexer.last_extended_socket_error_code.out + " read_bytes=" 
					+ socket_multiplexer.managed_read_count.out)
			end
		end

end -- class HTTPD_SERVER_SOCKET


