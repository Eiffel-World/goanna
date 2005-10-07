indexing
	description: "Root class for Goanna Server Applications"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class
	GOA_APPLICATION_SERVER
	
inherit
	
	GOA_SERVLET_APPLICATION
	GOA_SHARED_SERVLET_MANAGER
	GOA_SHARED_HTTP_SESSION_MANAGER
	GOA_HTTP_SESSION_EVENT_LISTENER
	GOA_HTTP_UTILITY_FUNCTIONS
	POSIX_DAEMON
		rename
			random as posix_random,
			exceptions as posix_exceptions
		end
	GOA_SHARED_VIRTUAL_DOMAIN_HOSTS
	KL_SHARED_EXCEPTIONS
	L4E_SHARED_HIERARCHY
		rename
			warn as log_warn
		end
	L4E_SYSLOG_APPENDER_CONSTANTS

feature

	application_make is
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
			the_posix_signal: POSIX_SIGNAL
			snoop_servlet: GOA_SNOOP_SERVLET
		do
			if command_line_ok then
				make (configuration.port, 10)
				register_servlet (go_to_servlet)
				register_servlets
				if configuration.install_snoop_servlet then
					create snoop_servlet.init (configuration.servlet_configuration)
					servlet_manager.register_servlet (snoop_servlet, configuration.snoop_servlet_name)
				end
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
            -- Descendents may redefine to clean-up any open resources
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
			not_has_servlet: not servlet_manager.has_registered_servlet (servlet.name)
		do
			servlet_manager.register_servlet (servlet, servlet.name)
		end
		
	command_line_ok: BOOLEAN is
			-- Command line has been parsed and is valid
			-- First create (or assign an existing object to) application_configuration.
			-- Then call touch_configuration.
			-- Then register at least one VIRTUAL_DOMAIN_HOST using register_virtual_domain_host
			-- with the name matching
			-- APPLICATION_CONFIGURATION.default_virtual_host_lookup_string
			-- command_line_ok should be implemented with a once function as it will
			-- Be called twice if in test mode
		deferred
		ensure
			valid_configuration: configuration /= Void
		end
		
	go_to_servlet: GOA_GO_TO_SERVLET is
		deferred
		end

	field_exception: BOOLEAN is
			-- Should we attempt to retry?
		local
			developer_exception_name: STRING
		do
			developer_exception_name := exceptions.meaning (exceptions.developer_exception)
			if equal (configuration.bring_down_server_exception_description, developer_exception_name) then
				Result := False
			else
				-- The framework should catch and retry any exceptions before they reach here
				-- Thus, if we get here, it probably indicates a bug in the framework and not the application
				-- Best to fail at this point, at least for now
				log_hierarchy.logger (configuration.application_log_category).info (exceptions.exception_trace)
				Result := False
			end
			if not Result then
				log_hierarchy.logger (configuration.application_log_category).info ("Application Ending...")
			end
		ensure
			bring_down_implies_false: equal (configuration.bring_down_server_exception_description, exceptions.meaning (exceptions.developer_exception)) implies not Result
		end

	initialise_logger is
			-- Set logger appenders
		local
			syslog: L4E_APPENDER
			layout: L4E_LAYOUT
			application_log: L4E_FILE_APPENDER
			application_layout: L4E_PATTERN_LAYOUT
		do
		
			create {L4E_SYSLOG_APPENDER} syslog.make ("Syslog", "localhost", Log_user)
			create {L4E_PATTERN_LAYOUT} layout.make ("@d [@-6p] port: " + configuration.port.out + " @c - @m%N")
			syslog.set_layout (layout)
			log_hierarchy.logger ("goanna").add_appender (syslog) -- This is used by Goanna itself.
			log_hierarchy.logger ("goanna").set_priority (None_p) -- Change to Debug_p or whatever to get these.
			create application_log.make (configuration.log_file_name, True)
			create application_layout.make ("@d [@-6p] @c - @m%N")
			application_log.set_layout (application_layout)
			log_hierarchy.logger (configuration.application_log_category).add_appender (application_log)
			log_hierarchy.logger (configuration.application_log_category).set_priority (info_p)
			log_hierarchy.logger (configuration.application_security_log_category).add_appender (application_log)
			log_hierarchy.logger (configuration.application_security_log_category).set_priority (info_p)
		end

	none_p: L4E_PRIORITY is
			-- Prioty designates no events
		once
			create Result.make (1000000, "NONE")
		end
		

end -- class GOA_APPLICATION_SERVER
