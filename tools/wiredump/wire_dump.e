indexing
	description: "TCP Wire Dump Utility"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools wiredump"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	WIRE_DUMP

inherit
	
	KL_SHARED_ARGUMENTS
		export
			{NONE} all
		end	
	
	SOCKET_MULTIPLEXER_SINGLETON
		export
			{NONE} all
		end
	
	SOCKET_ERRORS 		
		export
			{NONE} all
		end
		
	WIRE_DUMP_LOGGER
		export
			{NONE} all
		end
	
creation
	make

feature -- Initialization

	make is
			-- Create and initialise a new wire dump proxy that will listen for connections
			-- on the specified 'listen_port', dump the data, and write to 'send_port'.
		do
			parse_arguments
			if argument_error then
				print_usage
			else
				run
			end
		end

feature -- Status report

	read_port: INTEGER
			-- Port to listen on.
	
	write_port: INTEGER
			-- Port to write to.
	
feature {NONE} -- Implementation

	argument_error: BOOLEAN
			-- Did an error occur parsing arguments?
		
	parse_arguments is
			-- Parse the command line arguments and store appropriate settings
		local
			dir: KL_DIRECTORY
		do
			if Arguments.argument_count < 2 then
				argument_error := True
			else
				-- parse read_port
				if Arguments.argument (1).is_integer then
					read_port := Arguments.argument (1).to_integer
					-- parse document root
					if Arguments.argument (1).is_integer then
						write_port := Arguments.argument (1).to_integer
					else
						argument_error := True
					end
				else
					argument_error := True
				end
			end
		end

	print_usage is
			-- Display usage information
		do
			print ("Usage: wiredump <listen-port> <send-port>%R%N")
		end
	
	Internal_category: STRING is "wiredump.internal"
			-- Internal logging category name
	
	start is
			-- Start the wire dump proxy
		do
			-- prepare the socket
			create server_socket.make (read_port, 20)
			socket_multiplexer.register_managed_socket_read (server_socket)
			log_hierarchy.category (Internal_category).info ("Goanna Wire Dump Proxy. Version 1.0")
			log_hierarchy.category (Internal_category).info ("Copyright (C) 2001 Glenn Maughan.")
			run
		end
	
	server_socket: WIRE_DUMP_SERVER_SOCKET
			-- Socket for accepting of new connections
		
	run is
			-- Start serving requests
		local
			multiplexed : BOOLEAN
			error_code: INTEGER
		do
			from
				multiplexed := true
			until
				error_code = sock_err_select
			loop
				-- it will exit after 60 seconds of no activity
				multiplexed := socket_multiplexer.multiplex_registered (15 , 0)
				if not multiplexed then
					debug ("status_output")
						io.put_character ('.') -- maybe just idle
					end
					error_code := socket_multiplexer.last_socket_error_code
					if error_code /= 0 then
						log_hierarchy.category (Internal_category).error ("Socket error: " 
							+ error_code.out)
					end
				else
					debug ("status_output")
						io.put_character ('!') -- multiplexed
					end
				end
			end
		end

end -- class WIRE_DUMP
