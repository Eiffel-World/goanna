indexing
	description: "Example message producer consumer controller."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples thread"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	MESSAGE_CONTROL

inherit
	
	PRODUCER_CONSUMER_CONTROL
		rename
			make as control_make
		export
			{NONE} control_make
		end
	
create
	
	make 

feature {NONE} -- Initialisation

	make is
			-- Initialise
		do
			control_make (10, 2)
			create queue
		end
		
feature -- Factory operations

	create_consumer: MESSAGE_CONSUMER is
			-- Factory method for creating a new concrete consumer instance.
		do
			create Result.make (queue)
		end
	
	create_producer: MESSAGE_PRODUCER is
			-- Factory method for creating a new concrete producer instance.
		do
			label := label + 1
			create Result.make (label.out, queue)
		end
	
feature {NONE} -- Factory attributes

	queue: THREAD_SAFE_QUEUE [STRING]
	
	label: INTEGER
	
end -- class MESSAGE_CONTROL
