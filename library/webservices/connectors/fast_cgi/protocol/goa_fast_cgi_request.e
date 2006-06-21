indexing
	description: "Objects that represent and can read a FastCGI request"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI protocol"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	GOA_FAST_CGI_REQUEST

inherit

	GOA_FAST_CGI_DEFS
		export
			{NONE} all
		end

	UT_STRING_FORMATTER
		export
			{NONE} all
		end

	KL_IMPORTED_INTEGER_ROUTINES
	
	POSIX_CONSTANTS

creation
	make

feature -- Initialization

	make is
			-- Clear all request fields	
		do
			socket := Void
			read_ok := False
			write_ok := False
			app_status := 0
			num_writers := 0
			failed := False
			create parameters.make (20)
--			io.put_string ("============================================  Request Created%N")
		end
	
feature -- Access
	
	failed: BOOLEAN
		-- Did this request fail?
			
	socket: ABSTRACT_TCP_SOCKET
		-- The request communication socket
				
	read_ok: BOOLEAN 
		-- Was the last read operation successful?
		
	write_ok: BOOLEAN
		-- Was the last write operation successful?
		
	request_id: INTEGER
		-- Request id. Zero for management request.
	
	keep_connection: BOOLEAN
			
	role: INTEGER
	
	flags: INTEGER
	
	version: INTEGER
	
	type: INTEGER
	
	content_length: INTEGER
	
	padding_length: INTEGER
		
	app_status: INTEGER
			-- Application status
		
	num_writers: INTEGER
			-- Number of writers
				
	parameters: DS_HASH_TABLE [STRING, STRING]
			-- Table of parameters passed to this request.
	
	raw_stdin_content: STRING
	
	broken_pipe: BOOLEAN is
			-- Was the last error for the serving socket a broken pipe?
		do
			Result := socket.errno.value = signal_pipe
		end

feature -- Status setting

	set_socket (new_socket: like socket) is
			-- Set the socket for this request.
			-- Can be set to Void to invalidate the request.
		require
			valid_socket: new_socket /= Void implies new_socket.is_open
		do
			socket := new_socket
		end

feature -- Basic operations

	read is
			-- Read a complete request including its begin request, params and stdin records.
			-- Process management records as they are encountered.
			--| Can be called recursively to read parts of a stream.
		local
			record_header: GOA_FAST_CGI_RECORD_HEADER	
		do
			debug ("fcgi_protocol")
				print (generator + ".read%R%N")
			end	
			from
				read_ok := True
				stdin_records_done := False
				param_records_done := False
			until
				not read_ok or (stdin_records_done and param_records_done)
			loop				
				-- read begin request record. It may be a management record, if so, process it.
				record_header := read_header
				if read_ok then
					read_body (record_header)
				end
			end
			-- extract parameters
			process_parameter_raw_data
			debug ("fcgi_protocol")
				print (generator + ".read - finished.%R%N")
			end
		end
	
	write_stderr (str: STRING) is
			-- Write 'str' as a stderr record to the socket
		require
			socket_exists: socket /= Void
			valid_socket: socket.is_open
		local
			record_header: GOA_FAST_CGI_RECORD_HEADER
			record_body: GOA_FAST_CGI_RAW_BODY
			offset, bytes_to_send: INTEGER
		do
			debug ("fcgi_protocol")
				print (generator + ".write_stderr%R%N")
			end
			-- split into chunks 65535 bytes or less.
			from
				offset := 1
			until
				offset > str.count
			loop
				bytes_to_send := (65535).min (str.count - (offset - 1))
				-- create and send stderr stream record
				create record_header.make (version, request_id, Fcgi_stderr, bytes_to_send, 0)
				create record_body.make (str.substring (offset, offset + bytes_to_send - 1), 0)
				record_header.write (socket)
				record_body.write (socket)
				offset := offset + 65535
			end
			-- end stderr stream record
			create record_header.make (version, request_id, Fcgi_stderr, 0, 0)
			record_header.write (socket)
			debug ("fcgi_protocol")
				print (generator + ".write_stderr - finished%R%N")
			end			
		end
	
	write_stdout (str: STRING) is
			-- Write 'str' as a stdout record to the socket
		require
			socket_exists: socket /= Void
			valid_socket: socket.is_open
		local
			record_header: GOA_FAST_CGI_RECORD_HEADER
			record_body: GOA_FAST_CGI_RAW_BODY
			offset, bytes_to_send: INTEGER
			body_string: STRING
--			now: DATE_TIME
		do
--			io.put_string ("FAST_CGI_REQUEST.write_stdout Starting...%N")
--			io.put_string ("Data Length: " + str.count.out + "%N")
			debug ("fcgi_protocol")
				print (generator + ".write_stdout%R%N")
			end
			-- split into chunks 65535 bytes or less.
			from
				offset := 1
			until
				offset > str.count
			loop
				bytes_to_send := (65535).min (str.count - (offset - 1))
