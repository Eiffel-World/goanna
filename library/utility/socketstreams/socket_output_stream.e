indexing
	description: "Input stream that writes to an underlying socket."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "utility socketstreams"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOCKET_OUTPUT_STREAM

inherit
	
	KI_TEXT_OUTPUT_STREAM
	
	SOCKET_ERRORS
		export
			{NONE} all
		end
		
create
	
	make
	
feature -- Initialisation

	make (write_socket: TCP_SOCKET) is
			-- Create a new stream that will write to 'read_socket'.
			-- Set line separator to single '%N' character.
		require
			write_socket_exists: write_socket /= Void
		do
			socket := write_socket
			set_eol ("%N")
		ensure
			newline_eol: eol.is_equal ("%N")
		end
		
feature -- Access

	eol: STRING 
			-- Line separator

	socket: TCP_SOCKET
			-- Underlying socket

	last_write_ok: BOOLEAN
			-- Was the last socket write successful?
			
	name: STRING is
			-- Name of output stream
		do
			Result := socket.out
		end
	
feature -- Status report

	is_open_write: BOOLEAN is
			-- Can items be written to output stream?
		do
			Result := socket.is_valid and then not socket.is_closed_outgoing
		end
	
feature -- Basic operations

	flush is
			-- Flush buffered data to disk.
		do
			-- no op
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
			
feature -- Output

	put_character (v: CHARACTER) is
			-- Write `v' to output stream.
		do
			socket.send_string (v.out)
			set_last_write_status
		end
		
	put_string (a_string: STRING) is
			-- Write `a_string' to output stream.
		do
			socket.send_string (a_string)
			set_last_write_status
		end
		
feature {NONE} -- Implementation

	set_last_write_status is
			-- Set the last_write_ok flag depending on the current socket
			-- status
		do
			last_write_ok := socket.last_error_code = sock_err_no_error
			debug ("socket")
				if not last_write_ok then
					print ("Socket error: " 
						+ socket.last_error_code.out + ", " 
						+ socket.last_socket_error_code.out + ", "
						+ socket.last_extended_socket_error_code.out)
				end
			end
		end
			
end -- class SOCKET_OUTPUT_STREAM
