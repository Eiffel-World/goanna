indexing
	description: "Returns current date time of current machine"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XMLRPC examples test"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	CURRENT_DATE_TIME

inherit
	
	GOA_SERVICE
	
	DT_SHARED_SYSTEM_CLOCK
		export
			{NONE} all
		end
		
create
	
	make
			
feature -- Access
			
		
	get_current_time: DT_DATE_TIME is
			-- Return current time
		do
			Result := system_clock.date_time_now
		end

feature -- Creation

	new_tuple (a_name: STRING): TUPLE is
			--	Tuple of default-valued arguments to pass to call `a_name'.
		local
			a_tuple: TUPLE []
		do
			create a_tuple; Result := a_tuple
		end

feature {NONE} -- Implementation

	Get_current_time_name: STRING is "getCurrentTime"
			-- Name of `get_current_time' service

feature {NONE} -- Initialisation

	self_register is
			-- Register all actions for this service
		do	
			register (agent get_current_time, Get_current_time_name)				
		end

end -- class CURRENT_DATE_TIME
