indexing
	description: "XMLRPC Example Server."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples xmlrpc"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	XMLRPC

inherit

	HTTPD_SERVLET_APP
		rename
			make as parent_make
		end
		
	KL_SHARED_ARGUMENTS
		export
			{NONE} all
		end
	
	
	SHARED_SERVICE_REGISTRY
		export
			{NONE} all
		end
	
	XRPC_CONSTANTS
		export
			{NONE} all
		end
		
creation
	make

feature -- Initialization

	make is
			-- Create and initialise a new HTTP server that will listen for connections
			-- on 'port' and serving documents from 'doc_root'.
			-- Start the server
		do
			create config
			parse_arguments
			if argument_error then
				print_usage
			else
				config.set_server_port (port)
				parent_make (port, 10)
				register_servlets
				init_xmlrpc
				run
			end
		end

feature -- Status report

	port: INTEGER
			-- Server connection port
				
feature {NONE} -- Implementation

	argument_error: BOOLEAN
			-- Did an error occur parsing arguments?

	config: SERVLET_CONFIG
			-- Configuration for servlets
			
	parse_arguments is
			-- Parse the command line arguments and store appropriate settings
		local
			dir: KL_DIRECTORY
		do
			if Arguments.argument_count < 2 then
				argument_error := True
			else
				-- parse port
				if Arguments.argument(1).is_integer then
					port := Arguments.argument(1).to_integer
					-- parse document root
					create dir.make (Arguments.argument (2))
					dir.open_read
					if dir.is_open_read then
						config.set_document_root (dir.name)
					else
						argument_error := True
					end
				else
					argument_error := True
				end
			end
		end

	print_usage is
			-- Display usage information
		do
			print ("Usage: xmlrpc <port-number> <document-root>%R%N")
		end
	
	register_servlets is
			-- Initialise servlets
		local
			servlet: HTTP_SERVLET	
		do
			log_hierarchy.category (Xmlrpc_category).info ("Registering servlets")
			
			servlet_manager.set_servlet_mapping_prefix ("servlet")
			servlet_manager.set_config (config)
			create {XMLRPC_SERVLET} servlet.init (config)
			servlet_manager.register_servlet (servlet, "xmlrpc")
			servlet_manager.register_default_servlet (servlet)
		end
		
	init_xmlrpc is
			-- Initialise XML RPC calls
		local
			system_services: XRPC_SYSTEM
			addresses: ADDRESS_REGISTER
			test: TEST
			validator: VALIDATOR1
			calculator: CALCULATOR
			calculator_service: SERVICE_PROXY
		do
			log_hierarchy.category (Xmlrpc_category).info ("Registering XML-RPC web services")

			-- register introspection services
			create system_services.make
			registry.register (system_services, "system")
			
			-- TEST is a self registering service
			create test.make
			registry.register (test, "test")
			
			-- VALIDATOR1 is a self registering service
			create validator.make
			registry.register (validator, "validator1")
			
			-- ADDRESS_REGISTER is a self registering service
			create addresses.make
			registry.register (addresses, "addressbook")
			
			-- CALCULATOR needs to be registered manually
			create calculator
			create calculator_service.make
			calculator_service.register (agent calculator.times, "times")
			calculator_service.register (agent calculator.divide, "divide")
			calculator_service.register (agent calculator.minus, "minus")
			calculator_service.register (agent calculator.plus, "plus")
			registry.register (calculator_service, "calc")
		end

end -- class XMLRPC
