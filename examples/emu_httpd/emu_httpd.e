indexing

	description: "Root class of the Emu http server"
	date: "10/30/98"
	author: " Copyright (c) 1998, Richard Bielak"

class EMU_HTTPD

inherit

	ARGUMENTS

	SHARED_DOCUMENT_ROOT

	SOCKET_MULTIPLEXER_SINGLETON

	MEMORY -- GC calls

	SOCKET_ERRORS -- test error codes

	KL_SHARED_ARGUMENTS
      	export 
			{NONE} all
      	end

creation

	make

feature

	port: INTEGER
			-- port the server listens on

	document_root: STRING
			-- base path for server documents

	make is
			-- start the server: we expect two arguments: port on
			-- which to listen and a documents directory. All
			-- requests for files will be server relative to this directory
		do
			if Arguments.argument_count < 2 then
				print ("Usage: emu_httpd <port-number> <doc-root>%N")
			else
				-- TODO: improve this code - add error checks
				port := Arguments.argument(1).to_integer
				document_root := Arguments.argument(2)
				document_root_cell.put (document_root)
				print ("Emu port: ")
				print (port)
				print (" Doc root: ")
				print (document_root)
				print ("%N")
				init_server
				serve
			end
		rescue
			-- handle kill signals and some such
		end

feature {NONE}

	server_socket: HTTP_SERVER_SOCKET
			-- socket for accepting of new connections


	init_server is
			-- set up the server
		require
			valid_port: port > 0
		do
			-- prepare the socket
			!!server_socket.make (port , 10)
			socket_multiplexer.register_managed_socket_read (server_socket) -- we start with just one managed. As we get connections, we add more managed
			io.put_string ("Waiting (selecting) for connections...%N")
			io.put_string ("----------legend:---------------------%N")
			io.put_string ("#   : new client%N")
			io.put_string (".   : received data from a client%N")
			io.put_string ("?   : idle%N")
			io.put_string ("--------------------------------------%N")
		end

	serve is
			-- this routine never exists
		local
			multiplexed : BOOLEAN
			count : INTEGER
			error: INTEGER
		do
			from
				multiplexed := true
			until
				error = sock_err_select
			loop
				multiplexed := socket_multiplexer.multiplex_registered ( 15 , 0) -- it will exit after 60 seconds of no activity
				if not multiplexed then
					io.put_character ('?') -- maybe just idle
					error := socket_multiplexer.last_socket_error_code
					if error /= 0 then
						io.put_integer (socket_multiplexer.last_socket_error_code)
					end
				else
					io.put_character ('!') -- multiplexed
				end
				-- the following lines are a workaround for
				-- http://www.egroups.com/message/smalleiffel/2562
				-- http://www.egroups.com/message/smalleiffel/2574
				count := count + 1
				if (count \\ 5) = 0 then
					full_collect
				end
			end
		end

end
