indexing
	description: "Demonstration of Goanna Web Application Framework"
	author: "Neal L. Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) 2005 Neal L. Lester and others"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	APPLICATION_SERVER

inherit

	GOA_APPLICATION_SERVER
	GOA_FAST_CGI_SERVLET_APP
		undefine
			initialise_logger
		end
	SHARED_SERVLETS
		
create

	application_make
	
feature
	
	command_line_ok: BOOLEAN is
		local
			a_host: VIRTUAL_DOMAIN_HOST
		do
			create active_configuration
			touch_configuration
			create a_host
			a_host.set_host_name (configuration.default_virtual_host_lookup_string)
			register_virtual_domain_host (a_host, configuration.default_virtual_host_lookup_string)
			Result := True
		end

	register_servlets is
		do
			register_servlet (question_servlet)
			register_servlet (answer_servlet)
		end
		
end -- class MSP_SERVER
