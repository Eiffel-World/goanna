indexing
	description: "Objects that represent a FastCGI begin request record body"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI protocol"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	FAST_CGI_BEGIN_REQUEST_BODY

inherit
	FAST_CGI_RECORD_BODY
		
	BIT_MANIPULATION
		export
			{NONE} all
		end
		
feature -- Access

	role, flags: INTEGER
	
feature {NONE} -- Implementation

	process_body_fields is
			-- Extract body fields from raw content data.
		do
			role := bit_shift_left (raw_content_data.item (1).code, 8) 
				+ raw_content_data.item (2).code
			flags := raw_content_data.item (3).code
			-- 5 reserved bytes also read. Ignore them.
		end
		
end -- class FAST_CGI_BEGIN_REQUEST_BODY
