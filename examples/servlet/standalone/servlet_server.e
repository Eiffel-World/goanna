indexing
	description: "Example servlet server for dispatching servlet requests."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SERVLET_SERVER
	
inherit

	HTTPD_SERVLET_APP
		rename
			make as parent_make
		end
		
	KL_SHARED_ARGUMENTS
		export
			{NONE} all
		end
	
creation

	make

feature -- Initialization

	make is
			-- Create and initialise a new server that will listen for connections
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
			print ("Usage: servlet_server <port-number> <document-root>%R%N")
		end
	

	register_servlets is
			-- Initialise servlets
		local
			servlet: HTTP_SERVLET	
		do
			-- register servlets
			servlet_manager.set_servlet_mapping_prefix ("servlet")
			servlet_manager.set_config (config)
			create {FILE_SERVLET} servlet.init (config)
			servlet_manager.register_servlet (servlet, "file")
			servlet_manager.register_default_servlet (servlet)
			create {SNOOP_SERVLET} servlet.init (config)
			servlet_manager.register_servlet (servlet, "snoop")

			-- Harald's test servlets
			create {TEST_SERVLET_OK} servlet.init (config)
			servlet_manager.register_servlet (servlet, "ok")
			create {TEST_SERVLET_ERR} servlet.init (config)
			servlet_manager.register_servlet (servlet, "err")
		end

end -- class SERVLET_SERVER
