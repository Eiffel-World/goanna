indexing
	description: "Objects that represent Eiffel code fragments"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Eiffel Code Generator"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	EIFFEL_CODE

feature -- Basic operations

	write (output: IO_MEDIUM) is
			-- Print source code representation of this fragment to 'output'.
		require
			output_exists: output /= Void
		deferred
		end

end -- class EIFFEL_CODE
