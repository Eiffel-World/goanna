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
			do_get, do_post, init
		end
	
	SHARED_SERVICE_REGISTRY
		export
			{NONE} all
		end
	
	XRPC_CONSTANTS
		export
			{NONE} all
		end
		
creation

	init
	
feature -- Initialisation

	init (config: SERVLET_CONFIG) is
			-- Initialise encoding registry
		do
			Precursor (config)
		end
		
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
			parameters: TUPLE [ANY]
			result_value: XRPC_VALUE
		do
			parse_call (req)
			if valid_call then
				-- extract service details
				service_name := call.extract_service_name
				action := call.extract_action
				parameters := call.extract_parameters
				-- retrieve service and execute call
				if registry.has (service_name) then
					agent_service := registry.get (service_name)
					if agent_service.has (action) then
						if agent_service.valid_operands (action, parameters) then
							agent_service.call (action, parameters)
							if agent_service.process_ok then
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
								-- construct fault response for failed call
								create fault.make (Unable_to_execute_service_action)
								response_text := fault.marshall
							end	
						else
							-- construct fault response for invalid service action
							create fault.make (Invalid_operands_for_service_action)
							response_text := fault.marshall
						end
					else
						-- construct fault response for invalid service action
						create fault.make (Action_not_found_for_service)
						response_text := fault.marshall
					end
				else
					-- construct fault response for invalid service
					create fault.make (Service_not_found)
					response_text := fault.marshall
				end		
			else
				response_text := fault.marshall
			end
			-- send response
			resp.set_content_type (Headerval_content_type)
			resp.set_content_length (response_text.count)
			resp.send (response_text)
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
			parser: DOM_TREE_BUILDER
		do
			valid_call := True
			create parser.make
			parser.parse_from_string (req.content)
			if parser.is_correct then
				debug ("xlmrpc")
					print (serialize_dom_tree (parser.document))
					print ("%N")
				end
				create call.unmarshall (parser.document.document_element)
				if not call.unmarshall_ok then
					valid_call := False
					call := Void
					create fault.make (call.unmarshall_error_code)
				end
			else
				valid_call := False
				call := Void
				-- create fault
				create fault.make (Bad_payload_fault_code)
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
	
	serialize_dom_tree (document: DOM_DOCUMENT): STRING is
			-- Display dom tree to standard out.
		require
			document_exists: document /= Void	
		local
			writer: DOM_SERIALIZER
			string_stream: IO_STRING
		do
			create string_stream.make (1024)
			writer := serializer_factory.serializer_for_document (document)
			writer.set_output (string_stream)
			writer.serialize (document)		
			Result := string_stream.to_string
		end
	
	serializer_factory: DOM_SERIALIZER_FACTORY is
		once
			create Result
		end

end -- class XMLRPC_SERVLET
