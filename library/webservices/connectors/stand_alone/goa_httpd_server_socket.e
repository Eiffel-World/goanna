indexing

	author:      "Marcio Marchini <mqm@users.sourceforge.net>"
	copyright:   "Copyright (c) 2000, Marcio Marchini"
	thanks:		 "Bedarra (www.bedarra.com) for support of open source; Richie Bielak for Emu"
	license:    "Eiffel Forum License v2 (see forum.txt)"
	date:        "$Date$"
	revision:    "$Revision$"


class GOA_HTTPD_SERVER_SOCKET

inherit

	EPX_TCP_SERVER_SOCKET
		redefine
			multiplexer_read_callback,
			accept
		end

	EPX_SOCKET_MULTIPLEXER_SINGLETON
		export
			{NONE} all
		end

	GOA_HTTPD_LOGGER
		export
			{NONE} all
		end

create

    make

feature

	accept: ABSTRACT_TCP_SOCKET is
			-- Return the next completed connection from the front of the
			-- completed connection queue. If there are no completed
			-- connections, the process is put to sleep.
			-- If the socket is non-blocking, Void will be returned and
			-- the process is not put to sleep..
		local
			client_fd: INTEGER
		do
			address_length := client_socket_address.capacity
			client_fd := abstract_accept (fd, client_socket_address.ptr, $address_length)
			if client_fd = unassigned_value then
				if errno.is_not_ok and then errno.value /= EAGAIN then
					raise_posix_error
				end
			else
				create {GOA_HTTPD_SERVING_SOCKET} Result.attach_to_socket (client_fd, True)
				last_client_address := new_socket_address_in_from_pointer (client_socket_address, address_length)
			end
		end

	multiplexer_read_callback (a_multiplexer: EPX_SOCKET_MULTIPLEXER) is
			-- we got a new client. Register the socket that talks to this client as a
			-- managed socket so that a select can work on it too
		local
			socket : ABSTRACT_TCP_SOCKET
		do
			debug ("status_output")
				io.put_character ('#')
			end
			socket := accept
			if errno.is_ok then
				socket_multiplexer.add_read_socket (socket)
			else
				log_hierarchy.logger (Internal_category).error (
					"Server socket error: " + socket_multiplexer.errno.first_value.out
-- TODO					+ "," + socket_multiplexer.last_extended_socket_error_code.out
				)
				errno.clear_first
			end
		end

end -- class GOA_HTTPD_SERVER_SOCKET


