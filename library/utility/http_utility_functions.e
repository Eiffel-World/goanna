indexing
	description: "Mixin class of HTTP utility functions"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "HTTP Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	HTTP_UTILITY_FUNCTIONS

inherit
	
	UT_STRING_FORMATTER
		export
			{NONE} all
		end	
		
	BIT_MANIPULATION
		export
			{NONE} all
		end
		
	CHARACTER_MANIPULATION
		export
			{NONE} all
		end
		
feature -- Basic operations

	decode_url (url: STRING): STRING is
			-- Decode a urlencoded string by replacing '+' with space ' ',
	     		-- and "%xx" to the Latin1 character specified by the hex digits
	     		-- "xx".  The input string is assumed to have been broken up into
		 	-- either a key or a value pair, so '=', '?', and '&' are not
	     		-- treated as separators.
		local
			i, hi, lo: INTEGER
			ch: CHARACTER
		do
			create Result.make (url.count)
			from
				i := 1
			until
				i > url.count 
			loop
				ch := url.item (i)
				inspect
					ch
				when '+' then
					Result.append_character (' ')
				when '%%' then
					if i <= (url.count - 2) then
						hi := digit_from_hex (url.item (i + 1))
						lo := digit_from_hex (url.item (i + 2))
						if hi < 0 or lo < 0 then
							Result.append_character (ch)
						else
							Result.append_character (int_to_char (bit_shift_left (hi, 4) + lo)) -- -1
							i := i + 2
						end
					else
						Result.append_character (ch)
					end
				else
					Result.append_character (ch)
				end
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
		end
	
	encode (str: STRING): STRING is
			-- Translate 'str' into HTML safe format.
		require
			str_exists: str /= Void
		local
			i: INTEGER
		do
			create Result.make (str.count)
			from
				i := 1
			until
				i > str.count
			loop
				inspect
					str.item (i)
				when '<' then
					Result.append ("&lt;")
				when '>' then
					Result.append ("&gt;")
				when '&' then
					Result.append ("&amp;")
				when '%'' then
					Result.append ("&#39;")
				when '"' then
					Result.append ("&quot;")
				when '\' then
					Result.append ("&#92;")
				when '%/205/' then
					Result.append ("&#133;")
				else
					Result.append_character (str.item (i))	
				end
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
		end

	digit_from_hex (ch: CHARACTER): INTEGER is
			-- Return the integer representation of the hexadecimal character 'ch'
		require
			hex_character: ch.is_digit or (ch >= 'A' and ch <= 'F') or (ch >= 'a' and ch <= 'f')
		do
			if ch.is_digit then
				Result := ch.out.to_integer
			else
				Result := char_to_lower (ch).code - 86 -- -97 + 11
			end
		end
	
end -- class HTTP_UTILITY_FUNCTIONS
