indexing
	description: "HTTP parsed request"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."


class
	HTTPD_REQUEST

inherit
	
		HTTPD_CGI_HEADER_VARS
			export
				{NONE} all
			end
			
creation
	make
	
feature -- Initialisation

	make (serving_socket: HTTPD_SERVING_SOCKET; buffer: STRING) is
			-- Parse 'buffer' to initialise the request parameters
		require
			socket_exists: serving_socket /= Void
			buffer_exists: buffer /= Void
		do
			create parameters.make (15)
			parse_request_buffer (buffer)
			set_server_parameters (serving_socket)
		end
		
feature -- Access

	parameter (name: STRING): STRING is
			-- Return value of parameter 'name'
		require
			name_exists: name /= Void
			parameter_exists: has_parameter (name)
		do
			Result := parameters.item (name)
		end
		
	has_parameter (name: STRING): BOOLEAN is
			-- Does the parameter 'name' exists for this request?
		require
			name_exists: name /= Void
		do
			Result := parameters.has (name)
		end

	parameters: DS_HASH_TABLE [STRING, STRING]
			-- Table of request parameters. Equivalent to the CGI parameter set.
		
feature {NONE} -- Implementation
		
	set_server_parameters (serving_socket: HTTPD_SERVING_SOCKET) is
			-- Set server specific parameters for request
		require
			serving_socket_exists: serving_socket /= Void
		do
			parameters.put ("Goanna HTTP Server V1.0", Server_software_var)
			parameters.put ("CGI/1.1", Gateway_interface_var)
			parameters.put (serving_socket.servlet_manager.config.server_port.out, Server_port_var)
			parameters.put (serving_socket.peer_name, Remote_host_var)
			parameters.put (serving_socket.peer_address, Remote_addr_var)
			parameters.put (serving_socket.servlet_manager.config.document_root, Document_root_var)
		end
		
	parse_request_buffer (buffer: STRING) is
			-- Parse request buffer to set parameters
		require
			buffer_exists: buffer /= Void
		local
			t1, t2: STRING_TOKENIZER
			request, header: STRING
		do
			-- parse the request line
			create t1.make (buffer)
			t1.set_token_separator ('%N')
			t1.start
			-- parse request line
			request := t1.token
			request.right_adjust
			create t2.make (request)
			t2.start
			parameters.put (t2.token, Request_method_var)
			t2.forth
			parse_request_uri (t2.token)
			t2.forth
			parameters.put (t2.token, Server_protocol_var)
			-- parse remaining header lines
			from
				t1.forth
				header := t1.token
				header.right_adjust
			until
				header.is_empty
			loop
				-- parse the next header line
				print (header + "%R%N")
				t1.forth
				header := t1.token
				header.right_adjust	
			end
			
			-- debug
			parameters.put (buffer, Http_from_var)
		end
			
	parse_request_uri (token: STRING) is
			-- Parse the request uri extracting the path info, script path and query string.
		require
			token_exists: token /= Void
		local
			query_index: INTEGER
			path: STRING
		do
			query_index := token.index_of ('?', 1)
			if query_index /= 0 then
				path := token.substring (1, query_index - 1)
				parameters.put (token.substring (query_index + 1, token.count), Query_string_var)
			else
				path := token
			end
			parameters.put (path, Script_name_var)
			parameters.put (path, Path_info_var)
		end
		
end -- class HTTPD_REQUEST
