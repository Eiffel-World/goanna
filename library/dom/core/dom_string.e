
indexing
	description: "A sequence of 16-bit units.";
	project: "Eiffel binding for the Level 2 Document Object Model";
	license: "Eiffel Forum Freeware License", "see forum.txt";
	date: "$Date$";
	revision: "$Revision$";
	key: "DOM", "Document Object Model", "DOM Core";

class DOM_STRING

inherit

	UCSTRING

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
			resize(other.count)
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
