indexing
	description: "Binary content file handler"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	BINARY_CONTENT_FILE_HANDLER

inherit
	CONTENT_FILE_HANDLER
	
	KL_INPUT_STREAM_ROUTINES
--		export
--			{NONE} all
--		end

feature -- Basic operations

	service (file_name: STRING; content_type_code: INTEGER;
		req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Service the file request for the specified 'file_name' and
			-- 'content_type_code'. Send the file to 'resp'.
			--| There is currently no difference between this method and
			--| the equivalent method in TEXT_CONTENT_FILE_HANDLER
		local
			file: like input_stream_type
		do
			file := make_file_open_read (file_name)
			-- This is really inefficient because the whole file has
			-- to be read into memory. I had to do it this way because 
			-- I couldn't find a portable way to get the file.count to
			-- set the content length earlier
			from
				buffer.wipe_out
			until
				end_of_input (file)
			loop
				buffer.append (read_string (file, Max_raw_chunk))
			end
			close (file)	
			-- setup response
			resp.set_content_type (content_types.item (content_type_code))
			resp.set_content_length (buffer.count)
			resp.set_status (Sc_ok)
			-- write file data to response
			resp.send (buffer)
		end
		
feature {NONE} -- Implementation

	Max_raw_chunk : INTEGER is 8192

end -- class BINARY_CONTENT_FILE_HANDLER
