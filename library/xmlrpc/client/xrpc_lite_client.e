indexing
	description: "XML RPC/Messaging Client"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XML-RPC"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class

	XRPC_LITE_CLIENT

inherit
	
	XRPC_CONSTANTS
		export
			{NONE} all
		end
		
	SOCKET_ERRORS
		export
			{NONE} all
		end
		
creation

	make

feature -- Initialisation

	make (connect_host: STRING; connect_port: INTEGER; connect_uri: STRING) is
			-- Initialise XML-RPC client that will send calls using 'connect_uri' to
			-- the server listening on 'connect_host:connect_port'
		require
			connect_host_exists: connect_host /= Void
			valid_port: connect_port > 0
			connect_uri_exists: connect_uri /= Void
		do
			host := connect_host
			port := connect_port
			uri := connect_uri
		end

feature -- Basic routines

	invoke (call: XRPC_CALL) is
			-- Send 'call' to server to be executed. Make 'invocation_ok' True if call is 
			-- successful and make result available in 'response'. Make 'invocation_ok' False 
			-- if the call failed and make the fault
			-- available in 'fault'.
		require
			call_exists: call /= Void
		do
			send_call (call)
			receive_response
		ensure
			response_available: invocation_ok implies (response /= Void and fault = Void)
			fault_available: not invocation_ok implies (response = Void and fault /= Void)
		end
		
	invocation_ok: BOOLEAN
			-- Was the last call successful?
			
	response: XRPC_RESPONSE
			-- Last call response. Only available if 'invocation_ok'.
			
	fault: XRPC_FAULT
			-- Last fault. Only available if not 'invocation_ok'.
	
feature {NONE} -- Implementation

	host: STRING
			-- Server host name
			
	port: INTEGER
			-- Server port
			
	uri: STRING
			-- Server XMLRPC uri
			
	socket: TCP_SOCKET
	
	send_call (call: XRPC_CALL) is
			-- Send 'call' over the wire
		require
			call_exists: call /= Void
		local
			data: STRING
			call_data: STRING
		do
			if socket = Void or else not socket.is_valid then
				connect
			end
			call_data := call.marshall
			create data.make (2048)
			data.append ("POST ")
			data.append (uri)
			data.append (" HTTP/1.0%R%N")
			data.append ("User-Agent: Goanna XML-RPC Client%R%N")
			data.append ("Host: ")
			data.append (socket.peer_name)
			data.append ("%R%N")
			data.append ("Content-Type: text/xml%R%N")
			data.append ("Content-Length: ")
			data.append (call_data.count.out)
			data.append ("%R%N%R%N")
			data.append (call_data)
			socket.send_string (data)
		end
		
	connect is
			-- Open socket connected to service
		do
			create socket.make_connecting_to_port (host, port)
		ensure
			socket_ready: socket.is_valid
		end
		
	receive_response is
			-- Recieve response from server and determine type
		local
			buffer: STRING
			response_string: STRING
			done: BOOLEAN
		do
			create response_string.make (8192)
			if socket = Void or else not socket.is_valid then
				connect
			end
			-- read until complete response has been read 
			content_length_found := False
			content_length := -1
			end_header_index := -1
			content := Void
			from
				create buffer.make (8192)
				buffer.fill_blank
				socket.receive_string (buffer)
				check_socket_error ("after priming read")
			until
				done
			loop
				response_string.append (buffer.substring (1, socket.bytes_received))
				done := check_response (response_string)
				if not done then
					buffer.fill_blank
					socket.receive_string (buffer)
					check_socket_error ("after loop read")					
				end
			end
			debug ("xmlrpc_socket")
				print (response_string)
				print ("%N")
			end
			-- determine response type
			process_response
		end

	content_length_found: BOOLEAN
	content_length, end_header_index: INTEGER
	content: STRING
	
	check_response (buffer: STRING): BOOLEAN is
			-- Check response to determine if all headers and body has been read
		require
			buffer /= Void
		local
			content_length_index: INTEGER
			tokenizer: DC_STRING_TOKENIZER
			next_token: STRING
		do
			if not content_length_found then
				-- check for "%R%N%R%N" for all headers read.
				end_header_index := buffer.substring_index ("%R%N%R%N", 1)
				if end_header_index /= 0 then
					end_header_index := end_header_index + 4
					-- find content length header
					create tokenizer.make (buffer, "%R%N")
					from
						tokenizer.start
					until
						tokenizer.off or content_length_found
					loop
						next_token := tokenizer.item
						next_token.to_lower
						content_length_index := next_token.substring_index ("content-length:", 1)
						if content_length_index /= 0 then
							content_length_found := True
							content_length := next_token.substring (16, next_token.count).to_integer
						end
						tokenizer.forth
					end
				end
			else
				-- have enough bytes for the body been read?
				Result := buffer.count = end_header_index + content_length - 1
				if Result then
					content := buffer.substring (end_header_index, buffer.count)
				end
			end	
		end
		
	check_socket_error (message: STRING) is
			-- Check for socket error and print
		require
			message_exists: message /= Void
		do
			debug ("xmlrpc_socket")
				print ("Socket status (" + message + "):%N")
				print ("%TBytes received: " + socket.bytes_received.out + "%N")
				print ("%TBytes sent: " + socket.bytes_sent.out + "%N")
				print ("%TBytes available: " + socket.bytes_available.out + "%N")
				print ("%TSocket valid: " + socket.is_valid.out + "%N")
			end
			if socket.last_error_code /= Sock_err_no_error then
				print ("Socket error: " + socket.last_error_code.out + "%N")
				print ("Extended error: " + socket.last_extended_socket_error_code.out + "%N")
			end
		end
		
	process_response is
			-- Parse response and determine if it is a response or fault. Store in 
			-- appropriate attribute and set 'invokation_ok' flag.
		require
			content_exists: content /= Void
		local
			parser: DOM_TREE_BUILDER
			child: DOM_ELEMENT
		do
			invocation_ok := True
			create parser.make
			parser.parse_from_string (content)
			if parser.is_correct then
				debug ("xlmrpc")
					print (serialize_dom_tree (parser.document))
					print ("%N")
				end
				-- peek at response elements to determine if it is a fault or not
				child ?= parser.document.document_element.first_child
				if child /= Void and then child.node_name.is_equal (Fault_element) then
					create fault.unmarshall (parser.document.document_element)
					if not fault.unmarshall_ok then		
						-- create fault
						create fault.make (fault.unmarshall_error_code)
						response := Void
					end
					invocation_ok := False
				else
					create response.unmarshall (parser.document.document_element)
					if not response.unmarshall_ok then
						-- create fault
						invocation_ok := False
						create fault.make (response.unmarshall_error_code)
						response := Void
					end
				end
			else
				invocation_ok := False
				response := Void
				-- create fault
				create fault.make (Bad_payload_fault_code)
			end	
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
		
end -- XRPC_LITE_CLIENT
