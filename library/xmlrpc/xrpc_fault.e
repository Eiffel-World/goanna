indexing
	description: "Objects that represent an XML-RPC fault."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XRPC_FAULT

inherit
	
	XRPC_ELEMENT
	
creation
	
	make, unmarshall
	
feature -- Initialisation

	make (new_code: INTEGER) is
			-- Initialise 
		do
			code := new_code
			string := fault_code_string (code)
			unmarshall_ok := True
		end
		
	unmarshall (node: DOM_ELEMENT) is
			-- Initialise XML-RPC call from DOM element.
		local
			value: XRPC_STRUCT_VALUE
			member_value: XRPC_SCALAR_VALUE
			value_elem: DOM_ELEMENT
			int_ref: INTEGER_REF
		do
			unmarshall_ok := True
			-- can assume that the <fault> element exists
			-- get fault value and attempt to unmarshall
			value_elem ?= node.first_child.first_child
			if value_elem /= Void then
				value ?= Value_factory.unmarshall (value_elem)
				-- check that it was a struct
				if value /= Void then
					-- get faultCode
					if value.value.has (Fault_code_member) then
						member_value ?= value.value.item (Fault_code_member) 
						if member_value /= Void then
							int_ref ?= member_value.value
							if int_ref /= Void then
								code := int_ref.item
								-- get faultString
								if value.value.has (Fault_string_member) then
									member_value ?= value.value.item (Fault_string_member)
									if member_value /= Void then
										string ?= member_value.value
										if string = Void then
											unmarshall_ok := False
											unmarshall_error_code := Invalid_fault_string					
										end	
									else
										unmarshall_ok := False
										unmarshall_error_code := Invalid_fault_string	
									end				
								end
							else
								unmarshall_ok := False
								unmarshall_error_code := Invalid_fault_code	
							end	
						else
							unmarshall_ok := False
							unmarshall_error_code := Invalid_fault_code	
						end	
					else
						unmarshall_ok := False
						unmarshall_error_code := Fault_code_member_missing	
					end
				else
					unmarshall_ok := False
					unmarshall_error_code := Invalid_fault_value
				end
			else
				unmarshall_ok := False
				unmarshall_error_code := Fault_value_element_missing
			end
		end
	
feature -- Access

	code: INTEGER
			-- Fault code

	string: STRING
			-- Fault string

feature -- Status setting

	set_code (new_code: INTEGER) is
			-- Set new fault code
		do
			code := new_code
		end

	set_string (new_string: STRING) is
			-- Set new fault string
		do
			string := new_string
		end

feature -- Marshalling

	marshall: STRING is
			-- Serialize this fault to XML format
		do
			create Result.make (200)
			Result.append ("<?xml version=%"1.0%"?><methodResponse><fault><value><struct><member><name>faultCode</name><value><int>")
			Result.append (code.out)
			Result.append ("</int></value></member><member><name>faultString</name><value><string>")
			Result.append (string)
			Result.append ("</string></value></member></struct></value></fault></methodResponse>")
		end

invariant
	
	string_exists: string /= Void
	
end -- class XRPC_FAULT
