indexing
	description: "Objects that represent a FastCGI end request record body"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI protocol"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	FAST_CGI_END_REQUEST_BODY

inherit
	FAST_CGI_RECORD_BODY

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

	write (socket: TCP_SOCKET) is
			-- Write this body to 'socket'
		require
			socket_exists: socket /= Void
			valid_socket: socket.is_valid
		local
			enc_data: STRING
		do
			create enc_data.make (Fcgi_end_req_body_len)
			enc_data.fill_blank
			enc_data.put (character_from_code (app_status.bit_shift_right (24).bit_and (255)), 1)
			enc_data.put (character_from_code (app_status.bit_shift_right (16).bit_and (255)), 2)
			enc_data.put (character_from_code (app_status.bit_shift_right (8).bit_and (255)), 3)
			enc_data.put (character_from_code (app_status.bit_and (255)), 4)
			enc_data.put (character_from_code (protocol_status), 5)
			socket.send_string (enc_data)
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
		
end -- class FAST_CGI_END_REQUEST_BODY
