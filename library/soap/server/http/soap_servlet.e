indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SOAP_SERVLET

inherit

	HTTP_SERVLET
		redefine
			do_get, do_post
		end
	
	SHARED_SERVICE_REGISTRY
		export
			{NONE} all
		end
		
creation

	init
	
feature -- Basic operations

	do_get (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Process GET request
		local
			service_name, action: STRING
			response: STRING
			ref: INTEGER_REF
			agent_service: SERVICE
		do
			debug ("soap")
				print ("SOAP_SERVLET.do_get%R%N")
			end
			-- get SOAP action header
--			if req.has_parameter (Soap_action) then		
--				service_name := req.get_parameter (Soap_service)
--				action := req.get_parameter (Soap_action)
--				debug ("soap")
--					print ("SOAP_SERVLET.do_get service=" + service_name + "%R%N")
--				end
				parse_envelope (req)
				if request_doc /= Void then
					response := build_response_envelope ("Test result")
					resp.set_content_length (response.count)
					resp.send (response)
				else
					resp.send_error (Sc_not_implemented)
				end
--				agent_service := registry.get (service_name)
--				create ref
--				ref.set_item (1000)
--				agent_service.agent_registry.call (action, [ref])
--				if agent_service.agent_registry.process_ok then
--					response := build_response_envelope (agent_service.agent_registry.last_result)
--					resp.set_content_length (response.count)
--					resp.send (response)
--				end
--			else
--				resp.send_error (Sc_not_found)
--			end
		end
	
	do_post (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Process GET request
		do
			do_get (req, resp)
		end

feature {NONE} -- Implementation

	request_doc: DOM_DOCUMENT
			-- SOAP Envelope. Void on parse error.
			
	Soap_service: STRING is "service"
	Soap_action: STRING is "action"
	
	parse_envelope (req: HTTP_SERVLET_REQUEST) is
			-- Parse SOAP envelope from request data
		local
			parser: DOM_TREE_BUILDER
		do
			create parser.make
			parser.parse_from_string (req.content)
			if parser.is_correct then
				request_doc := parser.document
				display_dom_tree (request_doc)
			else
				request_doc := Void
			end			
		end
		
	build_response_envelope (last_result: ANY): STRING is
			-- Build response envelope from 'last_result'.
		local
			envelope: SOAP_ENVELOPE
		do
			Result := last_result.out
		end
		
	display_dom_tree (document: DOM_DOCUMENT) is
			-- Display dom tree to standard out.
		require
			document_exists: document /= Void	
		local
			writer: DOM_SERIALIZER
		do
			writer := serializer_factory.serializer_for_document (document)
			writer.set_output (io.output)
			writer.serialize (document)		
		end
	
	serializer_factory: DOM_SERIALIZER_FACTORY is
		once
			create Result
		end

end -- class SOAP_SERVLET
