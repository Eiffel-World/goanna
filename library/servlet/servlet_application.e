indexing
	description: "Abstract servlet application"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	SERVLET_APPLICATION

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
		end
		
	run is
			-- Run the application and process requests
		deferred
		end
		
end -- class SERVLET_APPLICATION
