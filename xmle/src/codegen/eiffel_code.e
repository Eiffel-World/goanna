indexing
	description: "Objects that represent Eiffel code fragments."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

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
