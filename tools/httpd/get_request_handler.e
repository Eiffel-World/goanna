indexing

	description: "Handle a GET request"
	date: "11/9/98"
	author: "Copyright (c) Richie Bielak"

class GET_REQUEST_HANDLER

inherit

	SHARED_DOCUMENT_ROOT

	SHARED_URI_CONTENTS_TYPES

	HTTP_REQUEST_HANDLER

	HTTP_CONSTANTS

--    EPX_FACTORY; -- Mixin, portable eposix file API

feature



	process is
			-- process the request and create an answer
		local
			fname: STRING
			ctype, extension: STRING
		do
			debug ("emu_file_read")
				io.put_string ("processing GET")
			end
			fname := clone (document_root_cell.item)
			fname.append (convert_file_separators (request_uri))
			debug ("emu_file_read")
				io.put_string ("file:" + fname)
			end
			!!answer.make
			if file_exists (fname) then
				debug ("emu_file_read")
					io.put_string ("will fetch by extension")
				end
				extension := ct_table.extension (request_uri)
				debug ("emu_file_read")
					io.put_string ("extension:" + extension)
				end
				if ct_table.content_types.has (extension) then
					ctype := ct_table.content_types @ (extension) -- was .item
					debug ("emu_file_read")
						io.put_string ("ctype:" + ctype)
					end
				else
					ctype := "text/html"
				end
				-- TODO: This code could be improved to avoid string
				-- comparisons
				if ctype.is_equal ("text/html") or ctype.is_equal ("text/css") then
					process_text_file (fname)
				else
					process_raw_file (fname)
				end
				answer.set_content_type (ctype)
			else
				answer.set_status_code (not_found)
				answer.set_reason_phrase (not_found_message)
				answer.set_reply_text ("Not found on this server%N%R")
			end
		end

	process_text_file (name : STRING) is
			-- send a text file reply
		local
			file: PLAIN_TEXT_FILE
		do
			from
				buffer.wipe_out
		  		answer.set_reply_text (buffer)
		  		-- GM modified from: create file.open_read (name)
				create file.make (name)
				file.open_read 
			until
				file.end_of_file
			loop
				file.read_stream (max_line_len)
				answer.append_reply_text (file.last_string)
				answer.append_reply_text (crlf)
			end
		end

	process_raw_file (name : STRING) is
		-- send a raw file reply
		local
			file: RAW_FILE
		do
			from
				buffer.wipe_out
		  		answer.set_reply_text (buffer)
				create file.make (name)
				file.open_read
			until
				file.end_of_file
			loop
				file.read_stream (max_raw_chunk)
				answer.append_reply_text (file.last_string)
			end
		end


feature {NONE}

	file_exists (file_name : STRING) : BOOLEAN is
		local
			file: RAW_FILE
			attempts : INTEGER
		do
			create file.make (file_name)
			Result := file.exists
		end

	convert_file_separators (uri: STRING): STRING is
			-- Convert all forward slashes in 'uri' to file separator 
			-- characters
		require
			uri_exists: uri /= Void
		do
			Result := clone (uri)
			Result.replace_substring_all ("/", file_separator_string)
		end

	max_line_len : INTEGER is 1024

	max_raw_chunk : INTEGER is 8000;

	file_separator_string: STRING is
		once
			create Result.make (1)
			Result.append ("\")
		end
		
	buffer : STRING is
		once
			-- GM modified from: !!Result.blank (256 * 1024) 
			!!Result.make (256 * 1024) -- 256 KB initiallly
			Result.fill_blank
		end

end
