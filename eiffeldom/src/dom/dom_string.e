
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

	make, make_from_string, make_from_utf8

feature -- Status report

	length: INTEGER is
			-- Number of 16-bit units in this string.
		do
			Result := count
		end

end -- class DOM_STRING
