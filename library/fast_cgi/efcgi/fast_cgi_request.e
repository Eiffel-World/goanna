indexing
	description: "Objects that represent and can read a FastCGI request."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	FAST_CGI_REQUEST

inherit

	FAST_CGI_DEFS
		export
			{NONE} all
		end

	UT_STRING_FORMATTER
		export
			{NONE} all
		end
create
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
		end
	
feature -- Access
	
	failed: BOOLEAN
		-- Did this request fail?
			
	socket: TCP_SOCKET
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
				
	parameters: HASH_TABLE [STRING, STRING]
			-- Table of parameters passed to this request.
	
	raw_stdin_content: STRING
					
feature -- Status setting

	set_socket (new_socket: like socket) is
			-- Set the socket for this request
		require
			socket_exists: new_socket /= Void
			valid_socket: new_socket.is_valid
		do
			socket := new_socket
		end

feature -- Basic operations

	read is
			-- Read a complete request including its begin request, params and stdin records.
			-- Process management records as they are encountered.
			--| Can be called recursively to read parts of a stream.
		local
			record_header: FAST_CGI_RECORD_HEADER	
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
			-- extract stdin
			-- TODO: process stdin data
		end
	
	write_stderr (str: STRING) is
			-- Write 'str' as a stderr record to the socket
		require
			socket_exists: socket /= Void
			valid_socket: socket.is_valid	
		local
			record_header: FAST_CGI_RECORD_HEADER
			record_body: FAST_CGI_RAW_BODY
		do 
			-- send it all in one record. May need to split into smaller records in the
			-- future.
			create record_header.make (version, request_id, Fcgi_stderr, str.count, 0)
			create record_body.make (str, 0)
			record_header.write (socket)
			record_body.write (socket)
			-- end stderr stream record
			create record_header.make (version, request_id, Fcgi_stderr, 0, 0)
			record_header.write (socket)
		end
	
	write_stdout (str: STRING) is
			-- Write 'str' as a stdout record to the socket
		require
			socket_exists: socket /= Void
			valid_socket: socket.is_valid	
		local
			record_header: FAST_CGI_RECORD_HEADER
			record_body: FAST_CGI_RAW_BODY
		do 
			-- send it all in one record. May need to split into smaller records in the
			-- future.
			create record_header.make (version, request_id, Fcgi_stdout, str.count, 0)
			create record_body.make (str, 0)
			record_header.write (socket)
			record_body.write (socket)
			-- end stdout stream record
			create record_header.make (version, request_id, Fcgi_stdout, 0, 0)
			record_header.write (socket)
		end
		
	end_request is
			-- Notify the web server that this request has completed.
		require
			socket_exists: socket /= Void
			valid_socket: socket.is_valid	
		local
			record_header: FAST_CGI_RECORD_HEADER
			record_body: FAST_CGI_END_REQUEST_BODY
		do 
			-- send end request record
			create record_header.make (version, request_id, Fcgi_end_request, 
				Fcgi_end_req_body_len, 0)
			create record_body.make (Fcgi_request_complete, 0)
			record_header.write (socket)
			record_body.write (socket)
		end
	
feature {NONE} -- Implementation

	stdin_records_done, param_records_done: BOOLEAN
			-- Have all stdin and param records been read?
	
	raw_param_content: STRING	
			-- Buffers to hold raw data collected from stream records.
				
	read_header: FAST_CGI_RECORD_HEADER is
			-- Read record header from the socket.
		do
			debug ("fcgi_protocol")
				print (generator + ".read_header%R%N")
			end	
			create Result.read (socket)
			read_ok := Result.read_ok
		end
	
	read_body (record_header: FAST_CGI_RECORD_HEADER) is
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
--			when Fcgi_end_request then
--				create {FAST_CGI_END_REQUEST_BODY} record_body
--			when Fcgi_stdout then
--				create {FAST_CGI_STDOUT_BODY} record_body
--			when Fcgi_stderr then
--				create {FAST_CGI_STDERR_BODY} record_body
--			when  then
			else
				-- TODO: handle unknown record type
			end
		end
	
	read_begin_request_body (record_header: FAST_CGI_RECORD_HEADER) is
			-- Read body of begin request record and process data.
		local
			record_body: FAST_CGI_BEGIN_REQUEST_BODY
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
		end		
	
	read_param_request_body (record_header: FAST_CGI_RECORD_HEADER) is
			-- Read body of param request record and process data.
		local
			record_body: FAST_CGI_RAW_BODY	
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
					raw_param_content.append (record_body.raw_content_data)	
					debug ("fcgi_protocol")
						print (generator + ".read_param_request_body = ")
						print (quoted_eiffel_string_out (record_body.raw_content_data) + "%R%N")
					end	
				end		
			end
		end
	
	read_stdin_request_body (record_header: FAST_CGI_RECORD_HEADER) is
			-- Read body of stdin request record and process data.
		local
			record_body: FAST_CGI_RAW_BODY
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
					raw_stdin_content.append (record_body.raw_content_data)
					debug ("fcgi_protocol")
						print (generator + ".read_stdin_request_body = ")
						print (quoted_eiffel_string_out (record_body.raw_content_data) + "%R%N")
					end	
				end				
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
				parameters.clear_all
				offset := 1
			until
				offset >= raw_param_content.count
			loop
				-- determine number of bytes in name length, 1 or 4
				short_name := raw_param_content.item (offset).code.bit_shift_right (7) = 0 
				-- build name length
				if short_name then
					name_length := raw_param_content.item (offset).code.bit_and (127)
					offset := offset + 1
				else
					name_length := raw_param_content.item (offset).code.bit_and (127).bit_shift_left (24)
						+ raw_param_content.item (offset + 1).code.bit_shift_left (16)
						+ raw_param_content.item (offset + 2).code.bit_shift_left (8)
						+ raw_param_content.item (offset + 3).code
					offset := offset + 4
				end
				-- determine number of bytes in value length, 1 or 4
				short_value := raw_param_content.item (offset).code.bit_shift_right (7) = 0 
				-- build value length
				if short_value then
					value_length := raw_param_content.item (offset).code.bit_and (127)
					offset := offset + 1
				else
					value_length := raw_param_content.item (offset).code.bit_and (127).bit_shift_left (24)
						+ raw_param_content.item (offset + 1).code.bit_shift_left (16)
						+ raw_param_content.item (offset + 2).code.bit_shift_left (8)
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
				parameters.put (value, name)
				debug ("fcgi_protocol")
					print (generator + ".process_parameter_raw_data: name = " 
						+ quoted_eiffel_string_out (name))
					print (" value = " + quoted_eiffel_string_out (value) + "%R%N")
				end
			end
		end
	
end -- class FAST_CGI_REQUEST
