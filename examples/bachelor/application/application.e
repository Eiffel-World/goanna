indexing
	description: "Applications that run as FastCGI Servlets"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI Applications"
	date: "$Date: 2001/05/10"
	revision: "$Revision$"
	author: "Neal L. Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Lockheed-Martin Space System Company"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	APPLICATION

inherit
	SYSTEM_CONSTANTS
	
--	FAST_CGI_SERVLET_APP
--		rename
--			make as parent_make
--		end

	HTTPD_SERVLET_APP
		rename
			make as parent_make
		end
		
creation

	make

feature

	make is
		do
			io.putstring ("Starting Application " + application_directory + "...%N")
			parent_make (port, backlog_requests)	
			register_servlets
			run
		end

	register_servlets is
			-- Register servlets for this application
		local
			application_config: SERVLET_CONFIG
			application_servlet: APPLICATION_SERVLET
		do
			create application_config
			application_config.set_server_port (port)
			application_config.set_document_root (application_directory)
			servlet_manager.set_config (application_config)
			create application_servlet.init (application_config)
			servlet_manager.register_servlet (application_servlet, application_directory)
			servlet_manager.register_default_servlet (application_servlet)
		end
		
end -- class APPLICATION
