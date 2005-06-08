indexing
	description: "Objects that represent a FastCGI end request record body"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI protocol"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_FAST_CGI_END_REQUEST_BODY

inherit GOA_FAST_CGI_RECORD_BODY

	BIT_MANIPULATION
		export
			{NONE} all
		end
		
create
	read, make
	
feature -- Initialisation

	make (new_app_status, new_protocol_status: INTEGER)is
			-- Create a new end request body.
		require
			-- valid_app_status: valid_app_status (new_app_status)
			-- valid_protocol_status: valid_protocol_status (new_protocol_status)
		do
			app_status := new_app_status
			protocol_status := new_protocol_status
		end
	
feature -- Access

	app_status, protocol_status: INTEGER
	
feature -- Basic operations

	write (socket: ABSTRACT_TCP_SOCKET) is
			-- Write this body to 'socket'
		require
			socket_exists: socket /= Void
			valid_socket: socket.is_open
		local
			enc_data: STRING
		do
--			io.put_string ("FAST_CGI_END_REQUEST_BODY.app_status: " + app_status.out + "%N")
--			io.put_string ("FAST_CGI_END_REQUEST_BODY.protocol_status: " + protocol_status.out + "%N")
			enc_data := create_blank_buffer (Fcgi_end_req_body_len)
			enc_data.put (code_to_string (bit_and (bit_shift_right (app_status, 24), 255)).item (1), 1)
			enc_data.put (code_to_string (bit_and (bit_shift_right (app_status, 16), 255)).item (1), 2)
			enc_data.put (code_to_string (bit_and (bit_shift_right (app_status, 8), 255)).item (1), 3)
			enc_data.put (code_to_string (bit_and (app_status, 255)).item (1), 4)
			enc_data.put (code_to_string (protocol_status).item (1), 5)
--			io.put_string ("Bytes to send: " + enc_data.count.out + "%N")
--			io.put_string (generator +  "bytes to sent: " + socket.last_written.out + "%N")
			socket.put_string (enc_data)
--			io.put_string ("Bytes to send: " + enc_data.count.out + "%N")
--			io.put_string (generator +  "bytes to sent: " + socket.last_written.out + "%N")
--			io.put_string (generator + ".write: " + quoted_eiffel_string_out (enc_data) + "%R%N")
--			io.put_string ("Bytes Sent: " + socket.bytes_sent.out + "%N")	
			debug("fcgi_protocol")
				print (generator + ".write: " + quoted_eiffel_string_out (enc_data) + "%R%N")
			end
		end
	
feature {NONE} -- Implementation

	process_body_fields is
			-- Extract body fields from raw content data.
		do
--			app_status := raw_param_content.item (1).code.bit_shift_left (24)
--				+ raw_param_content.item (2).code.bit_shift_left (16)
--				+ raw_param_content.item (3).code.bit_shift_left (8)
--				+ raw_param_content.item (4).code
--			protocol_status := raw_content_data.item (5).code
			-- 3 reserved bytes also read. Ignore them.
		end
		
end -- class GOA_FAST_CGI_END_REQUEST_BODY
