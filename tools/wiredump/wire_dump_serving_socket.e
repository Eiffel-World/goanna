indexing
	description: "Callback server socket that processes wire dump connections."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools wiredump"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class WIRE_DUMP_SERVING_SOCKET

inherit

	TCP_SOCKET
		redefine
			multiplex_read_callback
		end

	SOCKET_MULTIPLEXER_SINGLETON
		export
			{NONE}all
		end

	SHARED_SERVLET_MANAGER
		
	WIRE_DUMP_LOGGER
		export
			{NONE} all
		end
		
creation

    make_uninitialized

feature

	multiplex_read_callback is
			-- this routine is called if there is data ready for
			-- reading on our socket
		local
		do
			debug ("status_output")
				io.put_character ('?')
			end
			-- read the request
			check_socket_error ("read callback")
			proxy_request
			-- close socket after sending reply
			socket_multiplexer.unregister_managed_socket_read (Current)
			close
		end

feature {NONE}

	proxy_request is
			-- Read data from client, dump it and send it on.
		local
			buffer: STRING
			done: BOOLEAN
		do
			create Result.make (8192)
			if socket_ok then
				-- read until socket closed by peer 
				content_length_found := False
				content_length := -1
				end_header_index := -1
				from
					create buffer.make (8192)
					buffer.fill_blank
					receive_string (buffer)
					check_socket_error ("after priming read")
				until
					done or not socket_ok
				loop
					Result.append (buffer.substring (1, bytes_received))
					done := check_request (Result)
					if not done then
						buffer.fill_blank
						receive_string (buffer)
						check_socket_error ("after loop read")					
					end
				end
			end
		end

	socket_ok: BOOLEAN
			-- Was last socket operation successful?
			
	check_socket_error (message: STRING) is
			-- Check for socket error and print
		require
			message_exists: message /= Void
		do
			debug ("socket")
				print ("Socket status (" + message + "):%N")
			end
			if last_error_code /= Sock_err_no_error then
				socket_ok := False
				log_hierarchy.category (Internal_category).error ("Socket error: " 
					+ last_error_code.out + "%N")
				log_hierarchy.category (Internal_category).error ("Extended error: " 
					+ last_extended_socket_error_code.out + "%N")
			else
				socket_ok := True
			end
			debug ("socket")
				print ("%TBytes received: " + bytes_received.out + "%N")
				print ("%TBytes sent: " + bytes_sent.out + "%N")
				print ("%TBytes available: " + bytes_available.out + "%N")
				print ("%TSocket valid: " + is_valid.out + "%N")
			end
		end
		
end -- HTTPD_SERVING_SOCKET
