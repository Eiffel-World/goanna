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
			parameters.put (serving_socket.peer_name, Remote_host_var)
			parameters.put (serving_socket.peer_address, Remote_addr_var)
			parameters.put (serving_socket.servlet_manager.config.document_root, Document_root_var)
		end
		
	parse_request_buffer (buffer: STRING) is
			-- Parse request buffer to set parameters
		require
			buffer_exists: buffer /= Void
		local
			tokenizer: STRING_TOKENIZER
		do
			-- parse the request line
			create tokenizer.make (buffer)
			tokenizer.start
			parameters.put (tokenizer.token, Request_method_var)
			tokenizer.forth
			parameters.put (tokenizer.token, Script_name_var)
			tokenizer.forth
			parameters.put (tokenizer.token, Server_protocol_var)
			-- debug
			parameters.put (buffer, Http_from_var)
		end
			
end -- class HTTPD_REQUEST
