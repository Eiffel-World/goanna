indexing
	description: "Mixin class of HTTP utility functions"
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_UTILITY_FUNCTIONS

inherit

	ASCII
		export
			{NONE} all
		end
	
	UT_STRING_FORMATTER
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
							Result.append_character ('%U' + (hi.bit_shift_left (4) + lo))
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
		local
			char: CHARACTER
		do
			if ch.is_digit then
				Result := ch.out.to_integer
			else
				char := ch.lower - Lower_a
				Result := (ch.lower - Lower_a).code + 11
			end
		end
	
end -- class HTTP_UTILITY_FUNCTIONS
