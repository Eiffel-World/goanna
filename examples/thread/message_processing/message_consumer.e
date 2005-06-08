indexing
	description: "Example consumer of messages."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples thread"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class MESSAGE_CONSUMER

inherit
	
	GOA_CONSUMER [STRING]

create
	
	make
	
feature {NONE} -- Implementation

	process (next: STRING) is
			-- Process the next entry in the queue.
		do
			print (next + "%N")
		end

end -- class MESSAGE_CONSUMER
