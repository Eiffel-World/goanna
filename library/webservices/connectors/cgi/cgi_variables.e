indexing
	description: "Objects that represent a CGI servlet application"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "CGI servlets"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	CGI_VARIABLES
	
feature -- Access

	Gateway_interface_var: STRING is "GATEWAY_INTERFACE"
	Server_name_var: STRING is "SERVER_NAME"
	Server_software_var: STRING is "SERVER_SOFTWARE"
	Server_protocol_var: STRING is "SERVER_PROTOCOL"
	Server_port_var: STRING is "SERVER_PORT"
	Request_method_var: STRING is "REQUEST_METHOD"
	Path_info_var: STRING is "PATH_INFO"
	Path_translated_var: STRING is "PATH_TRANSLATED"
	Script_name_var: STRING is "SCRIPT_NAME"
	Document_root_var: STRING is "DOCUMENT_ROOT"
	Query_string_var: STRING is "QUERY_STRING"
	Remote_host_var: STRING is "REMOTE_HOST"
	Remote_addr_var: STRING is "REMOTE_ADDR"
	Auth_type_var: STRING is "AUTH_TYPE"
	Remote_user_var: STRING is "REMOTE_USER"
	Remote_ident_var: STRING is "REMOTE_IDENT"
	Content_type_var: STRING is "CONTENT_TYPE"
	Content_length_var: STRING is "CONTENT_LENGTH"
	Http_from_var: STRING is "HTTP_FROM"
	Http_accept_var: STRING is "HTTP_ACCEPT"
	Http_user_agent_var: STRING is "HTTP_USER_AGENT"
	Http_referer_var: STRING is "HTTP_REFERER"
	Http_cookie_var: STRING is "HTTP_COOKIE"

end -- class CGI_VARIABLES
