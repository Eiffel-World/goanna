indexing
	description: "Abstract servlet application"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@users.sourceforge.net>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

deferred class GOA_SERVLET_APPLICATION

feature {NONE} -- Initialization

	make (port, backlog: INTEGER) is
			-- Initialise the server to listen on 'port' with 
			-- room for 'backlog' waiting requests. 	
		require
			valid_port: port >= 0
			valid_backlog: backlog >= 0
		deferred
		end

feature -- Basic operations

	register_servlets is
			-- Register servlets for this application
		deferred
		ensure
			all_servlets_registered: all_servlets_registered
		end
		
	run is
			-- Run the application and process requests
		require
			ok_to_run: ok_to_run
		deferred
		end
		
	ok_to_run: BOOLEAN is
			-- Application in a state in which run may be called
			-- May be redefined by descendents as necessary
		do
			Result := all_servlets_registered
		ensure
			result_implies_all_servlets_registered: Result implies all_servlets_registered
		end
		
	all_servlets_registered: BOOLEAN is
			-- Have all required servlets been registered
			-- May be redefined by descendents as necessary
		deferred
		end

end -- class GOA_SERVLET_APPLICATION
