indexing
	description: "Mixin class that provides portable character manipulation routines."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Utility"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	CHARACTER_MANIPULATION

feature -- Basic operations

	set_char_code (ch: CHARACTER_REF; code: INTEGER): CHARACTER is
			-- Convert code to character
		obsolete "User int_to_char"
		require
			ch_exists: ch /= Void
		do
			Result := code.to_character
		end
		
	int_to_char(code: INTEGER): CHARACTER is
			-- Convert code to character
		do
			Result := code.to_character
		end

	char_to_lower (ch: CHARACTER): CHARACTER is
			-- Convert 'ch' to lower case.
		do
			Result := ch.to_lower
		end
	
end -- class CHARACTER_MANIPULATION
