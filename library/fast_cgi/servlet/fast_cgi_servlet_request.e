indexing
	description: "Objects that represent FastCGI servlet request information."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	FAST_CGI_SERVLET_REQUEST

inherit
	HTTP_SERVLET_REQUEST

	FAST_CGI_VARIABLES
		export
			{NONE} all
		end
		
	HTTP_UTILITY_FUNCTIONS
		export
			{NONE} all
		end
		
create

	make
	
feature {NONE} -- Initialisation

	make (fcgi_request: FAST_CGI_REQUEST) is
			-- Create a new fast cgi servlet request wrapper for
			-- the request information contained in 'fcgi_request'
		require
			request_exists: fcgi_request /= Void
		do
			internal_request := fcgi_request
			create parameters.make (5)
			parse_parameters
		end
	
feature -- Access

	get_parameter (name: STRING): STRING is
			-- Returns the value of a request parameter
		do
			Result := clone (parameters.item (name))
		end

	get_parameter_names: DS_LINEAR [STRING] is
			-- Return all parameter names
		local
			cursor: DS_HASH_TABLE_CURSOR [STRING, STRING]
			array_list: DS_ARRAYED_LIST [STRING]
		do
			create array_list.make (parameters.count)
			cursor := parameters.new_cursor
			from
				cursor.start
			until
				cursor.off
			loop
				array_list.force_last (clone (cursor.key))
				cursor.forth
			end
			Result := array_list
		end

	get_parameter_values: DS_LINEAR [STRING] is
			-- Return all parameter values
		local
			cursor: DS_HASH_TABLE_CURSOR [STRING, STRING]
			array_list: DS_ARRAYED_LIST [STRING]
		do
			create array_list.make (parameters.count)
			cursor := parameters.new_cursor
			from
				cursor.start
			until
				cursor.off
			loop
				array_list.force_last (clone (cursor.item))
				cursor.forth
			end
			Result := array_list
		end
	
	get_header (name: STRING): STRING is
			-- Get the value of the specified request header.
		do
			Result := clone (internal_request.parameters.item (name))
		end

	get_headers (name: STRING): DS_LINEAR [STRING] is
			-- Get all values of the specified request header. If the
			-- header has comma-separated values they are separated and added to the
			-- result. If only one value exists, it is added as the sole entry in the
			-- list.
		do
			
		end
		
	get_header_names: DS_LINEAR [STRING] is
			-- Get all header names.
		local
			cursor: DS_HASH_TABLE_CURSOR [STRING, STRING]
			array_list: DS_ARRAYED_LIST [STRING]
		do
			create array_list.make (internal_request.parameters.count)
			cursor := internal_request.parameters.new_cursor
			from
				cursor.start
			until
				cursor.off
			loop
				array_list.force_last (clone (cursor.key))
				cursor.forth
			end
			Result := array_list
		end
	
