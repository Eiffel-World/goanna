indexing
	description: "Fast CGI variable constants"
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	FAST_CGI_VARIABLES

feature -- Access

	Gateway_interface: STRING is "GATEWAY_INTERFACE"
	Server_name: STRING is "SERVER_NAME"
	Server_software: STRING is "SERVER_SOFTWARE"
	Server_protocol: STRING is "SERVER_PROTOCOL"
	Server_port: STRING is "SERVER_PORT"
	Request_method: STRING is "REQUEST_METHOD"
	Path_info: STRING is "PATH_INFO"
	Path_translated: STRING is "PATH_TRANSLATED"
	Script_name: STRING is "SCRIPT_NAME"
	Document_root: STRING is "DOCUMENT_ROOT"
	Query_string: STRING is "QUERY_STRING"
	Remote_host: STRING is "REMOTE_HOST"
	Remote_addr: STRING is "REMOTE_ADDR"
	Auth_type: STRING is "AUTH_TYPE"
	Remote_user: STRING is "REMOTE_USER"
	Remote_ident: STRING is "REMOTE_IDENT"
	Content_type: STRING is "CONTENT_TYPE"
	Content_length: STRING is "CONTENT_LENGTH"
	Http_from: STRING is "HTTP_FROM"
	Http_accept: STRING is "HTTP_ACCEPT"
	Http_user_agent: STRING is "HTTP_USER_AGENT"
	Http_referer: STRING is "HTTP_REFERER"

end -- class FAST_CGI_VARIABLES
