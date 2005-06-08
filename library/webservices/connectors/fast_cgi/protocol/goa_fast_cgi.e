indexing
	description: "Objects that can process FastCGI requests"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI protocol"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_FAST_CGI

inherit

	GOA_FAST_CGI_DEFS
		export
			{NONE} all
		end	

	GOA_FAST_CGI_VARIABLES
		export
			{NONE} all
		end
	
	KL_SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end
		
	L4E_SHARED_HIERARCHY
		rename
			warn as log_warn
		export
			{NONE} all
		end
				
feature -- Initialisation

	make (port, backlog: INTEGER) is
			-- Initialise this FCGI application to listen on 'port' with room for 'backlog'
			-- outstanding requests.
		require
			positive_port: port >= 0
			positive_backlog: backlog >= 0
		do
			svr_port := port
			initialise_logger
			server_backlog := backlog
			set_valid_peer_addresses
		end
	
feature -- FGCI interface

	accept: INTEGER is 
			-- Accept a new request from the HTTP server and create
			-- a CGI-compatible execution environment for the request.
			-- Returns zero for a successful call, -1 for error.
		local
			failed: BOOLEAN
			host: EPX_HOST
			service: EPX_SERVICE
			host_port: EPX_HOST_PORT
		do
			debug ("fcgi_interface")
				print (generator + ".accept%R%N")
			end
			if not failed then
				-- if first call mark it and create server socket
				if not accept_called then
					accept_called := True
					create host.make_from_name ("localhost")
					create service.make_from_port (svr_port, "tcp")
					create host_port.make (host, service)
					create srv_socket.listen_by_address (host_port) 
				end
				-- finish the previous request
				finish
				-- accept the next request
				Result := accept_request				
			end
			debug ("fcgi_interface")
				print (generator + ".accept - finished%R%N")
			end			
		rescue
			srv_socket := Void
			request := Void
			Result := -1 
			failed := True
			debug ("fcgi_interface")
				print (generator + ".accept - exception%R%N")
			end
		end

	finish is 
			-- Finish the current request from the HTTP server. The
			-- current request was started by the most recent call to 
			-- 'accept'.
		do
			debug ("fcgi_interface")
				print (generator + ".finish%R%N")
			end			
			if request /= Void then
				-- complete the current request
				request.end_request
				if request.keep_connection then
					request.socket.close
					request.make -- reset the request
				else
					request := Void
				end
			end
			debug ("fcgi_interface")
				print (generator + ".finish - finished%R%N")
			end
		end

	flush is 
			-- Flush output and error streams.
		do
		end

	putstr (str: STRING) is 
			-- Print 'str' to standard output stream.
		require
			request_exists: request /= Void
		do 
			request.write_stdout (str)
		end

	warn (str: STRING) is 
			-- Print 'str' to standard error stream.
		require
			request_exists: request /= Void
		do
			request.write_stderr (str)
		end

	getstr (amount: INTEGER): STRING is 
			-- Read 'amount' characters from standard input stream.
		require
			request_exists: request /= Void
		do
			create Result.make (amount)
			Result.fill_blank
			request.socket.read_string (amount)
			Result := request.socket.last_string
		end

	getline (amount: INTEGER): STRING is
			-- Read up to n - 1 consecutive bytes from the input stream
			-- into the Result. Stops before n - 1 bytes have been read
			-- if '%N' or EOF is read.
		require
			request_exists: request /= Void
		do
		end

	getparam (name: STRING): STRING is
			-- Get the value of the named environment variable.
		require
			request_exists: request /= Void
		do
			if request.parameters.has (name) then
				Result := clone(request.parameters.item (name))
			end
		end

	getparam_integer(name: STRING): INTEGER is
			-- Fetch and convert environment variable
	 		-- Returns 0 on failure.
		require
			request_exists: request /= Void
		local
			str: STRING
		do
			if request.parameters.has (name) then
				str := request.parameters.item (name)
				if str.is_integer then
					Result := str.to_integer
				end
			end
		end
		
feature -- Access

	request: GOA_FAST_CGI_REQUEST
		-- Current request being processed. Void if none.
	
