indexing
	description: "Objects that represent and can read FastCGI record headers from a socket"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI protocol"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	FAST_CGI_RECORD_HEADER

inherit

-- NOTE: the following export modification clauses are commented out because
-- the SmallEiffel compiler doesn't correctly compile them. Once SmallEiffel
-- catches up with the language definition, they need uncommenting.

	FAST_CGI_DEFS
		export
			{NONE} all
		end
		
	SOCKET_ERRORS
		export
			{NONE} all
		end

	YAES_HELPER
		export
			{NONE} all
		end
		
	UT_STRING_FORMATTER
		export
			{NONE} all
		end
		
	BIT_MANIPULATION
--		export
--			{NONE} all
--		end
	
	STRING_MANIPULATION
		export
			{NONE} all
		end
			
creation

	make, read
	
feature -- Initialization

	make (new_version, new_request_id, new_type, new_content_length, new_padding_length: INTEGER) is
			-- Create a new record header for the specified request.	
		require
			valid_version: new_version >= 1
			valid_request_id: new_request_id >= 0
			-- valid_type: valid_type (new_type)
			valid_content_length: new_content_length >= 0
			valid_padding_length: new_padding_length >= 0
		do
			version := new_version
			request_id := new_request_id
			type := new_type
			content_length := new_content_length
			padding_length := new_padding_length
		end

feature -- Access

	version, request_id, type, content_length, padding_length: INTEGER
	
	read_ok: BOOLEAN
	
	write_ok: BOOLEAN
	
feature -- Basic operations

	read (socket: TCP_SOCKET) is
			-- Read header data from 'socket'
		local
			buffer: STRING
		do
			buffer := create_blank_buffer (Fcgi_header_len)
			socket.receive_string (buffer)
			if socket.last_error_code = Sock_err_no_error then
				process_header_bytes (buffer)
				read_ok := True
			else
				read_ok := False
			end
		end
	
	write (socket: TCP_SOCKET) is
			-- Write this header to 'socket'
		require
			socket_exists: socket /= Void
			valid_socket: socket.is_valid
		local
			enc_data: STRING
		do
			enc_data := create_blank_buffer (Fcgi_header_len)
			enc_data.put (character_from_code (version), 1)
			enc_data.put (character_from_code (type), 2)
			enc_data.put (character_from_code (bit_and (bit_shift_right (request_id, 8), 255)), 3)
			enc_data.put (character_from_code (bit_and (request_id, 255)), 4)
			enc_data.put (character_from_code (bit_and (bit_shift_right (content_length, 8), 255)), 5)
			enc_data.put (character_from_code (bit_and (content_length, 255)), 6)
			enc_data.put (character_from_code (padding_length), 7)
			enc_data.put ('%/0/', 8) -- reserved byte
			socket.send_string (enc_data)
			write_ok := socket.last_error_code = Sock_err_no_error
			debug("fcgi_protocol")
				print (generator + ".write: " + quoted_eiffel_string_out (enc_data) + "%R%N")
			end
		end
	
feature {NONE} -- Implementation

	process_header_bytes (buffer: STRING) is
			-- Extract the header data from 'buffer'
		require
			buffer_exists: buffer /= Void
			enough_header_bytes: buffer.count = Fcgi_header_len
		do
			version := buffer.item (1).code
			type := buffer.item (2).code
			-- request id in two bytes
			request_id := bit_shift_left (buffer.item (3).code, 8) + buffer.item (4).code
			-- content length in two bytes
			content_length := bit_shift_left (buffer.item (5).code, 8) + buffer.item (6).code
			padding_length := buffer.item (7).code
			-- reserved byte is also read but ignored
		end
		
end -- class FAST_CGI_RECORD_HEADER
