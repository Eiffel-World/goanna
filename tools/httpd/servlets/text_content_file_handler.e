indexing
	description: "Text content file handler"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	TEXT_CONTENT_FILE_HANDLER

inherit
	CONTENT_FILE_HANDLER

feature -- Basic operations

	service (file_name: STRING; content_type_code: INTEGER;
		req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Service the file request for the specified 'file_name' and
			-- 'content_type_code'. Send the file to 'resp'.
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make (file_name)
			file.open_read
			-- setup response
			resp.set_content_type (content_types.item (content_type_code))
			resp.set_content_length (file.count)
			resp.set_status (Sc_ok)
			-- write file data to response
			from
				buffer.wipe_out
			until
				file.end_of_file
			loop
				file.read_stream (Max_line_length)
				resp.send (file.last_string)
			end
			file.close
		end
		
feature {NONE} -- Implementation

	Max_line_length : INTEGER is 1024

end -- class TEXT_CONTENT_FILE_HANDLER
