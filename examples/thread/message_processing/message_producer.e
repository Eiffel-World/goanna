indexing
	description: "Example producer of messages."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples thread"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	MESSAGE_PRODUCER

inherit
	
	PRODUCER [STRING]
		rename
			make as producer_make
		export
			{NONE} producer_make
		end

create
	
	make
	
feature {NONE} -- Initialisation

	make (new_name: STRING; queue: like request_queue) is
			-- Initialise
		require
			name_not_void: new_name /= Void
			queue_not_void: queue /= Void
		do
			producer_make (queue)
			name := new_name
		end
		
feature {NONE} -- Implementation

	generate_next: STRING is
			-- Generate the next element for the queue
		do
			number_messages := number_messages + 1
			Result := "Message (" + name + "): " + number_messages.out
		end
		
	done: BOOLEAN is
			-- Has the producer finished generating events?
		do
			Result := number_messages >= Max_number_messages
		end

	number_messages: INTEGER
			-- Number of messages sent
			
	Max_number_messages: INTEGER is 100
	
	name: STRING
			-- Name of this message producer
			
end -- class MESSAGE_PRODUCER
