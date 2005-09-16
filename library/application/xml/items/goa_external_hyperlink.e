indexing
	description: "Links to external websites"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_EXTERNAL_HYPERLINK

inherit
	GOA_HYPERLINK
	
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
			host_and_path := clone (new_host_and_path)
			text := clone (new_text)
		end
		

end -- class GOA_EXTERNAL_HYPERLINK
