indexing
	description: "Returns current date time of current machine"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "XMLRPC examples test"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	CURRENT_DATE_TIME

inherit
	
	SERVICE
	
	DT_SHARED_SYSTEM_CLOCK
		export
			{NONE} all
		end
		
creation
	
	make
			
feature -- Access
			
		
	get_current_time: DT_DATE_TIME is
			-- Return current time
		do
			Result := system_clock.date_time_now
		end

feature {NONE} -- Initialisation

	self_register is
			-- Register all actions for this service
		do	
			register (agent get_current_time, "getCurrentTime")				
		end

end -- class CURRENT_DATE_TIME
