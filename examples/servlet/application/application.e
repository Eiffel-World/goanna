indexing
	description: "Example servlet application."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	APPLICATION
	
inherit

	GS_SERVLET_APPLICATION
		redefine
			default_create
		end
	
creation

	default_create

feature {NONE} -- Initialisation

	default_create is
			-- Initialise
		do
			create queue
			Precursor
		end
		
feature {NONE} -- Implementation

	register_servlets is
			-- Register all servlets for this application
		local
			servlet: HTTP_SERVLET
			config: SERVLET_CONFIG
		do
			create config
			create {SNOOP_SERVLET} servlet.init (config)
			manager.registry.register_servlet (servlet, "snoop")
		end
		
	register_security is
			-- Register all security realms
		do
		end
		
	register_producers is
			-- Register all producers
		local
			producer: GS_REQUEST_PRODUCER
			fast_cgi: GS_FAST_CGI_CONNECTOR
			standalone: GS_STANDALONE_CONNECTOR
		do			
			-- FastCGI connector on 9090
--			create fast_cgi.make (9090, 5)
--			create producer.make (Current, fast_cgi, queue)
--			processor.add_producer (producer)
			
			-- Standalone connector on 9080
			create standalone.make (9000, 5, "d:\temp", "")
			create producer.make ("producer-1", Current, standalone, queue)
			processor.add_producer (producer)
		end
		
	register_consumers is
			-- Register all consumers
		local
			c: INTEGER
			consumer: GS_REQUEST_CONSUMER
		do
			from
				c := 1
			until
				c > 1
			loop
				create consumer.make ("consumer-" + c.out, Current, queue)
				processor.add_consumer (consumer)
				c := c + 1
			end
		end

feature {NONE} -- Implementation

	queue: THREAD_SAFE_QUEUE [GS_QUEUED_REQUEST]
			-- Request queue
			
end -- class APPLICATION

