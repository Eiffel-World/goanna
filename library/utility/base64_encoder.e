indexing
	description: "Objects that encode and decode Base64 (RFC1521) strings."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Utility"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	BASE64_ENCODER

inherit

	BIT_MANIPULATION
		export
			{NONE} all
		end
		
feature -- Basic operations

	encode (data: STRING): STRING is
			-- Base64 encode 'data'
		require
			data_exists: data /= Void
		do
			Result := perform_encoding (data, base_64_chars)
		ensure
			encoded_exists: Result /= Void
		end
		
	encode_for_session_key (data: STRING): STRING is
			-- Base64 encode 'data' with a modified Base64 character
			-- set that is suitable for use as a session key and for
			-- transmission as a cookie value.
		require
			data_exists: data /= Void	
		do
			Result := perform_encoding (data, session_key_chars)	
		ensure
			encoded_exists: Result /= Void
		end
	
feature {NONE} -- Implementation

	base_64_chars: ARRAY [CHARACTER] is
			-- The BASE64 encoding standard's 6-bit alphabet, from RFC 1521,
     		-- plus the padding character at the end.
     	once
     		Result := <<
   				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
				'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
				'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
				'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
				'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
				'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
				'w', 'x', 'y', 'z', '0', '1', '2', '3',
				'4', '5', '6', '7', '8', '9', '+', '/',
				'='
        	>>
        ensure
        	sixty_five_chars: Result.count = 65
        end
   
	session_key_chars: ARRAY [CHARACTER] is
			-- Encoding alphabet for session keys. Contains only chars that
			-- are safe to use in cookies, URLs and file names. Same as BASE64 
			-- except the last two chars and the padding char
     	once
     		Result := <<
   				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
				'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
				'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
				'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
				'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
				'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
				'w', 'x', 'y', 'z', '0', '1', '2', '3',
				'4', '5', '6', '7', '8', '9', '_', '-',
				'.'
        	>>
        ensure
        	sixty_five_chars: Result.count = 65
        end

	perform_encoding (bytes: STRING; chars: ARRAY [CHARACTER]): STRING is
			-- Encode 'data' using characters in 'char_set'.
		require
			data_exists: bytes /= Void
			char_set_exists: chars /= Void		
		local
			len, i, ival: INTEGER	
		do
			-- create result 30% bigger than original. This is the standard maximum size increase
			-- for Base64 encoded data.
			create Result.make (bytes.count + (bytes.count * 30 // 100))
			-- encode all 4 character groups
			from
				len := bytes.count
				i := 1
			until
				len < 3
			loop
				ival := bit_and (bytes.item (i).code + 256, 255)
				ival := bit_shift_left (ival, 8)
				i := i + 1
				ival := ival + bit_and (bytes.item (i).code + 256, 255)
				ival := bit_shift_left (ival, 8)
				i := i + 1
				ival := ival + bit_and (bytes.item (i).code + 256, 255)
				i := i + 1
				len := len - 3
				debug ("base64_encode")
					print (generator + ".perform_encoding 1st = " + bit_and (bit_shift_right (ival, 18), 63).out + "%R%N")
					print (generator + ".perform_encoding 1st = " + bit_and (bit_shift_right (ival, 12), 63).out + "%R%N")
					print (generator + ".perform_encoding 1st = " + bit_and (bit_shift_right (ival, 6), 63).out + "%R%N")
					print (generator + ".perform_encoding 1st = " + bit_and (ival, 64).out + "%R%N")
				end
				Result.append_character (chars.item (bit_and (bit_shift_right (ival, 18), 63) + 1))
				Result.append_character (chars.item (bit_and (bit_shift_right (ival, 12), 63) + 1))
				Result.append_character (chars.item (bit_and (bit_shift_right (ival, 6), 63) + 1))
				Result.append_character (chars.item (bit_and (ival, 63) + 1))
			end
			inspect
				len
			when 1 then
				-- two more output bytes and two pads
				ival := bit_and (bytes.item (i).code + 256, 255)
				i := i + 1
				ival := bit_shift_left (ival, 16)
				Result.append_character (chars.item (bit_and (bit_shift_right (ival, 18), 63) + 1))
				Result.append_character (chars.item (bit_and (bit_shift_right (ival, 12), 63) + 1))
				Result.append_character (chars.item (chars.upper))
				Result.append_character (chars.item (chars.upper))
			when 2 then
				-- three more output bytes and two pads
				ival := bit_and (bytes.item (i).code + 256, 255)
				ival := bit_shift_left (ival, 8)
				i := i + 1
				ival := ival + bit_and (bytes.item (i).code + 256, 255)
				ival := bit_shift_left (ival, 8)
				Result.append_character (chars.item (bit_and (bit_shift_right (ival, 18), 63) + 1))
				Result.append_character (chars.item (bit_and (bit_shift_right (ival, 12), 63) + 1))
				Result.append_character (chars.item (bit_and (bit_shift_right (ival, 6), 63) + 1))
				Result.append_character (chars.item (chars.upper))	
			else
				-- must be zero. ignore.
			end
		ensure
			encoded_string_exists: Result /= Void
		end         
	       
end -- class BASE64_ENCODER
