indexing
	description: "Manages a sequence of connectors and processes requests from each in turn"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class

	GS_REQUEST_PROCESSOR

inherit
	
	GS_APPLICATION_LOGGER
		export
			{NONE} all
		end
	
	PRODUCER_CONSUMER_CONTROL
		rename
			make as control_make
		export
			{NONE} control_make
		end
	
create

	make
		
feature -- Initialization

	make (application_context: GS_SERVLET_CONTEXT) is
			-- Initialise this request processor
		require
			application_context_exists: application_context /= Void
		do
			control_make
			context := application_context
		end
	
feature -- Access

	context: GS_SERVLET_CONTEXT
			-- Application context

invariant
	
	context_not_void: context /= Void
	
end -- class GS_REQUEST_PROCESSOR
