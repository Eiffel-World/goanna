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
		end
	
feature -- Access

	get_parameter (name: STRING): STRING is
			-- Returns the value of a request parameter
		do
			
		end

	get_parameter_names: LINEAR [STRING] is
			-- Return all parameter names
		do
			
		end

	get_parameter_values: LINEAR [STRING] is
			-- Return all parameter values
		do
			
		end
	
	get_header (name: STRING): STRING is
			-- Get the value of the specified request header.
		do
			Result := internal_request.parameters.item (name)

		end

	get_headers (name: STRING): LINEAR [STRING] is
			-- Get all values of the specified request header. If the
			-- header has comma-separated values they are separated and added to the
			-- result. If only one value exists, it is added as the sole entry in the
			-- list.
		do
			
		end
		
	get_header_names: LINEAR [STRING] is
			-- Get all header names.
		do
			Result := internal_request.parameters.current_keys.linear_representation
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
			
		end
	
feature {NONE} -- Implementation

	internal_request: FAST_CGI_REQUEST
		-- Internal request information and stream functionality.
		
end -- class FAST_CGI_SERVLET_REQUEST
