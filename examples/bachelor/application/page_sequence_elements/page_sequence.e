indexing
	description: "A sequence of pages"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI Applications"
	date: "$Date: 2001/05/11"
	revision: "$Revision$"
	author: "Neal L. Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Lockheed-Martin Space System Company"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	PAGE_SEQUENCE

 inherit
	PAGE_SEQUENCE_ELEMENT
	SEQUENCE_ELEMENT_FACTORY

feature -- Implement Deferred Features


	create_sequence is
		-- Create the page sequence
		deferred
		end

invariant

end -- class PAGE_SEQUENCE