feature {NONE} -- Implementation
	
	accept_called: BOOLEAN
		-- Has accept been called?
				
	srv_socket: EPX_TCP_SERVER_SOCKET
		-- The server socket that this applications listens for requests on.
	
	svr_port: INTEGER
		-- The port to listen on.
			
	server_backlog: INTEGER
		-- The number of requests that can remain outstanding.
	
	valid_peer_addresses: DS_LINKED_LIST [STRING]
		-- Peer addresses that are allowed to connect to this server as defined
		-- in environment variable FCGI_WEB_SERVER_ADDRS.
		-- Void if all peers can connect.
		
	Fcgi_web_server_addrs: STRING is "FCGI_WEB_SERVER_ADDRS"
	
	set_valid_peer_addresses is
			-- Collect valid peer addresses
		local
			addrs, address: STRING
			tokenizer: STRING_TOKENIZER
		do
			addrs := Execution_environment.variable_value (Fcgi_web_server_addrs)
			if addrs /= Void and then not addrs.is_empty then
				create valid_peer_addresses.make
				create tokenizer.make (addrs)
				tokenizer.set_token_separator (',')
				from
					tokenizer.start
				until
					tokenizer.off
				loop
					address := tokenizer.token
					address.right_adjust
					address.left_adjust
					valid_peer_addresses.force_last (address)
					info (Servlet_app_log_category, "Web server address " + address + " added to ACL")
					tokenizer.forth
				end
			end
		end
		
	accept_request: INTEGER is
			-- Wait for a request to be received
		local
			is_new_connection, request_read: BOOLEAN
			peer: STRING
		do			
			-- setup the request and its connection. Use the current request if keep_connection is
			-- specified. Otherwise create a new one.
			if request /= Void then
				-- complete the previous request
				request.end_request
				if request.failed or not request.keep_connection then
					request.socket.close
					request.make -- reset the request
				end
				if request.failed then
					request := Void
					Result := -1	
				end
			else
				create request.make
			end
			-- setup request connection and read request. Attempt to reconnect if the server
			-- closed the connection.
			from
				is_new_connection := False
			until
				request_read or Result = -1		
			loop
				if request.socket = Void then
					-- accept new connection (blocking)
					request.set_socket(srv_socket.accept)
					is_new_connection := True
				end
				-- check peer address for allowed server addresses
--				peer := request.socket.remote_address
--				debug ("yaesockets")
--					print("Yaesockets Error :")
--					print(last_socket_error_code)
--					print(',')
--					print(last_extended_socket_error_code)
--					print ("%R%N")
--					print ("peer_address: " + peer + "%R%N")
--				end
--				if peer_address_ok (peer) then
					-- attempt to read the request. If this fails and it was an old
					-- connection then the server probably closed it; try making a new connection
					-- before giving up.
					request.read
					if not request.read_ok then
						request.socket.close
						request.set_socket (Void)
						-- if this was a new connection then we failed, otherwise try again
						if is_new_connection then
							Result := -1
						end
					else
						request_read := True
					end
--					debug ("yaesockets")
--						print ("Yaesockets - request readOK? " + request_read.out + "%N")
--					end
--				else
					-- reset and attempt a new connection
--					error (Servlet_app_log_category, "Connection from address " + peer + " rejected.")				
--					request.socket.close
--					request.set_socket (Void)
--					is_new_connection := False
--				end
			end
		end
		
	peer_address_ok (peer_address: STRING): BOOLEAN is
			-- Does 'perr_address' appear in the allowable peer addresses for
			-- this server as defined in the environment variable FCGI_WEB_SERVER_ADDRS?
		require
			peer_address_exists: peer_address /= Void and then not peer_address.is_empty
		do		
			if valid_peer_addresses = Void then
				Result := True
			else
				-- search for address
				from
					valid_peer_addresses.start
				until
					valid_peer_addresses.off or Result
				loop
					if peer_address.is_equal (valid_peer_addresses.item_for_iteration) then
						Result := True
					else
						valid_peer_addresses.forth
					end
				end
			end
		end
		
	Servlet_app_log_category: STRING is "servlet.app"
	
	initialise_logger is
			-- Set logger appenders
		local
			appender: L4E_APPENDER
			layout: L4E_LAYOUT
		do
			create {L4E_FILE_APPENDER} appender.make ("log" + svr_port.out + ".txt", True)
			create {L4E_PATTERN_LAYOUT} layout.make ("@d [@-6p] @c - @m%N")
			appender.set_layout (layout)
			log_hierarchy.logger (Servlet_app_log_category).add_appender (appender)
		end
	
end -- class GOA_FAST_CGI

