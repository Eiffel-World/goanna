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
				agent_service.call (action, parameters)
				
				-- process result
				if agent_service.process_ok then
					response := build_response (service_name, action, agent_service.last_result)
					resp.set_content_type (Headerval_content_type)
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
				debug ("soap")
					print (serialize_dom_tree (parser.document))
				end
				create envelope.unmarshall (parser.document.document_element)
			else
				envelope := Void
			end			
		end
		
	build_response (service_name, action: STRING; last_result: ANY): STRING is
			-- Build response for 'action' called on 'service_name' with
			-- the result 'last_result'.
		require
			request_envelope_exists: envelope /= Void
		local
			impl: DOM_IMPLEMENTATION
			doc: DOM_DOCUMENT
			env, body, response, return: DOM_ELEMENT
			value_text: DOM_TEXT
			discard: DOM_NODE
		do
			create {DOM_IMPLEMENTATION_IMPL} impl
			-- create XML document and envelope element with appropriate namespace attributes
			doc := impl.create_document (create {DOM_STRING}.make_from_string (Ns_uri_soap_env), 
				create {DOM_STRING}.make_from_string (Ns_pre_soap_env + ":" + Elem_envelope), Void)
			env := doc.document_element
			env.set_attribute_ns (create {DOM_STRING}.make_from_string (""),
				create {DOM_STRING}.make_from_string (Ns_pre_xmlns + ":" + Ns_pre_soap_env),
				create {DOM_STRING}.make_from_string (Ns_uri_soap_env))
			env.set_attribute_ns (create {DOM_STRING}.make_from_string (""),
				create {DOM_STRING}.make_from_string (Ns_pre_xmlns + ":" + Ns_pre_schema_xsi),
				create {DOM_STRING}.make_from_string (Ns_uri_schema_xsi))
			env.set_attribute_ns (create {DOM_STRING}.make_from_string (""),
				create {DOM_STRING}.make_from_string (Ns_pre_xmlns + ":" + Ns_pre_schema_xsd),
				create {DOM_STRING}.make_from_string (Ns_uri_schema_xsd))
			-- create body element	
			body := doc.create_element_ns (create {DOM_STRING}.make_from_string (Ns_uri_soap_env), 
				create {DOM_STRING}.make_from_string (Ns_pre_soap_env + ":" + Elem_body))
			discard := env.append_child (body)
			-- create response element
			response := doc.create_element_ns (create {DOM_STRING}.make_from_string (service_name), 
				create {DOM_STRING}.make_from_string ("ns1:" + action + "Response"))
			response.set_attribute_ns (create {DOM_STRING}.make_from_string (""),
				create {DOM_STRING}.make_from_string (Ns_pre_xmlns + ":ns1"),
				create {DOM_STRING}.make_from_string (service_name))
			response.set_attribute_ns (create {DOM_STRING}.make_from_string (""),
				create {DOM_STRING}.make_from_string (Ns_pre_soap_env + ":" + Attr_encoding_style),
				create {DOM_STRING}.make_from_string (Ns_uri_soap_enc))		
			discard := body.append_child (response)
			-- create result element
			return := marshall_return_element (doc, last_result)
			discard := response.append_child (return)
			debug ("soap")
				print (serialize_dom_tree (doc))
			end
			Result := serialize_dom_tree (doc)
		end
		
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
		
	marshall_return_element (doc: DOM_DOCUMENT; last_result: ANY): DOM_ELEMENT is
			-- Determine type of 'last_result' and create return element
			-- with appropriate xsi:type and marshalled value.
		require
			doc_exists: doc /= Void
		local
			double_type: DOUBLE_REF
			string_type, value: STRING
			value_node: DOM_TEXT
			discard: DOM_NODE
			type: DOM_ATTR
		do
			-- create return element
			Result := doc.create_element (create {DOM_STRING}.make_from_string ("return"))
			type := doc.create_attribute (create {DOM_STRING}.make_from_string (Ns_pre_schema_xsi + ":" + Attr_type))
			discard := Result.set_attribute_node (type)
			
			-- determine type of last_result and set type and value
			double_type ?= last_result
			if double_type /= Void then
				type.set_node_value (create {DOM_STRING}.make_from_string (Ns_pre_schema_xsd + ":double"))
				value := double_type.out
			else
				-- string type
				type.set_node_value (create {DOM_STRING}.make_from_string (Ns_pre_schema_xsd + ":string"))
				value := last_result.out
			end
			value_node := doc.create_text_node (create {DOM_STRING}.make_from_string (value))
			discard := Result.append_child (value_node)
		end
		
end -- class SOAP_SERVLET
