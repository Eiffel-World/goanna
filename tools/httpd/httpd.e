indexing
	description: "HTTP Server."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	HTTPD

inherit

	KL_SHARED_ARGUMENTS
		export
			{NONE} all
		end
	
	SHARED_DOCUMENT_ROOT
		export
			{NONE} all
		end
	
	SHARED_SERVLET_MANAGER
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

creation
	make

feature -- Initialization

	make is
			-- Create and initialise a new HTTP server that will listen for connections
			-- on 'port' and serving documents from 'doc_root'.
			-- Start the server
		do
			parse_arguments
			if argument_error then
				print_usage
			else
				init_servlets
				init_server
				run
			end
		end

feature -- Status report

	port: INTEGER
			-- Server connection port
				
feature {NONE} -- Implementation

	argument_error: BOOLEAN
			-- Did an error occur parsing arguments?

	parse_arguments is
			-- Parse the command line arguments and store appropriate settings
		local
			dir: DIRECTORY
		do
			if Arguments.argument_count < 2 then
				argument_error := True
			else
				-- parse port
				if Arguments.argument(1).is_integer then
					port := Arguments.argument(1).to_integer
					-- parse document root
					create dir.make (Arguments.argument (2))
					if dir.exists and then dir.is_readable then
						document_root_cell.put (dir.name)
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
			print ("Usage: httpd <port-number> <document-root>%R%N")
		end
	
	init_servlets is
			-- Initialise servlets
		local
			config: SERVLET_CONFIG
			test_servlet: HTTP_SERVLET
			
		do
			create config
			create {TEST_SERVLET} test_servlet.init (config)
			servlet_manager.register_servlet (test_servlet, "basic")
			create {XMLE_TEST_SERVLET} test_servlet.init (config)
			servlet_manager.register_servlet (test_servlet, "xmle")
			create {DOM_TEST_SERVLET} test_servlet.init (config)
			servlet_manager.register_servlet (test_servlet, "dom")
		end
		
	server_socket: HTTPD_SERVER_SOCKET
			-- Socket for accepting of new connections

	init_server is
			-- Set up the server
		require
			valid_port: port > 0
		do
			-- prepare the socket
			!!server_socket.make (port, 10)
			socket_multiplexer.register_managed_socket_read (server_socket)
			print ("Waiting for connections...%N")
			print ("----------Legend:---------------------%N")
			print ("#       : new client%N")
			print ("?       : received data from a client%N")
			print ("&       : send data to client%N")
			print ("!       : multiplexed%N")
			print (".       : idle%N")
			print ("(n,e,c) : socket error (n), extended error (c), read count (c)%N")
			print ("--------------------------------------%N")
		end	
		
	run is
			-- Start serving requests
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
					io.put_character ('.') -- maybe just idle
					error := socket_multiplexer.last_socket_error_code
					if error /= 0 then
						io.put_integer (socket_multiplexer.last_socket_error_code)
					end
				else
					io.put_character ('!') -- multiplexed
				end
			end
		end
	
end -- class HTTPD