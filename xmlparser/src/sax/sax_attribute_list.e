indexing

	description: "Interface for an element's attribute specification"
	author: "Glenn Maughan"
	revision: "$Revision$"
	date: "$Date$"

deferred class SAX_ATTRIBUTE_LIST

feature

	get_length: INTEGER is
			-- Return the number of attributes in this list.
		deferred
		end

	get_name (i: INTEGER): STRING is
			-- Return the name of an attribute in this list (by position)
		deferred
		end

	get_type (i: INTEGER): STRING is
			-- Return the type of an attribute in the list (by position)
		deferred
		end

	get_value (i: INTEGER): STRING is
			-- Return the value of an attribute in the list (by position)
		deferred
		end

	get_type_by_name (name: STRING): STRING is
			-- Return the type of an attribute in the list (by name)
		deferred
		end

	get_value_by_name (name: STRING): STRING is
			-- Return the value of an attribute in the list (by name)
		deferred
		end

end -- class SAX_ATTRIBUTE_LIST
