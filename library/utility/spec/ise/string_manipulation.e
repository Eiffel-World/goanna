indexing
	description: "Mixin class that provides portable string manipulation routines."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Utility"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	STRING_MANIPULATION

feature -- Basic operations

	create_blank_buffer (size: INTEGER): STRING is
			-- Create a buffer string filled with blanks.
		require
			positive_size: size >= 0
		do
			create Result.make (size)
			Result.fill_blank
		ensure
			blank_buffer_exists: Result /= Void
			correct_size: Result.count = size
			blank_filled: Result.occurrences (' ') = size
		end
	
	index_of_char (str: STRING; char: CHARACTER; start: INTEGER): INTEGER is
			-- Position of first occurrence of `c' in `str' at or after `start';
			-- 0 if none.
		require
			str_exists: str /= Void
			start_large_enough: start >= 1
			start_small_enough: start <= str.count
		do
			Result := str.index_of (char, start)
		end
		
end -- class STRING_MANIPULATION
