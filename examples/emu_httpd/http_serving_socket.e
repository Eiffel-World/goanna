indexing

	author:      "Marcio Marchini <mqm@magma.ca>"
	copyright:   "Copyright (c) 2000, Marcio Marchini. Portions Copyright (c) 1998 by Richie Bielak"
	thanks:		 "Bedarra (www.bedarra.com) for support of open source; Richie Bielak for Emu"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:        "$Date$"
	revision:    "$Revision$"


class HTTP_SERVING_SOCKET

inherit
	TCP_SOCKET
		redefine
			multiplex_read_callback
		end

	SOCKET_MULTIPLEXER_SINGLETON

	SHARED_HTTP_REQUEST_HANDLERS

	HTTP_CONSTANTS


creation
    make_uninitialized


feature

	multiplex_read_callback is
			-- this routine is called if there is data ready for
			-- reading on our socket
		do
				io.put_character ('.')
				buffer.resize (buffer_size.min (bytes_available))
				receive_string (buffer)
				-- parse the request line to see
				parse_http_request_line (buffer)
				-- Now get the handler for this method
				request_handler := http_request_handlers.item (current_method)
				if request_handler = Void then
					-- not supported method - send error reply
					--io.put_string ("NOT supported request handler !!!")
					!!answer.make
					answer.set_status_code (not_implemented)
					answer.set_reason_phrase (not_implemented_message)
					answer.set_reply_text ("Sorry! Not implemented!")
					answer.append_reply_text (crlf)
				else
					--io.put_string ("supported request handler !!! ")
					request_handler.set_uri (current_uri)
					request_handler.set_data (buffer)
					request_handler.process
					answer := request_handler.answer
					--io.put_string ("answer:%N")
					--io.put_string (answer.reply_text)
				end

				if answer /= Void then
					--io.put_string ("Sending header: ")
					--io.put_string (answer.reply_header)
					-- TODO: This should be one I/O
					send_string (answer.reply_header)
					if answer.reply_text /= Void then
						--io.put_string ("Sending text: ")
						--io.put_string (answer.reply_text)
						send_string (answer.reply_text)
					end
				end
				-- close socket after sending reply
				--io.put_string ("%NClosing%N")
				socket_multiplexer.unregister_managed_socket_read (Current)
				close
		end

feature -- current request handler

	request_handler: HTTP_REQUEST_HANDLER
			-- handler for the request

	answer: HTTP_RESPONSE
			-- answer for the last request

feature -- handle header fields

	current_method: STRING
			-- method in current request (GET/POST, etc)

	current_uri: STRING
			-- uri for this request

	parse_http_request_line (line: STRING) is
		require
			line /= Void
		local
			pos, next_pos: INTEGER
			rest : STRING
		do
			-- parse (this should be done by a lexer)
			pos := line.index_of (' ', 1)
			current_method := line.substring (1, pos - 1)
			--io.put_string ("current_method:")
			--io.put_string (current_method)
			--io.put_new_line
			rest := line.substring (pos + 1, line.count - 1)
			--io.put_string ("rest:")
			--io.put_string (rest)
			--io.put_new_line
			next_pos := rest.index_of (' ', 1)
			current_uri := rest.substring (1, next_pos-1)
			--io.put_string ("current_uri:")
			--io.put_string (current_uri)
			--io.put_new_line
		ensure
			not_void_method: current_method /= Void
		end



feature {NONE}

    buffer_size : INTEGER is 1024;

	buffer: STRING is
		once
			-- GM modified from: !!Result.blank (buffer_size)
			!!Result.make (buffer_size)
			Result.fill_blank
		end




end -- HTTP_SERVING_SOCKET
