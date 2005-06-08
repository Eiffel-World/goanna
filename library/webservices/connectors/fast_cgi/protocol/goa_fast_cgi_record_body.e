indexing
	description: "Abstract notion of a FastCGI record body"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI protocol"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum v2 (see forum.txt)."

deferred class GOA_FAST_CGI_RECORD_BODY

inherit

	GOA_FAST_CGI_DEFS
		export
			{NONE} all
		end

	UC_UNICODE_ROUTINES
	
	UT_STRING_FORMATTER
		export
			{NONE} all
		end
	
	GOA_STRING_MANIPULATION
		export
			{NONE} all
		end
			
feature -- Initialization

	read (header: GOA_FAST_CGI_RECORD_HEADER; socket: ABSTRACT_TCP_SOCKET) is
			-- Construct this request record body from the data provided in header
		require
			header_exists: header /= Void
			socket_exists: socket /= Void
			valid_socket: socket.is_open
		local
			raw_padding: STRING
		do
			read_ok := True
			-- read content data
			if header.content_length > 0 then
				
				socket.read_string (header.content_length)
				raw_content_data := socket.last_string
				if raw_content_data.count = header.content_length then
					process_body_fields
				else
					read_ok := False
				end
			end
			-- read padding data
			if read_ok and header.padding_length > 0 then
				socket.read_string (header.padding_length)
				raw_padding := socket.last_string
			end
		end
	
feature -- Access

	read_ok: BOOLEAN
			-- Was last read operation successful?
			
	raw_content_data: STRING
			-- Content data read from socket.
		
	padding_length: INTEGER
			-- Length of padding to write.
				
feature {NONE} -- Implementation

	process_body_fields is
			-- Extract body fields from raw content data.
		deferred
		end
	
end -- class GOA_FAST_CGI_RECORD_BODY
