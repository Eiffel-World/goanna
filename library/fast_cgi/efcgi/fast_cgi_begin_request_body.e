indexing
	description: "Objects that represent a FastCGI begin request record body."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	FAST_CGI_BEGIN_REQUEST_BODY

inherit
	FAST_CGI_RECORD_BODY

feature -- Access

	role, flags: INTEGER
	
feature {NONE} -- Implementation

	process_body_fields is
			-- Extract body fields from raw content data.
		do
			role := raw_content_data.item (1).code.bit_shift_left (8) + raw_content_data.item (2).code
			flags := raw_content_data.item (3).code
			-- 5 reserved bytes also read. Ignore them.
		end
		
end -- class FAST_CGI_BEGIN_REQUEST_BODY
