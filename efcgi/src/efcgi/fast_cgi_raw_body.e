indexing
	description: "Objects that represent a FastCGI begin raw record body such as stdin or params."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	FAST_CGI_RAW_BODY

inherit
	FAST_CGI_RECORD_BODY
	
	UT_STRING_FORMATTER
		export
			{NONE} all
		end
		
create

	make, read
	
feature -- Initialization

	make (new_data: STRING; padding: INTEGER) is
			-- Create a new raw record body with 'new_data' as the content data and
			-- 'padding' characters as padding.
		require
			new_data_exists: new_data /= Void
			positive_padding: padding >= 0	
		do
			raw_content_data := new_data
			padding_length := padding
		end
	
feature -- Basic operations

	write (socket: TCP_SOCKET) is
			-- Write this raw data body to 'socket'
		require
			socket_exists: socket /= Void
			valid_socket: socket.is_valid
		local
			enc_data: STRING
		do
			create enc_data.make (raw_content_data.count + padding_length)
			enc_data.fill_blank
			enc_data.append (raw_content_data)
			socket.send_string (enc_data)
			debug("fcgi_protocol")
				print (generator + ".write: " + quoted_eiffel_string_out (enc_data) + "%R%N")
			end
		end
		
feature {NONE} -- Implementation

	process_body_fields is
			-- Extract body fields from raw content data.
		do
			-- no processing required. Access via raw_content_data.
		end
		
end -- class FAST_CGI_RAW_BODY
