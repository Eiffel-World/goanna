indexing
	description: "Generic File servlet for serving standard HTTP file requests"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	FILE_SERVLET

inherit

	HTTP_SERVLET
		redefine
			do_get, do_post
		end

	UT_STRING_FORMATTER
		export
			{NONE} all
		end
	
	HTTP_STATUS_CODES
		export
			{NONE} all
		end
		
	CONTENT_TYPES
		export
			{NONE} all
		end
	
	KL_INPUT_STREAM_ROUTINES
		export
			{NONE} all
		end
		
creation

	init
	
feature -- Basic operations

	do_get (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Process GET request
		local
			file_name, file_extension: STRING
			ctype_code: INTEGER
		do
			file_name := clone (servlet_config.document_root)
			file_name.append (req.path_info)
			if exists (file_name) then
				file_extension := extension (req.path_info)
				if content_type_codes.has (file_extension) then
					ctype_code := content_type_codes.item (file_extension)
				else
					-- assume html
					ctype_code := Content_type_text_html
				end
				content_type_handlers.item (ctype_code).service (file_name, ctype_code, req, resp)
			else
				resp.send_error (Sc_not_found)
			end

		end
	
	do_post (req: HTTP_SERVLET_REQUEST; resp: HTTP_SERVLET_RESPONSE) is
			-- Process GET request
		do
			do_get (req, resp)
		end
		
feature {NONE} -- Implementation
	
	content_type_handlers: ARRAY [CONTENT_FILE_HANDLER] is
			-- Array of handlers for content type files
		local
			text_file_handler: TEXT_CONTENT_FILE_HANDLER
			binary_file_handler: BINARY_CONTENT_FILE_HANDLER
		once
			create text_file_handler
			create binary_file_handler
			create Result.make (First_content_type, Last_content_type)
			Result.put (text_file_handler, Content_type_text_html)
			Result.put (text_file_handler, Content_type_text_xml)
			Result.put (text_file_handler, Content_type_text_css)
			Result.put (text_file_handler, Content_type_text_xsl)
			Result.put (text_file_handler, Content_type_text_rtf)
			Result.put (binary_file_handler, Content_type_image_gif)
			Result.put (binary_file_handler, Content_type_image_jpeg)
			Result.put (binary_file_handler, Content_type_image_png)
			Result.put (binary_file_handler, Content_type_image_tiff)
		end	
		
	exists (file_name: STRING): BOOLEAN is
			-- Does a file named 'file_name' exists and is it readable?
			--| Not called file_exists because a SmallEiffel developer thought
			--| it was a good idea to put file manipulation routines in GENERAL!
		local
			file: like input_stream_type
		do
			file := make_file_open_read (file_name)
			Result := is_open_read (file)
			if is_open_read (file) then
				close (file)		
			end
		end
		
end -- class FILE_SERVLET
