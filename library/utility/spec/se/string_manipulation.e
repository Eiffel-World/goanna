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
			!! Result.blank (size)
		ensure
			blank_buffer_exists: Result /= Void
			correct_size: Result.count = size
			blank_filled: Result.occurrences (' ') = size
		end
	
end -- class STRING_MANIPULATION
