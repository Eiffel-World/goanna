indexing
	description: "Shared objects for producers and consumers."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "utility thread"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	GOA_SHARED_PRODUCER_CONSUMER_DATA

feature 

	mutex: MUTEX is
			-- Request mutex
		indexing
			once_status: "global"
		once
			create Result
		end

	condition: CONDITION_VARIABLE is
			-- Request condition variable
		indexing
			once_status: "global"
		once
			create Result.make
		end
		
end -- class GOA_SHARED_PRODUCER_CONSUMER_DATA
