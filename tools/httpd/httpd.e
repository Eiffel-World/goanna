indexing
	description: "HTTP Server."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	HTTPD

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
				init_soap
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
			print ("Usage: httpd <port-number> <document-root>%R%N")
		end
	
	register_servlets is
			-- Initialise servlets
		local
			servlet: HTTP_SERVLET	
		do
			servlet_manager.set_servlet_mapping_prefix ("servlet")
			servlet_manager.set_config (config)
			create {FILE_SERVLET} servlet.init (config)
			servlet_manager.register_default_servlet (servlet)
			servlet_manager.register_servlet (servlet, "file")
			create {TEST_SERVLET} servlet.init (config)
			servlet_manager.register_servlet (servlet, "basic")
			-- XMLE and SOAP are not compatible with SmallEiffel because
			-- they uses object serialization and agents
--			create {XMLE_TEST_SERVLET} servlet.init (config)
--			servlet_manager.register_servlet (servlet, "xmle")
			create {DOM_TEST_SERVLET} servlet.init (config)
			servlet_manager.register_servlet (servlet, "dom")
			create {SOAP_SERVLET} servlet.init (config)
			servlet_manager.register_servlet (servlet, "soap")
			create {SNOOP_SERVLET} servlet.init (config)
			servlet_manager.register_servlet (servlet, "snoop")
		end
		
	init_soap is
			-- Initialise SOAP RPC calls
		local
			account_service: SERVICE
			account: SOAP_ACCOUNT
		do
			create account
			create account_service.make (account)
			account_service.agent_registry.register ("deposit", account, account~deposit(?))
			account_service.agent_registry.register ("withdraw", account, account~withdraw(?))
			registry.register ("account", account_service)
		end
		

end -- class HTTPD
