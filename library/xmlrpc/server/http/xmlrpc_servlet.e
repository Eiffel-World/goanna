indexing
	description: "XML RPC/Messaging Servlet"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XMLRPC_SERVLET

inherit

	HTTP_SERVLET
		redefine
			do_get, do_post
		end
	
	SHARED_SERVICE_REGISTRY
		export
			{NONE} all
		end
	
	XRPC_CONSTANTS
		export
			{NONE} all
		end
	
	KL_EXCEPTIONS
		export
			{NONE} all
		end
	
	HTTPD_LOGGER
		export
			{NONE} all
		end
		
creation

	init
		
feature -- Basic operations

	do_get (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Process GET request
		local
			response_text: STRING
		do			
			create fault.make (Unsupported_method_fault_code)
			response_text := fault.marshall
			-- send response
			resp.set_content_type (Headerval_content_type)
			resp.set_content_length (response_text.count)
			resp.send (response_text)
		end
	
	do_post (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Process POST request
		local
			response_text: STRING
			service_name, action: STRING
			agent_service: SERVICE_PROXY
			parameters: TUPLE
			result_value: XRPC_VALUE
			failed: BOOLEAN
		do
			if not failed then
				-- reset
				call := Void
				response := Void
				fault := Void
				-- process call
				parse_call (req)
				if valid_call then
					-- extract service details
					service_name := call.extract_service_name
					action := call.extract_action
					parameters := call.extract_parameters
					log_hierarchy.category (Xmlrpc_category).info ("Calling: " + call.method_name)
					-- retrieve service and execute call
					if registry.has (service_name) then
						agent_service := registry.get (service_name)
						if agent_service.has (action) then
							if agent_service.valid_operands (action, parameters) then
								agent_service.call (action, parameters)
								if agent_service.process_ok then
									-- check for a result, if so pack it up to send back
									if agent_service.last_result /= Void then
										result_value := Value_factory.build (agent_service.last_result)
										if result_value /= Void then
											create response.make (create {XRPC_PARAM}.make (result_value))
											response_text := response.marshall	
										else
											-- construct fault response for invalid return type
											create fault.make (Invalid_action_return_type)
											response_text := fault.marshall
										end
									else
										create response.make (Void)
										response_text := response.marshall	
									end
								else
									-- construct fault response for failed call
									create fault.make_with_detail (Unable_to_execute_service_action, " " + call.method_name)
									response_text := fault.marshall
								end	
							else
								-- construct fault response for invalid action operands
								create fault.make_with_detail (Invalid_operands_for_service_action, " " + call.method_name)
								response_text := fault.marshall
							end
						else
							-- construct fault response for invalid service action
							create fault.make_with_detail (Action_not_found_for_service, " " + call.method_name)
							response_text := fault.marshall
						end
					else
						-- construct fault response for invalid service
						create fault.make_with_detail (Service_not_found, " " + service_name)
						response_text := fault.marshall
					end	
				else
					response_text := fault.marshall
				end
			end
			-- send response
			resp.set_content_type (Headerval_content_type)
			resp.set_content_length (response_text.count)
			resp.send (response_text)
			-- check result and log if there was a failure
			if fault /= Void then
				log_hierarchy.category (Xmlrpc_category).error ("Call failed: " + fault.string)
			end
		rescue
			if not failed then
				-- check for an assertion failure and respond with an appropriate fault
				-- otherwise fail as normal
				if assertion_violation then
					build_assertion_fault
					response_text := fault.marshall
					failed := True
					retry
				end
			end
		end

feature {NONE} -- Implementation
	
	valid_call: BOOLEAN
			-- Flag indicating whether the request contains a valid
			-- XMLRPC call.
			
	parse_call (req: HTTP_SERVLET_REQUEST) is
			-- Parse XMLRPC call from request data. Will set 'valid_call' 
			-- if the request contained a valid XMLRPC call. If an error is
			-- detected then an XRPC_FAULT element will be created that represents
			-- the problem encountered.
		local
			parser_factory: expanded XM_PARSER_FACTORY
			parser: XM_TREE_PARSER
		do
			valid_call := True
			parser := parser_factory.new_toe_eiffel_tree_parser
			parser.parse_from_string (req.content)
			if parser.is_correct then
				create call.unmarshall (parser.document.root_element)
				if not call.unmarshall_ok then
					valid_call := False
					create fault.make (call.unmarshall_error_code)
					call := Void
				end
			else
				valid_call := False
				-- create fault
				create fault.make (Bad_payload_fault_code)
				call := Void
			end	
		ensure
			fault_exists_if_invalid: not valid_call implies fault /= Void
		end

	call: XRPC_CALL
			-- Received call
			
	response: XRPC_RESPONSE
			-- Response to send to client. Void if a fault occurred.
			
	fault: XRPC_FAULT
			-- Fault to send to client. Void if a valid response was generated.

	build_assertion_fault is
			-- Initialise 'fault' to explain current assertion violation
		require
			assertion_violation: assertion_violation
		local
			detail: STRING
		do
			create detail.make (100)
			detail.append (": ")
			detail.append (meaning (exception))
			detail.append (" class: '")
			detail.append (class_name)
			detail.append ("' routine: '")
			detail.append (recipient_name)
			detail.append ("' tag: '")
			detail.append (tag_name)
			detail.append_character ('%'')
			create fault.make_with_detail (Assertion_failure, detail)
		ensure
			fault_initialised: fault /= Void and then fault.code = Assertion_failure
		end
		
end -- class XMLRPC_SERVLET
