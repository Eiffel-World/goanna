indexing
	description: "Abstract notion of a FastCGI record body"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI protocol"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	FAST_CGI_RECORD_BODY

inherit

-- NOTE: the following export modification clauses are commented out because
-- the SmallEiffel compiler doesn't correctly compile them. Once SmallEiffel
-- catches up with the language definition, they need uncommenting.

	FAST_CGI_DEFS
		export
			{NONE} all
		end

--	SOCKET_ERRORS
--		export
--			{NONE} all
--		end

	YAES_HELPER
		export
			{NONE} all
		end
		
	UT_STRING_FORMATTER
--		export
--			{NONE} all
--		end
	
	STRING_MANIPULATION
		export
			{NONE} all
		end
			
feature -- Initialization

	read (header: FAST_CGI_RECORD_HEADER; socket: ABSTRACT_TCP_SOCKET) is
			-- Construct this request record body from the data provided in header
		require
			header_exists: header /= Void
			socket_exists: socket /= Void
--			valid_socket: socket.is_valid
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
	
end -- class FAST_CGI_RECORD_BODY
