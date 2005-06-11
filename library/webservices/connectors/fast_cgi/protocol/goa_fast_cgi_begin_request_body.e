indexing
	description: "Objects that represent a FastCGI begin request record body"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI protocol"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_FAST_CGI_BEGIN_REQUEST_BODY

inherit

	GOA_FAST_CGI_RECORD_BODY
		
	KL_IMPORTED_INTEGER_ROUTINES
			
feature -- Access

	role, flags: INTEGER
	
feature {NONE} -- Implementation

	process_body_fields is
			-- Extract body fields from raw content data.
		do
			role := INTEGER_.bit_shift_left (raw_content_data.item (1).code, 8) 
				+ raw_content_data.item (2).code
			flags := raw_content_data.item (3).code
			-- 5 reserved bytes also read. Ignore them.
		end
		
end -- class GOA_FAST_CGI_BEGIN_REQUEST_BODY
