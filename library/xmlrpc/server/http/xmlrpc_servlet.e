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
		do
			parse_call (req)
--			if valid_call then
				-- process call
--			else
				-- return fault
				create fault.make (999)
				response_text := fault.marshall
--			end
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
	response: XRPC_RESPONSE
	fault: XRPC_FAULT
	
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
		
	test_call: XRPC_CALL is
			-- Build a test response
		local
			value, value2, value3, value4, value5: XRPC_VALUE
			sc: DT_SYSTEM_CLOCK
			array_value: ARRAY [XRPC_VALUE]
			struct_value: DS_HASH_TABLE [XRPC_VALUE, STRING]
			param: XRPC_PARAM
		do
			create array_value.make (1, 3)
			create sc.make
			create {XRPC_SCALAR_VALUE} value.make (sc.date_time_now)			
			array_value.put (value, 1)
			create {XRPC_SCALAR_VALUE} value.make (100)
			array_value.put (value, 2)

			create struct_value.make_default
			create {XRPC_SCALAR_VALUE} value3.make ("this is a test")
			create {XRPC_SCALAR_VALUE} value4.make ("another test")
			struct_value.put (value3, "index1")
			struct_value.put (value4, "index2")
			create {XRPC_STRUCT_VALUE} value5.make (struct_value)
			array_value.put (value5, 3)
			
			create {XRPC_ARRAY_VALUE} value2.make (array_value)
			create param.make (value2)
--			create Result.make (param)
			create Result.make ("methodX")
			Result.add_param (param)
		end
		
end -- class XMLRPC_SERVLET