--				io.put_string (generator + "Bytes to send: " + bytes_to_send.out + "%N")
				-- create and send stdout stream record
				
				create record_header.make (version, request_id, Fcgi_stdout, bytes_to_send, 0)
				debug ("fcgi_protocol")
					body_string := str.substring (offset, offset + bytes_to_send - 1)
					print ("Bytes_to_send: " + bytes_to_send.out + "; body_string_length: " + body_string.count.out + "%R%N")
					print ("body_string: " + body_string + "%R%N")
				end
				create record_body.make (str.substring (offset, offset + bytes_to_send - 1), 0)
--				io.put_string ("FAST_CGI_REQUEST.write_stdout Sending Header...%N")
				record_header.write (socket)
--				io.put_string ("FAST_CGI_REQUEST.write_stdout Sending Body...%N")
				record_body.write (socket)
				offset := offset + 65535
			end
			-- end stdout stream record
			create record_header.make (version, request_id, Fcgi_stdout, 0, 0)
--			io.put_string ("FAST_CGI_REQUEST.write_stdout Sending End of Request Header...%N")
			record_header.write (socket)
			debug ("fcgi_protocol")
				print (generator + ".write_stdout - finished%R%N")
			end
--			io.put_string ("FAST_CGI_REQUEST.write_stdout finished.%N")
--			create now.make_now
--			io.put_string ("Finished {FAST_CGI_REQUEST}.write_std_out: " + now.out + "%N")
		end
		
	end_request is
			-- Notify the web server that this request has completed.
		require
			socket_exists: socket /= Void
			valid_socket: socket.is_open
		local
			record_header: GOA_FAST_CGI_RECORD_HEADER
			record_body: GOA_FAST_CGI_END_REQUEST_BODY
		do
--			io.put_string ("FAST_CGI_REQUEST.end_request starting...%N")
			debug ("fcgi_protocol")
				print (generator + ".end_request%R%N")
			end
			-- send end request record
			create record_header.make (version, request_id, Fcgi_end_request, 
				Fcgi_end_req_body_len, 0)
			create record_body.make (Fcgi_request_complete, 0)
			record_header.write (socket)
			record_body.write (socket)
			socket.close
			debug ("fcgi_protocol")
				print (generator + ".end_request - finished%R%N")
			end
--			io.put_string ("FAST_CGI_REQUEST.end_request finished.%N")
		end
	
feature {NONE} -- Implementation

	stdin_records_done, param_records_done: BOOLEAN
			-- Have all stdin and param records been read?
	
	raw_param_content: STRING	
			-- Buffers to hold raw data collected from stream records.
				
	read_header: GOA_FAST_CGI_RECORD_HEADER is
			-- Read record header from the socket.
		do
			debug ("fcgi_protocol")
				print (generator + ".read_header%R%N")
			end	
			create Result.read (socket)
			read_ok := Result.read_ok
			debug ("fcgi_protocol")
				print (generator + ".read_header - finished%R%N")
			end				
		end
	
	read_body (record_header: GOA_FAST_CGI_RECORD_HEADER) is
			-- Read the body of the record depending on the type of the
			-- record
		require
			record_header_exists: record_header /= Void
		do
			debug ("fcgi_protocol")
				print (generator + ".read_body%R%N")
			end	
			inspect
				record_header.type
			when Fcgi_begin_request then
				read_begin_request_body (record_header)
			when Fcgi_params then
				read_param_request_body (record_header)
			when Fcgi_stdin then
				read_stdin_request_body (record_header)
