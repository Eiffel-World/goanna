indexing
	description: "Objects that represent an Eiffel feature, either an attribute, function or procedure."
	author: "Glenn Maughan"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_FEATURE

inherit

	EIFFEL_CODE

feature -- Initialization

	make (new_name: STRING) is
			-- Create a new Eiffel feature with 'name'
		require
			name_exists: new_name /= Void
		do
			set_name (new_name)
		end

feature -- Access

	name: STRING
			-- Name of feature.

feature -- Status setting

	set_name (new_name: STRING) is
			-- Set feature name to 'name'
		require
			name_exists: new_name /= Void
		do
			name := new_name
		end

invariant

	name_exists: name /= Void

end -- class EIFFEL_FEATURE
