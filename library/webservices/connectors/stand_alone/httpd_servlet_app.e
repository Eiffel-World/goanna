indexing
	description: "HTTP Servlet application."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	HTTPD_SERVLET_APP

inherit
	SERVLET_APPLICATION
	
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

	HTTPD_LOGGER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (port, backlog: INTEGER) is
			-- Set up the server
		do
			-- prepare the socket
			create server_socket.make (port, backlog)
			socket_multiplexer.register_managed_socket_read (server_socket)
			log_hierarchy.category (Internal_category).info ("Goanna HTTPD Server. Version 1.0")
			log_hierarchy.category (Internal_category).info ("Copyright (C) 2001 Glenn Maughan.")
			debug ("status_output")
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
		end	
		
feature {NONE} -- Implementation

	server_socket: HTTPD_SERVER_SOCKET
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
				multiplexed := socket_multiplexer.multiplex_registered (15 , 0) -- it will exit after 60 seconds of no activity
				if not multiplexed then
					debug ("status_output")
						io.put_character ('.') -- maybe just idle
					end
					error_code := socket_multiplexer.last_socket_error_code
					if error_code /= 0 then
						log_hierarchy.category (Internal_category).error ("Socket error: " + error_code.out)
					end
				else
					debug ("status_output")
						io.put_character ('!') -- multiplexed
					end
				end
			end
		end

end -- class HTTPD_SERVLET_APP