--			when Fcgi_abort_request then
--				create {FAST_CGI_ABORT_REQUEST_BODY} record_body
			else
				-- TODO: handle unknown record type
				debug ("fcgi_protocol")
					print (generator + ".read_body - unknown record type%R%N")
				end	
			end
			debug ("fcgi_protocol")
				print (generator + ".read_body - finished%R%N")
			end				
		end
	
	read_begin_request_body (record_header: GOA_FAST_CGI_RECORD_HEADER) is
			-- Read body of begin request record and process data.
		local
			record_body: GOA_FAST_CGI_BEGIN_REQUEST_BODY
		do
			debug ("fcgi_protocol")
				print (generator + ".read_begin_request_body%R%N")
			end	
			-- read body
			create record_body
			record_body.read (record_header, socket)
			read_ok := record_body.read_ok
			if read_ok then
				-- store header elements
				request_id := record_header.request_id
				version := record_header.version
				type := record_header.type
				content_length := record_header.content_length
				padding_length := record_header.padding_length
				-- store body elements
				role := record_body.role
				flags := record_body.flags
			end
			debug ("fcgi_protocol")
				print (generator + ".read_begin_request_body - finished%R%N")
			end				
		end		
	
	read_param_request_body (record_header: GOA_FAST_CGI_RECORD_HEADER) is
			-- Read body of param request record and process data.
		local
			record_body: GOA_FAST_CGI_RAW_BODY	
		do
			debug ("fcgi_protocol")
				print (generator + ".read_param_request_body%R%N")
			end	
			-- check if this is an empty param record. If so, flag end of params
			if record_header.content_length = 0 then
				param_records_done := True
			else
				-- read body
				create record_body.read (record_header, socket)
				read_ok := record_body.read_ok
				if read_ok then
					-- store body elements
					if raw_param_content = Void then
						create raw_param_content.make (record_header.content_length)
					end
					raw_param_content.append_string (record_body.raw_content_data)	
					debug ("fcgi_protocol")
						print (generator + ".read_param_request_body = ")
						print (quoted_eiffel_string_out (record_body.raw_content_data) + "%R%N")
					end	
				end		
			end
			debug ("fcgi_protocol")
				print (generator + ".read_param_request_body - finished%R%N")
			end
		end
	
	read_stdin_request_body (record_header: GOA_FAST_CGI_RECORD_HEADER) is
			-- Read body of stdin request record and process data.
		local
			record_body: GOA_FAST_CGI_RAW_BODY
		do
			debug ("fcgi_protocol")
				print (generator + ".read_stdin_request_body%R%N")
			end	
			-- check if this is an empty stdin record. If so, flag end of stdin
			if record_header.content_length = 0 then
				stdin_records_done := True
			else
				-- read body
				create record_body.read (record_header, socket)
				read_ok := record_body.read_ok
				if read_ok then
					if raw_stdin_content = Void then
						create raw_stdin_content.make (record_header.content_length)
					end
					-- store body elements
					raw_stdin_content.append_string (record_body.raw_content_data)
					debug ("fcgi_protocol")
						print (generator + ".read_stdin_request_body = ")
						print (quoted_eiffel_string_out (record_body.raw_content_data) + "%R%N")
					end	
				end				
			end
			debug ("fcgi_protocol")
				print (generator + ".read_stdin_request_body - finished%R%N")
			end			
		end
	
	process_parameter_raw_data is
			-- Extract parameters from 'raw_param_content'
		local
			short_name, short_value: BOOLEAN
			offset: INTEGER
			name_length, value_length: INTEGER
			name, value: STRING
		do
			from
				parameters.wipe_out
				offset := 1
			until
				offset >= raw_param_content.count
			loop
				-- determine number of bytes in name length, 1 or 4
				short_name := INTEGER_.bit_shift_right (raw_param_content.item (offset).code, 7) = 0 
				-- build name length
				if short_name then
					name_length := INTEGER_.bit_and (raw_param_content.item (offset).code, 127)
					offset := offset + 1
				else
					name_length := INTEGER_.bit_shift_left (INTEGER_.bit_and (raw_param_content.item (offset).code, 127), 24)
						+ INTEGER_.bit_shift_left (raw_param_content.item (offset + 1).code, 16)
						+ INTEGER_.bit_shift_left (raw_param_content.item (offset + 2).code, 8)
						+ raw_param_content.item (offset + 3).code
					offset := offset + 4
				end
				-- determine number of bytes in value length, 1 or 4
				short_value := INTEGER_.bit_shift_right (raw_param_content.item (offset).code, 7) = 0 
				-- build value length
				if short_value then
					value_length := INTEGER_.bit_and (raw_param_content.item (offset).code, 127)
					offset := offset + 1
				else
					value_length := INTEGER_.bit_shift_left (INTEGER_.bit_and (raw_param_content.item (offset).code, 127), 24)
						+ INTEGER_.bit_shift_left (raw_param_content.item (offset + 1).code, 16)
						+ INTEGER_.bit_shift_left (raw_param_content.item (offset + 2).code, 8)
						+ raw_param_content.item (offset + 3).code
					offset := offset + 4
				end
				-- build name
				name := raw_param_content.substring (offset, offset + name_length - 1)
				offset := offset + name_length
				-- build value
				value := raw_param_content.substring (offset, offset + value_length - 1)
				offset := offset + value_length
				-- store parameter
				parameters.force (value, name)
				debug ("fcgi_protocol")
					print (generator + ".process_parameter_raw_data: name = " 
						+ quoted_eiffel_string_out (name))
					print (" value = " + quoted_eiffel_string_out (value) + "%R%N")
				end
			end
			debug ("fcgi_protocol")
				print (generator + ".process_parameter_raw_data: Finished") 
			end
		end
	
end -- class GOA_FAST_CGI_REQUEST
