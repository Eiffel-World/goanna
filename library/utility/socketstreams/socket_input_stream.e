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
			create buffer.make (2048)
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

	name: STRING is
			-- Name of input stream
		do
			Result := socket.out
		end
			
	socket: TCP_SOCKET
			-- Underlying socket
	
	eol: STRING
			-- Line separator
	
feature -- Status report

	end_of_input: BOOLEAN is
			-- Has the end of input stream been reached?
		do
			Result := not socket.is_closed or not socket.is_valid
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
			-- prime the string
			-- keep building the string until a line separator is found
			from
				read_character
				last_string.wipe_out
				last_string.append_character (last_character)				
			until
				last_string.count = nb
			loop
				read_character
				last_string.append_character (last_character)
			end	
		end	
	
	unread_character (an_item: CHARACTER) is
			-- Put `an_item' back in input stream.
			-- This item will be read first by the next
			-- call to a read routine.
		do
			
		end

	read_line is
			-- Read characters from input stream until a line separator
			-- or end of file is reached. Make the characters that have
			-- been read available in `last_string' and discard the line
			-- separator characters from the input stream.
		do
		end

	read_new_line is
			-- Read a line separator from input stream.
			-- Make the characters making up the recognized
			-- line separator available in `last_string',
			-- or make `last_string' empty and leave the
			-- input stream unchanged if no line separator
			-- was found.
		do
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
		
feature {NONE} -- Implementation

	buffer: STRING
			-- Buffer for socket reads
			
	bytes_read: INTEGER
			-- Number of bytes read on 
	
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
				buffer.wipe_out
				offset := 1
				socket.receive_string (buffer)
				bytes_read := socket.bytes_received
			end
			-- consume one character from the buffer
			Result := buffer.item (offset)
			offset := offset + 1
		end
		
	eol_read: BOOLEAN is
			-- Does the last_string end with the end of line string
		do
			Result := last_string.count >= eol.count
				and then last_string.substring_index (eol, last_string.count - eol.count) /= 0
		end
		
invariant
	
	socket_exists: socket /= Void
	
end -- class SOCKET_INPUT_STREAM
