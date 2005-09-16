indexing
	description: "Links to external websites"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	GOA_EXTERNAL_HYPERLINK

inherit

	GOA_HYPERLINK
	KL_IMPORTED_STRING_ROUTINES
	
creation
	
	make
	
feature {NONE} -- Creation

	make (new_host_and_path, new_text: STRING) is
			-- Creation
		require
			valid_new_host_and_path: new_host_and_path /= Void
			valid_new_text: new_text /= Void
		do
			initialize
			host_and_path := STRING_.cloned_string (new_host_and_path)
			text := STRING_.cloned_string (new_text)
		end
		

end -- class GOA_EXTERNAL_HYPERLINK
