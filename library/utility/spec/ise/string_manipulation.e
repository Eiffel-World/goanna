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
		
	clear_buffer (buffer: STRING) is
			-- Clear buffer of all characters
		require
			buffer_exists: buffer /= Void
		do
			buffer.clear_all
		ensure
			same_capacity: old buffer.capacity = buffer.capacity
			empty: buffer.is_empty
		end
		
	is_buffer_full (buffer: STRING): BOOLEAN is
			-- Is 'buffer' full to capacity?
		require
			buffer_exists: buffer /= Void
		do
			Result := buffer.full
		ensure
			full_result: Result = buffer.full
		end	
		
	last_index_of (str: STRING; c: CHARACTER; start_index_from_end: INTEGER): INTEGER is
			-- Position of last occurence of `c' in 'str'.
			-- 0 if none
		require
			str_exists: str /= Void
			start_index_small_enough: start_index_from_end <= str.count
			start_index_large_enough: start_index_from_end >= 1
		do
			Result := str.last_index_of (c, start_index_from_end)
		ensure
			correct_place: Result > 0 implies str.item (Result) = c
		end
		
end -- class STRING_MANIPULATION
