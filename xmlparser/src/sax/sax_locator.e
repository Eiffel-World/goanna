indexing

	description: "Interface for associating a SAX event with a document location"
	author: "Glenn Maughan"
	revision: "$Revision$"
	date: "$Date$

deferred class SAX_LOCATOR

feature

	get_public_id: STRING is
			-- Return the public identifier for the current document event.
		deferred
		end

	get_system_id: STRING is
			-- Return the system identifier for the current document event.
		deferred
		end

	get_line_number: INTEGER is
			-- Return the line number where the current document event ends.
		deferred
		end

	get_column_number: INTEGER is
			-- Return the column number where the current document event ends.
		deferred
		end

end -- class SAX_LOCATOR
