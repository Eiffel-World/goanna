indexing
	description: "Shared objects for producers and consumers."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "utility thread"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class

	SHARED_PRODUCER_CONSUMER_DATA

feature 

	mutex: PRODUCER_CONSUMER_MUTEX is
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
		
end -- class SHARED_PRODUCER_CONSUMER_DATA
