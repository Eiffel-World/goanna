indexing
	description: "XML-RPC constants."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XRPC_CONSTANTS

feature

	Headerval_content_type: STRING is "text/xml"
			-- Content type for request and response

	Unsupported_method_fault_code: INTEGER is 100
			-- Attempt to call XMLRPC using unsupported method

	Unsupported_method_fault_string: STRING is "Unsupported request method"
			-- Attempt to call XMLRPC using unsupported method

	Bad_payload_fault_code: INTEGER is 101
			-- Request did not contain a valid XMLRPC payload

	Bad_payload_fault_string: STRING is "Bad XMLRPC request payload"
			-- Request did not contain a valid XMLRPC payload

	Int_type: STRING is "int"
			-- Four byte signed integer
			
	Bool_type: STRING is "boolean"
			-- 0 (false) or 1 (true)
			
	String_type: STRING is "string"
			-- ASCII string
			
	Double_type: STRING is "double"
			-- double-precision signed floaging point number
			
	Date_time_type: STRING is "dateTime.iso8601"
			-- date/time in ISO8601 format (YYYYMMDDTHH:MM:SS)
			
	Base64_type: STRING is "base64"
			-- Base64-encoded binary
			
	Array_type: STRING is "array"
			-- Array
			
	Struct_type: STRING is "struct"
			-- Structure
			
end -- class XRPC_CONSTANTS
