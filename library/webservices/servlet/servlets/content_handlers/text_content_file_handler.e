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
			--| There is currently no difference between this method and
			--| the equivalent method in BINARY_CONTENT_FILE_HANDLER
		local
			file: KL_TEXT_INPUT_FILE
		do
			create file.make (file_name)
			-- This is really inefficient because the whole file has
			-- to be read into memory. I had to do it this way because 
			-- I couldn't find a portable way to get the file.count to
			-- set the content length earlier
			from
				buffer.wipe_out
			until
				file.end_of_file
			loop
				file.read_string (Max_line_length)
				buffer.append (file.last_string)
			end
			file.close	
			-- setup response
			resp.set_content_type (content_types.item (content_type_code))
			resp.set_content_length (buffer.count)
			resp.set_status (Sc_ok)
			-- write file data to response
			resp.send (buffer)
		end
		
feature {NONE} -- Implementation

	Max_line_length : INTEGER is 1024

end -- class TEXT_CONTENT_FILE_HANDLER
