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
	POSIX_CONSTANTS
	KL_EXCEPTIONS

feature -- Initialisation

	make (new_host: STRING; port, backlog: INTEGER) is
			-- Initialise this FCGI application to listen on 'port' with room for 'backlog'
			-- outstanding requests.
		require
			valid_host: new_host /= Void and then new_host /= Void
				-- Host should be "localhost" (to listen only to domain sockets)
				-- or IP address of local host to listen for network requests for that IP address
				-- Don't know if host name will work or not
			positive_port: port >= 0
			positive_backlog: backlog >= 0
		do
			create host.make_from_name (new_host)
			svr_port := port
			host_name := new_host
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
		do
			debug ("fcgi_interface")
				print (generator + ".accept%R%N")
			end
			if not failed then
				-- if first call mark it and create server socket
				if not accept_called then
					accept_called := True
					initialize_listening
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

	initialize_listening is
		local
			service: EPX_SERVICE
			host_port: EPX_HOST_PORT
		do
			create service.make_from_port (svr_port, "tcp")
			create host_port.make (host, service)
			if srv_socket /= Void then
				srv_socket.close
			end
			create srv_socket.listen_by_address (host_port)
			request := Void
			srv_socket.errno.clear_first
			srv_socket.errno.clear
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
				if request.keep_connection and then request.socket.is_open then
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
		local
			bytes_to_read: INTEGER
			read_ok: BOOLEAN
		do
			from
				Result := ""
				read_ok := True
				bytes_to_read := amount
			until
				bytes_to_read <= 0 or not read_ok
			loop
				request.socket.read_string (amount)
				Result.append (request.socket.last_string)
				bytes_to_read := bytes_to_read - request.socket.last_read
				read_ok := request.socket.last_read > 0
			end
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
				Result := request.parameters.item (name).twin
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

	host: EPX_HOST
		-- Host that is listening for requests


	accept_called: BOOLEAN
		-- Has accept been called?

	srv_socket: EPX_TCP_SERVER_SOCKET
		-- The server socket that this applications listens for requests on.

	svr_port: INTEGER
		-- The port to listen on.

	host_name: STRING
		-- Name of the host

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
			tokenizer: GOA_STRING_TOKENIZER
		do
			addrs := Execution_environment.variable_value (Fcgi_web_server_addrs)
			if addrs /= Void and then not addrs.is_empty then
				create valid_peer_addresses.make
				create tokenizer.make (addrs, ";")
				from
					tokenizer.start
				until
					tokenizer.off
				loop
					address := tokenizer.item
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
			is_new_connection, request_read, failed: BOOLEAN
		do
			-- setup the request and its connection. Use the current request if keep_connection is
			-- specified. Otherwise create a new one.
			if not failed then
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
					-- if peer_address_ok (peer) then
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
				end
--				if Result < 0 then
--					io.put_string ("GOA_FAST_CGI.accept_request = " + Result.out + "%N")--				end
			end
		rescue
			io.put_string ("Is broken pipe: " + is_developer_exception_of_name ("Broken pipe%N").out)
			io.put_string ("Value: " + srv_socket.errno.value.out + "%N")
			io.put_string ("First Value: " + srv_socket.errno.first_value.out + "%N")
			if srv_socket.errno.value = signal_pipe then
				failed := True
				retry
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

