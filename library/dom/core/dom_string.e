indexing
	description: "A sequence of 16-bit units.";
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Document Object Model (DOM) Core"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class DOM_STRING

inherit

	UCSTRING
		rename
			empty as is_empty
		end

creation

	make, make_from_string, make_from_utf8, make_from_ucstring

feature -- Initialisation

	make_from_ucstring (other: UCSTRING) is
			-- Create a dom string from 'other'
		require
			other_exists: other /= Void
		local
			i: INTEGER
		do
			make (other.count)
			resize (other.count)
			from
				i := 1
			--variant
			--	other.count - i
			until
				i > other.count
			loop
				put_code(other.item_code(i), i)
				i := i + 1
			end
		ensure 
			same_size: count = other.count
		end

feature -- Status report

	length: INTEGER is
			-- Number of 16-bit units in this string.
		do
			Result := count
		end
		
end -- class DOM_STRING
