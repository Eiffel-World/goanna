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

	make (socket: HTTPD_SERVING_SOCKET; buffer: STRING) is
			-- Parse 'buffer' to initialise the request parameters
		require
			socket_exists: socket /= Void
			buffer_exists: buffer /= Void
		do
			create parameters.make (20)
			serving_socket := socket
			parse_request_buffer (buffer)
			set_server_parameters
		end
		
feature -- Access

	serving_socket: HTTPD_SERVING_SOCKET
	
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
		
	set_server_parameters is
			-- Set server specific parameters for request
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
			parameters.force (t2.token, Request_method_var)
			t2.forth
			parse_request_uri (t2.token)
			t2.forth
			parameters.force (t2.token, Server_protocol_var)
			-- parse remaining header lines
			from
				t1.forth
				header := t1.token
				header.right_adjust
			until
				header.is_empty
			loop
				-- parse the next header line
				parse_header (header)
				t1.forth
				header := t1.token
				header.right_adjust	
			end
		end
			
	parse_request_uri (token: STRING) is
			-- Parse the request uri extracting the path info, script path and query string.
		require
			token_exists: token /= Void
		local
			query_index, path_index, slash_index: INTEGER
			query, script, path, servlet_prefix: STRING
		do
			
			query_index := token.index_of ('?', 1)
			if query_index /= 0 then
				query := token.substring (1, query_index - 1)
				parameters.force (token.substring (query_index + 1, token.count), Query_string_var)
			else
				parameters.force ("", Query_string_var)
				query := token
			end
			-- assume this is not a servlet request and set the path info to the request
			path := query
			-- if the query begins with the virtual servlet prefix then the script name is
			-- the portion including the prefix and all characters before the next slash.
			-- everything after the next slash is the path info.
			servlet_prefix := "/" + serving_socket.servlet_manager.servlet_mapping_prefix
			script := query
			if query.count > servlet_prefix.count + 1 then
				if query.substring (1, servlet_prefix.count).is_equal (servlet_prefix) then
					slash_index := query.index_of ('/', servlet_prefix.count + 1)
					if slash_index /= 0 then
						script := query.substring (1, slash_index - 1)
						path := query.substring (slash_index, query.count)
					else
						script := query.substring (1, query.count)
					end
				end
			end
			parameters.force (script, Script_name_var)
			parameters.force (path, Path_info_var)
			-- set the translated path if needed
			if not path.is_empty then
				-- path includes leading slash
				parameters.force (serving_socket.servlet_manager.config.document_root + path, 
					Path_translated_var)
			end
		end
		
	parse_header (header: STRING) is
			-- Parse the header and set appropriate CGI variables
		require
			header_exists: header /= Void
		local
			colon_index, i: INTEGER
			name, value: STRING
		do
			-- split the header
			colon_index := header.index_of (':', 1)
			-- extract the name
			name := header.substring (1, colon_index - 1)
			name.to_upper
			from
				i := name.index_of ('-', 1)
			until
				i = 0
			loop
				name.put ('_', i)
				i := name.index_of ('-', i + 1)
			end
			name := "HTTP_" + name 
			-- extract the value
			value := header.substring (colon_index + 1, header.count)
			value.left_adjust
			parameters.force (value, name)
		end
		
end -- class HTTPD_REQUEST
