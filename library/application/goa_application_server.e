indexing
	description: "Root class for Goanna Server Applications"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_APPLICATION_SERVER
	
inherit
	
	GOA_SERVLET_APPLICATION
		rename
			make as parent_make
		end
	GOA_SHARED_SERVLET_MANAGER
	GOA_SHARED_HTTP_SESSION_MANAGER
	GOA_HTTP_SESSION_EVENT_LISTENER
--	CHARACTER_MANIPULATION
	GOA_HTTP_UTILITY_FUNCTIONS
	POSIX_DAEMON
		rename
			random as posix_random,
			exceptions as posix_exceptions
		end
	GOA_SHARED_VIRTUAL_DOMAIN_HOSTS

feature

	make is
		do
			if command_line_ok and then configuration.test_mode then
				execute
			elseif command_line_ok then
				detach
			end
		end

	execute is
			-- Create and initialise a new FAST_CGI server that will listen for connections
			-- on 'port' and serving documents from 'doc_root'.
			-- Start the server
		local
			servlet_configuration: GOA_SERVLET_CONFIG
			the_posix_signal: POSIX_SIGNAL
--			posix_constants: expanded POSIX_CONSTANTS
		do
			if command_line_ok then
				create servlet_configuration
				servlet_configuration.set_server_port (configuration.port)
				servlet_configuration.set_document_root ("")
				configuration.set_servlet_configuration (servlet_configuration)
				parent_make (configuration.port, 10)
				register_servlets
				session_manager.register_event_listener (Current)
				create the_posix_signal.make (sigchld)
				the_posix_signal.set_child_stop (True)
				the_posix_signal.set_default_action
				the_posix_signal.apply
				run
			end
		end

    expiring (session: GOA_HTTP_SESSION) is
            -- 'session' is about to be expired.
		do
        	-- Nothing
        end

    expired (session: GOA_HTTP_SESSION) is
            -- 'session' has expired and has been removed from
            -- the active list of sessions
        do
        	-- Nothing
        end

    created (session: GOA_HTTP_SESSION) is
            -- 'session' has been created
		local
			session_status: SESSION_STATUS
		do
			create session_status.make
			session.set_attribute (configuration.session_status_attribute_name, session_status)
        end

    attribute_bound (session: GOA_HTTP_SESSION; name: STRING; attribute: ANY) is
            -- 'attribute' has been bound in 'session' to 'name'
		do
			-- Nothing
        end

    attribute_unbound (session: GOA_HTTP_SESSION; name: STRING; attribute: ANY) is
            -- 'attribute' has been unbound in 'session' from 'name'
		do
			-- Nothing
        end

	register_servlet (servlet: GOA_APPLICATION_SERVLET) is
			-- Register servlet
		require
			valid_servlet: servlet /= Void
		do
			servlet_manager.register_servlet (servlet, servlet.name)
		end
		
	command_line_ok: BOOLEAN is
			-- Command line has been parsed and is valid
			-- First load all configurations into configuration table indexed by configuration name
			-- Then append selected configuration name to shared_configuration_name
			-- The active configuration is then loaded into configuration as a shared once function
			-- Ensure all options have been set in configuration
			-- command_line_ok be implemented with a once function as it will
			-- Be called twice if in test mode
		deferred
		ensure
			valid_configuration: configuration /= Void
		end

end -- class GOA_APPLICATION_SERVER
