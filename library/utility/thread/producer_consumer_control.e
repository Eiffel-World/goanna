indexing
	description: "Coordinates producers and consumers."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "utility thread"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	PRODUCER_CONSUMER_CONTROL

inherit
	
	SHARED_PRODUCER_CONSUMER_DATA
		export
			{NONE} all
		end
	
	THREAD_CONTROL
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (number_of_consumers, number_of_producers: INTEGER) is
			-- Initialise with capability to create 'number_of_consumers' 
			-- consumers and 'number_of_producers' producers.
		require
			positive_consumer_count: number_of_consumers >= 1
			positive_producer_count: number_of_producers >= 1
		do
			consumer_count := number_of_consumers
			producer_count := number_of_producers
			create consumers.make (consumer_count)
			create producers.make (producer_count)
		end

feature -- Access

	consumer_count: INTEGER
			-- Number of consumers
			
	producer_count: INTEGER
			-- Number of producers

feature -- Basic operations

	run is
			-- Start the pipeline
		do
			start_consumers
			start_producers
			wait_for_producers
			terminate_consumers
		end

feature {NONE} -- Factory operations

	create_consumer: CONSUMER [ANY] is
			-- Factory method for creating a new concrete consumer instance.
		deferred
		ensure
			consumer_not_void: Result /= Void
		end
	
	create_producer: PRODUCER [ANY] is
			-- Factory method for creating a new concrete producer instance.
		deferred
		ensure
			producer_not_void: Result /= Void
		end

feature {NONE} -- Factory attributes

	queue: THREAD_SAFE_QUEUE [ANY] is
			-- Request queue. 
			--| Descendants should effect as an attribute.
		deferred
		end

feature {NONE} -- Implementation
		
	consumers: ARRAYED_LIST [like create_consumer]
			-- List of consumers
	
	producers: ARRAYED_LIST [like create_producer]
			-- List of producers

	start_consumers is
			-- Initialise and launch 'number_of_consumers' consumers
		local
			c: INTEGER
			consumer: like create_consumer
		do
			debug ("producer_consumer")
				print ("Starting consumers...%N") 
			end
			from
				c := 1
			until
				c > consumer_count
			loop	
				consumer := create_consumer
				consumers.extend (consumer)
				consumer.launch
				c := c + 1
			end
		end
	
	start_producers is
			-- Start producers
		local
			c: INTEGER
			producer: like create_producer
		do
			debug ("producer_consumer")
				print ("Starting producers...%N")
			end
			from
				c := 1
			until
				c > producer_count
			loop
				producer := create_producer
				producers.extend (producer)
				producer.launch
				c := c + 1
			end
		end
		
	wait_for_producers is
			-- Wait for all producers to terminate
		do			
			debug ("producer_consumer")
				print ("Terminating producers...%N") 
			end
			from
				producers.start
			until
				producers.off
			loop
				producers.item.join
				producers.forth
			end
		end
		
	terminate_consumers is
			-- Stop all consumer threads
		do			
			debug ("producer_consumer")
				print ("Terminating consumers...%N") 
			end
			from
				consumers.start
			until
				consumers.off
			loop
				consumers.item.terminate
				consumers.forth
			end
			condition.broadcast
			from
				consumers.start
			until
				consumers.off
			loop
				consumers.item.join
				consumers.forth
			end
		end
		
invariant
	
	producer_list_not_void: producers /= Void
	consumer_list_not_void: consumers /= Void
	correct_producer_count: producers.capacity = producer_count 
		and producers.count <= producer_count
	correct_consumer_count: consumers.capacity = consumer_count 
		and consumers.count <= consumer_count
	
end -- class PRODUCER_CONSUMER_CONTROL