feature -- Status report

	has_parameter (name: STRING): BOOLEAN is
			-- Does this request have a parameter named 'name'?
		do
		end

	content_length: INTEGER is
			-- The length in bytes of the request body or -1 if the length is
			-- not known.
		local
			str: STRING
		do
			str := get_header (Content_length_var)
			if str.is_integer then
				Result := str.to_integer	
			end 
		end

	content_type: STRING is
			-- The MIME type of the body of the request, or Void if the type is
			-- not known.
		do
			Result := get_header (Content_type_var)
		end

	protocol: STRING is
			-- The name and version of the protocol the request uses in the form
			-- 'protocol/majorVersion.minorVrsion', for example, HTTP/1.1.
		do
			Result := get_header (Server_protocol_var)
		end

	scheme: STRING is
			-- The name of the scheme used to make this request. Such as, http, https
			-- or ftp.
		do	
		end

	server_name: STRING is
			-- The host name of the server that received the request.
		do
			Result := get_header (Server_name_var)			
		end

	server_port: STRING is
			-- The port number on which this request was received.
		do
			Result := get_header (Server_port_var)
		end

	remote_address: STRING is
			-- The internet protocol (IP) address of the client that sent the request.
		do
			Result := get_header (Remote_addr_var)
		end

	remote_host: STRING is
			-- The fully qualified name of the client that sent the request, or the
			-- IP address of the client if the name cannot be determined.
		do			
			Result := get_header (Remote_host_var)
		end

	is_secure: BOOLEAN is
			-- Was this request made using a secure channel, such as HTTPS?
		do
		end
		
	has_header (name: STRING): BOOLEAN is
			-- Does this request contain a header named 'name'?
		do
			Result := internal_request.parameters.has (name)
		end

	auth_type: STRING is
			-- The name of the authentication scheme used to protect the servlet,
			-- for example, "BASIC" or "SSL" or Void if the servlet was not protected.
		do
			Result := get_header (Auth_type_var)
		end

	cookies: ARRAY [COOKIE] is
			-- Cookies sent with this request.
		do
		end

	method: STRING is
			-- The name of the HTTP method with which this request was made, for
			-- example, GET, POST, or HEAD.
		do
			Result := get_header (Request_method_var)
		end

	path_info: STRING is
			-- Any extra path information associated with the URL the client sent
			-- when it made the request.
		do
			Result := get_header (Path_info_var)
		end

	path_translated: STRING is
			-- Any extra path information after the servlet name but before
			-- the query string translated to a real path.
		do
			Result := get_header (Path_translated_var)
		end

	query_string: STRING is
			-- The query string that is contained in the request URL after the path.
			-- Returns Void if no query string is sent.
		do
			Result := get_header (Query_string_var)	
		end

	remote_user: STRING is
			-- The login of the user making this request, if the user has been
			-- authenticated, or Void if the user has not been authenticated.
		do
			Result := get_header (Remote_user_var)
		end

	servlet_path: STRING is
			-- The part of this request's URL that calls the servlet. This includes
			-- either the servlet name or a path to the servlet, but does not include
			-- any extra path information or a query string.
		do
			Result := get_header (Script_name_var)
		end
	
feature {NONE} -- Implementation

	internal_request: FAST_CGI_REQUEST
		-- Internal request information and stream functionality.
	
	parameters: DS_HASH_TABLE [STRING, STRING]
			-- Table of parameter values with support for multiple values per parameter name
			
	parse_parameters is
			-- Parse the query string or stdin data for parameters and
			-- store in params structure.			
		do
			-- If the request is a GET then the parameters are stored in the query
			-- string. Otherwise, the parameters are in the stdin data.
			if method.is_equal ("GET") then
				parse_parameter_string (query_string)
			elseif method.is_equal ("POST") then
				parse_parameter_string (internal_request.raw_stdin_content)
			else
				-- not sure where the parameters will be for other request methods.
				-- Need to experiment.
			end
		end
	
	parse_parameter_string (str: STRING) is
			-- Parse the parameter string 'str' and build parameter structure.
			-- Parameters are of the form 'name=value' separated by '&' with all
			-- spaces and special characters encoded. An exception is an image map 
			-- coordinate pair that is of the form 'value,value'. Any amount of
			-- whitespace may separate each token.
		local
			i, e, next: INTEGER
			pair, name, value: STRING
			tokenizer: STRING_TOKENIZER
		do
			-- parameters can appear more than once. Add a parameter value for each instance.
			debug ("query_string_parsing")
				print (generator + ".parse_parameter_string str = " + quoted_eiffel_string_out (str) + "%R%N")
			end
			create tokenizer.make (str)
			tokenizer.set_token_separator ('&')
			from
				tokenizer.start
			until
				tokenizer.off
			loop
				-- get the parameter pair token
				pair := tokenizer.token
				-- find equal character
				e := pair.index_of ('=', 1)
				if e > 0 then
					name := pair.substring (1, e - 1)
					value := pair.substring (e + 1, pair.count)
					-- add the parameter
					add_parameter (name, decode_url(value))
				else
					-- TODO: check for a coordinate pair
				end
				tokenizer.forth
			end
		end
		
	add_parameter (name, value: STRING) is
			-- Set decoded 'value' for the parameter 'name' to the parameters structure.
			-- Replace any existing parameter value with the same name.
		do
			debug ("query_string_parsing")
				print (generator + ".add_parameter name = " 
					+ quoted_eiffel_string_out (name) 
					+ " value = " + quoted_eiffel_string_out (value) + "%R%N")
			end	
			parameters.force (value, name)
		end
	
end -- class FAST_CGI_SERVLET_REQUEST
