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
	
	SOAP_CONSTANTS
		export
			{NONE} all
		end
		
creation

	init
	
feature -- Basic operations

	do_get (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Process GET request
		do			
			resp.set_content_type("text/html");
			resp.send ("<html><head><title>SOAP_SERVLET</title></head>");
			resp.send ("<body><h1>SOAP Servlet</h1>");
			resp.send ("<p>Cannot call using method GET. Call with method POST.");
			resp.send ("</p></body></html>");
		end
	
	do_post (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Process POST request
		local
			service_name, action: STRING
			response: STRING
			ref: INTEGER_REF
			agent_service: SERVICE
			parameters: TUPLE [ANY]
			first: DOM_ELEMENT
		do
			debug ("soap")
				print ("SOAP_SERVLET.do_post%R%N")
			end
			-- get SOAP action header
				parse_envelope (req)
				if envelope /= Void then	
					-- extract call information from envelope
					first := envelope.body.entries.first
					service_name := extract_service_name (first)
					action := extract_action_name (first)
					parameters := extract_parameters (first)
					
					-- retrieve service and execute call
					agent_service := registry.get (service_name)
					agent_service.agent_registry.call (action, parameters)
					
					-- process result
					if agent_service.agent_registry.process_ok then
						response := build_response_envelope (agent_service.agent_registry.last_result)
						resp.set_content_length (response.count)
						resp.send (response)
					end
				else
					resp.send_error (Sc_not_implemented)
				end
		end

feature {NONE} -- Implementation

	envelope: SOAP_ENVELOPE
			-- SOAP envelope. Void on unmarshall error.
			
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
				display_dom_tree (parser.document)
				create envelope.unmarshall (parser.document.document_element)
			else
				envelope := Void
			end			
		end
		
	build_response_envelope (last_result: ANY): STRING is
			-- Build response envelope from 'last_result'.
		local
			response_envelope: SOAP_ENVELOPE
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

	extract_service_name (first: DOM_ELEMENT): STRING is
			-- Find the service name in the envelope's first body entry. Void if not found.
		require
			first_exists: first /= Void
		do
			Result := first.namespace_uri.out
		end
		
	extract_action_name (first: DOM_ELEMENT): STRING is
			-- Find the action name in the envelope's first body entry. Void if not found.
		require
			first_exists: first /= Void
		do
			Result := first.local_name.out
		end
	
	extract_parameters (first: DOM_ELEMENT): TUPLE [ANY] is
			-- Unserialize parameters from the envelope body and construct
			-- appropriate argument tuple for the agent call.
		require
			first_exists: first /= Void
		local
			elements: DOM_NODE_LIST
			element: DOM_ELEMENT
			name, type, value: STRING
			i: INTEGER
			q_name: Q_NAME
		do
			create Result.make
			elements := first.child_nodes
			Result.resize (1, elements.length)
			from
				i := 0
			variant
				elements.length - i
			until
				i >= elements.length
			loop
				element ?= elements.item (i)
				check element /= Void end
				name := element.local_name.out
				value := element.first_child.node_value.out
				create q_name.make (Ns_pre_schema_xsi, Attr_type)
				type := element.get_attribute (create {DOM_STRING}.make_from_string (q_name.out)).out
				Result.force (unmarshall_parameter(type, value), i + 1)
				i := i + 1
			end
		end		
	
	unmarshall_parameter (type, value: STRING): ANY is
			-- Unmarshall 'value' according to 'type'.
		require
			type_exists: type /= Void
			value_exists: value /= Void
		local
			double: DOUBLE_REF
		do
			if type.is_equal ("xsd:string") then
				Result := value
			elseif type.is_equal ("xsd:double") then
				create double
				double.set_item (value.to_double)
				Result := double
			end
		end
		
end -- class SOAP_SERVLET
