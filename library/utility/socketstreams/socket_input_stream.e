indexing
	description: "Input stream that reads from an underlying socket."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "utility socketstreams"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOCKET_INPUT_STREAM
	
inherit
	
	KI_TEXT_INPUT_STREAM
	
	SOCKET_ERRORS
		export
			{NONE} all
		end
		
create
	
	make
	
feature -- Initialisation

	make (read_socket: TCP_SOCKET) is
			-- Create a new stream that will read from 'read_socket'.
			-- Set line separator to single '%N' character.
		require
			read_socket_exists: read_socket /= Void
		do
			socket := read_socket
			set_buffer_size (Default_buffer_size)
			bytes_read := -1
			set_eol ("%N")
		ensure
			newline_eol: eol.is_equal ("%N")
		end
		
feature -- Access

	last_character: CHARACTER
			-- Last item read

	last_string: STRING
			-- Last string read
			-- (Note: this query always return the same object.
			-- Therefore a clone should be used if the result
			-- is to be kept beyond the next call to this feature.
			-- However `last_string' is not shared between file objects.)

	last_read_ok: BOOLEAN
			-- Was last read successful?	
			-- See socket.error_code and socket.extended_error_code for more details.
			
	name: STRING is
			-- Name of input stream
		do
			Result := socket.out
		end
			
	socket: TCP_SOCKET
			-- Underlying socket
	
	eol: STRING
			-- Line separator
	
	buffer_size: INTEGER
			-- Size of read buffer
			
feature -- Status report

	end_of_input: BOOLEAN is
			-- Has the end of input stream been reached?
		do
			Result := socket.is_closed_incoming or not socket.is_valid
		end

	is_open_read: BOOLEAN is
			-- Can items be read from input stream?
		do
			Result := socket.is_valid and then not socket.is_closed_incoming
		end

feature -- Input

	read_character is
			-- Read the next item in input stream.
			-- Make the result available in `last_character'.
			-- Will block until a character has been read.
		do
			last_character := get_next_char
		end

	read_string (nb: INTEGER) is
			-- Read at most `nb' characters from input stream.
			-- Make the characters that have actually been read
			-- available in `last_string'.
			-- Will block until complete string has been read or a socket
			-- error occurs (such as being closed).
		do
			-- create new string
			if last_string = Void then
				create last_string.make (nb)
			else
				if last_string.count < nb then
					last_string.resize (nb)
				end
			end
			last_string.wipe_out
			-- read until nb characters have been read		
			read_character						
			if last_read_ok then
				from
					last_string.append_character (last_character)	
				until
					last_string.count = nb or not last_read_ok
				loop
					read_character
					if last_read_ok then
						last_string.append_character (last_character)
					end
				end	
			end
		end	
	
	unread_character (an_item: CHARACTER) is
			-- Put `an_item' back in input stream.
			-- This item will be read first by the next
			-- call to a read routine.
		do
			if bytes_read > 0 then
				if offset = 1 then
					-- from previous buffer so prepend
					-- and pretend we read one more character
					buffer.prepend_character (an_item)
					bytes_read := bytes_read + 1
				elseif offset <= bytes_read + 1 then
					-- move the offset back one
					offset := offset - 1	
				end
			end
			last_character := an_item
		end

	read_line is
			-- Read characters from input stream until a line separator
			-- or end of file is reached. Make the characters that have
			-- been read available in `last_string' and discard the line
			-- separator characters from the input stream.
		local
			eol_found: BOOLEAN
			c: INTEGER
		do
			-- create new string
			if last_string = Void then
				create last_string.make (120)
			end
			last_string.wipe_out
			-- read until eol has been read
			read_character
			if last_read_ok then
				from
					last_string.append_character (last_character)				
				until
					eol_read or not last_read_ok
				loop
					read_character	
					if last_read_ok then
						last_string.append_character (last_character)				
					end
				end
				if last_read_ok then
					-- put the eol string back
					from
						c := 0
					until
						c >= eol.count
					loop
						unread_character (last_string.item (last_string.count - c))
						c := c + 1
					end
					last_string.head (last_string.count - eol.count)
				end
			end
		end

	read_new_line is
			-- Read a line separator from input stream.
			-- Make the characters making up the recognized
			-- line separator available in `last_string',
			-- or make `last_string' empty and leave the
			-- input stream unchanged if no line separator
			-- was found.			
		local
			bad_char_found, eol_found: BOOLEAN
			chars_read: INTEGER
		do
			-- create new string
			if last_string = Void then
				create last_string.make (120)
			end
			last_string.wipe_out
			-- attempt to read the eol string. Abort as soon as
			-- a missmatched character is read.
			read_character
			if last_read_ok then
				
				from
					chars_read := chars_read + 1
				until
					eol_found or bad_char_found
				loop
					if not last_character.is_equal (eol.item (chars_read)) then
						bad_char_found := True
					else
						last_string.append_character (last_character)
						if last_string.is_equal (eol) then
							eol_found := True
						end
					end
					if chars_read < eol.count then
						read_character
						bad_char_found := not last_read_ok
						chars_read := chars_read + 1
					end
				end	
				-- if eol was not found reset the last string and buffer
				if bad_char_found or chars_read > eol.count then
					unread_character (last_character)
					last_string.wipe_out
				end
			end
			
		end

feature -- Status setting

	set_eol (new_eol: STRING) is
			-- Set end of line string that will be used to
			-- determine if an end of line has been reached.
		require
			new_eol_exists: new_eol /= Void
			new_eol_not_empty: not new_eol.is_empty
		do
			eol := new_eol
		end
	
	set_buffer_size (size: INTEGER) is
			-- Set read buffer size to 'size'.
			-- Destroys current buffer.
		require
			valid_size: size > 0
		do
			buffer_size := size
			create buffer.make (size)
			buffer.fill_blank
		end	
		
feature {NONE} -- Implementation

	Default_buffer_size: INTEGER is 1024
	
	buffer: STRING
			-- Buffer for socket reads
			
	bytes_read: INTEGER
			-- Number of bytes read
	
	offset: INTEGER
			-- Position of next character to read from buffer
			
	get_next_char: CHARACTER is
			-- Read the next available character from the socket.
		require
			not_end_of_input: not end_of_input
			is_open: is_open_read
		do
			-- check if there are characters in the buffer to consume
			if offset > bytes_read then
				-- clear the buffer and read more from the socket
				buffer.fill_blank
				offset := 1
				socket.receive_string (buffer)
				set_last_read_status
				if last_read_ok then
					bytes_read := socket.bytes_received
				end
			end
			if last_read_ok then
				-- consume one character from the buffer
				Result := buffer.item (offset)
				offset := offset + 1
			end
		end
		
	eol_read: BOOLEAN is
			-- Does the last_string end with the end of line string
		do
			Result := last_string.count >= eol.count
				and then last_string.substring_index (eol, last_string.count - eol.count + 1) /= 0
		end
	
	set_last_read_status is
			-- Set the last_read_ok flag depending on the current socket
			-- status
		do
			last_read_ok := socket.last_error_code = Sock_err_no_error
			debug ("socket")
				if not last_read_ok then
					print ("Socket error: " 
						+ socket.last_error_code.out + ", " 
						+ socket.last_socket_error_code.out + ", "
						+ socket.last_extended_socket_error_code.out)
				end
			end
		end
		
invariant
	
	socket_exists: socket /= Void
	
end -- class SOCKET_INPUT_STREAM
