indexing
	description: "Objects that represent an XML-RPC response."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XRPC_RESPONSE

inherit
	
	XRPC_ELEMENT
	
creation
	
	make, make_with_value, unmarshall
	
feature -- Initialisation

	make (new_param: XRPC_PARAM) is
			-- Initialise response with given 'value'. Parameter may be Void.
		do
			value := new_param
			unmarshall_ok := True
		end

	make_with_value (new_value: XRPC_VALUE) is
			-- Initialise response with given 'value'. Routine will create 
			-- required parameter object. Value may be Void.
		local
			param: XRPC_PARAM
		do
			if new_value /= Void then
				create param.make (new_value)
				value := param
			end
			unmarshall_ok := True
		end
		
	unmarshall (node: DOM_ELEMENT) is
			-- Initialise XML-RPC call from DOM element.
		local
			params, param, pvalue: DOM_ELEMENT
		do
			unmarshall_ok := True
			if node.has_child_nodes then
				params ?= node.first_child
				if params /= Void then
					if params.has_child_nodes then
						pvalue ?= params.first_child
						check
							value_is_element: pvalue /= Void
						end
						create value.unmarshall (pvalue)
						if not value.unmarshall_ok then
							unmarshall_ok := False
							unmarshall_error_code := value.unmarshall_error_code
						end	
					else
						unmarshall_ok := False
						unmarshall_error_code := Response_value_missing
					end		
				end	
			end
		end
	
feature -- Access
	
	value: XRPC_PARAM
			-- Result

feature -- Status setting

	set_value (new_value: XRPC_PARAM) is
			-- Set the value to 'new_value'. Value may be Void.
		do
			value := new_value
		end
	
feature -- Marshalling

	marshall: STRING is
			-- Serialize this response to XML format
		do
			create Result.make (300)
			Result.append ("<?xml version=%"1.0%"?><methodResponse>")
			if value /= Void then
				Result.append ("<params>")
				Result.append (value.marshall)
				Result.append ("</params>")
			end
			Result.append ("</methodResponse>")
		end
	
end -- class XRPC_RESPONSE
