indexing
	description: "Objects that represent Eiffel attributes"
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_ATTRIBUTE

inherit
	EIFFEL_FEATURE
		rename
			make as feature_make
		end

creation

	make

feature -- Initialization

	make is
			-- Create a new attribute
		require
			new_name_exists: new_name /= Void
			new_type_exists: new_type /= Void
		do
			feature_make (new_name)
			set_type (new_type)
		end

feature -- Access

	type: STRING
			-- The type of this attribute.

feature -- Status setting

	set_type (new_type: STRING) is
			-- Set the type of this attribute
		do
			type := new_type
		end

feature -- Basic operations

	write (output: IO_MEDIUM) is
			-- Print source code representation of this attribute on 'output'
		do
			output.put_string ("%T" + name + ": " + type)
			output.put_new_line
			output.put_new_line
		end

invariant

	type_exists: type /= Void

end -- class EIFFEL_ATTRIBUTE
