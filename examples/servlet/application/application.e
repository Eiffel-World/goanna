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
	
creation

	default_create

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
		
	register_processors is
			-- Register all processors and their connectors
		local
			processor: GS_REQUEST_PROCESSOR
			fast_cgi: GS_FAST_CGI_CONNECTOR
			standalone: GS_STANDALONE_CONNECTOR
		do
			-- FastCGI connector on 9090
			create processor.make (Current, "fast_cgi_1")
			create fast_cgi.make (9090, 5)
			processor.set_connector (fast_cgi)
			add_processor (processor)
			-- Standalone connector on 9080
			create processor.make (Current, "standalone_1")
			create standalone.make (9000, 5, "d:\temp", "")
			processor.set_connector (standalone)
			add_processor (processor)
		end

end -- class APPLICATION

