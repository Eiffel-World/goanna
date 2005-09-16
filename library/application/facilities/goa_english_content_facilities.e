indexing
	description: "Facilities for creating user content"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_ENGLISH_CONTENT_FACILITIES
	
feature

	a_or_an (next_string: STRING; capitalize: BOOLEAN): STRING is
			-- Return a or an, depending on next_character
		require
			valid_next_string: next_string /= Void
		do
			if capitalize then
				Result := "A"
			else
				Result := "a"
			end
			if vowels.has (next_string.item (1)) then
				Result.append ("n ")
			else
				Result.append (" ")
			end			
		end

	vowels: STRING is "aeiouAEIOU"
			-- The english vowels
	
	scrub (the_string, acceptable_characters: STRING) is
			-- Remove any characters from the_string that don't occur in acceptable_characters
		require
			valid_the_string: the_string /= Void
			valid_acceptable_characters: acceptable_characters /= Void
		local
			index: INTEGER
		do
			from
				index := 1
			until
				index > the_string.count
			loop
				if not acceptable_characters.has (the_string.item (index)) then
					the_string.remove (index)
				else
					index := index + 1
				end
			end
		end
		
	contains_acceptable_characters (the_string, acceptable_characters: STRING): BOOLEAN is
			-- Does the_string contain only characters that are in acceptable_characters
		require
			valid_the_string: the_string /= Void
			valid_acceptable_characters: acceptable_characters /= Void
		local
			index: INTEGER
		do
			from
				index := 1
				Result := True
			until
				index > the_string.count or not Result
			loop
				Result := acceptable_characters.has (the_string.item (index))
				index := index + 1
			end
		end

end -- class GOA_ENGLISH_CONTENT_FACILITIES
