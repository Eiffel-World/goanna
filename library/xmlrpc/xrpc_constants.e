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

	Unsupported_method_fault_code: INTEGER is 1
			-- Attempt to call XMLRPC using unsupported method

	Bad_payload_fault_code: INTEGER is 2
			-- Request did not contain a valid XMLRPC payload

	Method_name_element_missing: INTEGER is 3
			-- Method name element is missing in method call
			
	Param_value_element_missing: INTEGER is 4
			-- The value element of a parameter is missing
			
	Param_value_type_element_missing: INTEGER is 5
			-- The type element of a value is missing.
			
	Invalid_integer_value: INTEGER is 6
			-- Invalid integer value
			
	Invalid_double_value: INTEGER is 7
			-- Invalid double value
		
	Invalid_boolean_value: INTEGER is 8
			-- Invalid boolean value
			
	Invalid_value_type: INTEGER is 9
			-- Unknown value type specified
			
	Value_text_element_missing: INTEGER is 10
			-- Value element does not contain an expected text element
			
	Int_type: STRING is "int"
			-- Four byte signed integer
	
	Alt_int_type: STRING is "i4"
			-- Alternate integer type. Same as "int"
			
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
	
	fault_code_string (code: INTEGER): STRING is
			-- Return error message for fault 'code'.
		require
			valid_fault_code: code >= 0
		do
			if code >= Fault_strings.lower and code <= Fault_strings.upper then
				Result := Fault_strings.item (code)
			else
				Result := "Unknown fault code"
			end		
		end
		
	Fault_strings: ARRAY [STRING] is
			-- Fault error messages
		once
			Result := <<
				"Unsupported request method",								-- 1
				"Bad request payload",										-- 2
				"Method name element is missing in method call",			-- 3
				"The value element of a parameter is missing", 				-- 4
				"The type element of a value is missing",					-- 5
				"Invalid integer value",									-- 6
				"Invalid double value",										-- 7
				"Invalid boolean value",									-- 8
				"Unknown value type specified",								-- 9
				"Value element does not contain an expected text element"	-- 10
			>>
		end
		
	Method_name_element: DOM_STRING is
			-- Tag <methodName>
		once
			create Result.make_from_string ("methodName")
		end

	Params_element: DOM_STRING is
			-- Tag <methodName>
		once
			create Result.make_from_string ("params")
		end
		
	Param_element: DOM_STRING is
			-- Tag <methodName>
		once
			create Result.make_from_string ("param")
		end

	Value_element: DOM_STRING is
			-- Tag <methodName>
		once
			create Result.make_from_string ("value")
		end

	Array_element: DOM_STRING is
			-- Tag <methodName>
		once
			create Result.make_from_string ("array")
		end

	Struct_element: DOM_STRING is
			-- Tag <methodName>
		once
			create Result.make_from_string ("struct")
		end
	
	Value_factory: XRPC_VALUE_FACTORY is
			-- Shared value factory
		once
			create Result.make
		end
		
end -- class XRPC_CONSTANTS
