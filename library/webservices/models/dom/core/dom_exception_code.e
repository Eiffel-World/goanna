indexing
	description: "Exception codes"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Document Object Model (DOM) Core"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class DOM_EXCEPTION_CODE

feature -- Constants

   Index_size_err: INTEGER is 1
         -- If index or size is negative, or greater
         -- than the allowed value

   Domstring_size_err: INTEGER is 2
         -- If the specified range of text does not
         -- fit into a DOMString

   Hierarchy_request_err: INTEGER is 3
         -- If any node is inserted somewhere it
         -- doesn't belong

   Wrong_document_err: INTEGER is 4
         -- If a node is used in a different
         -- document than the one that created it
         -- (that doesn't support it)

   Invalid_character_err: INTEGER is 5
         -- If an invalid character is specified,
         -- such as in a name

   No_data_allowed_err: INTEGER is 6
         -- If data is specified for a node which
         -- does not support data

   No_modification_allowed_err: INTEGER is 7
         -- If an attempt is made to modify an
         -- object where modifications are not
         -- allowed

   Not_found_err: INTEGER is 8
         -- If an attempt was made to reference a
         -- node in a context where it does not
         -- exist

   Not_supported_err: INTEGER is 9
         -- If the implementation does not support
         -- the type of object requested

   Inuse_attribute_err: INTEGER is 10
         -- If an attempt is made to add an
         -- attribute that is already inuse
         -- elsewhere

	Invalid_state_err: INTEGER is 11
		-- If an attempt is made to user and object
		-- that is not, or is no longer, usable.

	Syntax_err: INTEGER is 12
		-- If an invalid or illegal string is specified.

	Invalid_Modification_err: INTEGER is 13
		-- If an attempt is made to modify the type of
		-- the underlying object.

	Namespace_err: INTEGER is 14
		-- If an attempt is made to create or change an object
		-- in a way which is incorrect with regart to 
		-- namespaces.

	Invalid_access_err: INTEGER is 15
		-- If a parameter or an operation is not supported that is
		-- already in use elsewhere.

feature {NONE} -- Implementation: code ranges

   first_dom_exception_code: INTEGER is 1
   last_dom_exception_code: INTEGER is 15

end -- class DOM_EXCEPTION_CODE
