indexing
	description: "System's root class";
	note: "Initial version automatically generated"

class
	SERVLET_SERVER
	
inherit

	FAST_CGI_SERVLET_APP	
		rename
			make as fast_cgi_servlet_app_make
		export
			{NONE} fast_cgi_servlet_app_make
		end	

	KL_SHARED_ARGUMENTS
		export
			{NONE} all
		end
		
creation

	make

feature -- Initialisation

	make is
			-- Initialise application and begin request processing loop
		local
			config: SERVLET_CONFIG
			test_servlet: HTTP_SERVLET
			
		do
			fast_cgi_servlet_app_make (Arguments.argument (1).to_integer, Arguments.argument (2).to_integer)
			create config
			create {TEST_SERVLET} test_servlet.init (config)
			register_servlet (test_servlet, "basic")
			create {XMLE_TEST_SERVLET} test_servlet.init (config)
			register_servlet (test_servlet, "xmle")
			create {DOM_TEST_SERVLET} test_servlet.init (config)
			register_servlet (test_servlet, "dom")
			run
		end
		
end -- class SERVLET_SERVER
