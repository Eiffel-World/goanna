indexing
	description: "Request handling thread."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	
	GS_REQUEST_CONSUMER

inherit

	CONSUMER [GS_QUEUED_REQUEST]
		rename
			make as consumer_make
		export
			{NONE} consumer_make
		end

creation
	
	make

feature {NONE} -- Initialisation

	make (thread_name: STRING; app_context: GS_SERVLET_CONTEXT; queue: THREAD_SAFE_QUEUE [GS_QUEUED_REQUEST]) is
			-- Initialise
		require
			thread_name_not_void: thread_name /= Void
			app_context_not_void: app_context /= Void
			queue_not_void: queue /= Void
		do
			consumer_make (thread_name, queue)
			context := app_context
			debugging (generator, name.out + " initialised")
		end
		
feature {NONE} -- Implementation

	context: GS_SERVLET_CONTEXT
			-- Servlet application context
			
	process (next: GS_QUEUED_REQUEST) is
			-- Process the next entry in the queue.
		do
			debugging (generator, name.out + " handling request")
			debugging (generator, name.out + " request = " + next.request.to_string)
			context.manager.dispatch (next.request, next.response)
		end
		
invariant
	
	context_not_void: context /= Void
	
end -- class GS_REQUEST_CONSUMER