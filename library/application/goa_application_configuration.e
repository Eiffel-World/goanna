indexing
	description: "Configuration information required for GOA_APPLICATION_SERVER"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_APPLICATION_CONFIGURATION
	
inherit
	
	GOA_TRANSACTION_MANAGEMENT
	KL_SHARED_FILE_SYSTEM

feature -- Page Sequencing
	
	next_page (processing_result: REQUEST_PROCESSING_RESULT): GOA_DISPLAYABLE_SERVLET is
			-- What is the next page to display to the user?
		require
			valid_processing_result: processing_result /= Void and then processing_result.was_processed
			not_ok_to_read_write_data: implements_transaction_and_version_access implies not (ok_to_read_data (processing_result) or ok_to_write_data (processing_result))
		deferred
		ensure
			valid_result: Result /= Void
			not_ok_to_read_write_data: implements_transaction_and_version_access implies not (ok_to_read_data (processing_result) or ok_to_write_data (processing_result))
		end
		
feature -- Deferred Features

	data_directory: STRING is
			-- Directory containing directory data files; must exist and be writable
			-- Include trailing directory separator
		deferred
		end

	internal_test_mode: BOOLEAN is
			-- This configuration should run in "test mode"
		deferred
		end
		
	port: INTEGER is
			-- Server connection port
		deferred
		end

feature -- Attributes

	over_ride_test_mode: BOOLEAN
			-- Run in test mode, even if internal test mode is False

	use_saxon: BOOLEAN
			-- Use Saxon as the XSLT processor
			
	servlet_configuration: GOA_SERVLET_CONFIG
			-- Goanna configuration
			
	test_mode: BOOLEAN is
			-- Run in test mode
		do
			Result := internal_test_mode or over_ride_test_mode
		end
		
	bring_down_server_exception_description: STRING is "Shut Down Server"
			-- Description of developer exception thrown to bring down the application
	
	bring_down_server: BOOLEAN
			-- Should we bring down the application?
			
	validate_email_domain: BOOLEAN is
			-- Should we validate the domain of emails submitted by the user
			-- Program 'dig' must be available in the execution path of the system
		deferred
		end
			
feature -- Configuration Setting
		
	set_servlet_configuration (new_servlet_configuration: like servlet_configuration) is
			-- Set servlet_configuration to new_servlet_configuration
		require
			valid_new_servlet_configuration: new_servlet_configuration /= Void
		do
			servlet_configuration := new_servlet_configuration
		ensure
			servlet_configuration_updated: equal (servlet_configuration, new_servlet_configuration)
		end
		
	set_use_saxon is
			-- Set configuration to use saxon as the XSLT processor
		do
			use_saxon := True
		end
		
	set_over_ride_test_mode is
			-- Set configuration to run credit cards in test mode
		do
			over_ride_test_mode := True
		end
		
	set_bring_down_server is
			-- Set bring_down_server to True
			-- Will result in shut down of application
		do
			bring_down_server := True
		end
	
feature -- Constants

	session_status_attribute_name: STRING is "SESSION_STATUS"
	
	parameter_separator: CHARACTER is ':'

feature -- File Names
	
	temp_saxon_input_file_name: STRING is
			-- Name of temporary input file for transformations by Saxon
		once
			Result := data_directory + "saxon_input.xml"
		end
		
	temp_saxon_output_file_name: STRING is
			-- Name of temporary output fiel for transformations by Saxon
		once
			Result := data_directory + "saxon_output.xml"
		end

feature -- Transformation

	java_binary_location: STRING is
			-- file name of the java VM; include full path if not in execution path (e.g. /usr/java/j2re1.5.2_04/bin/java)
		once
			Result := "/usr/java/jre1.5.0_04/bin/java"
		end
		
	saxon_jar_file_location: STRING is
			-- Full path and file name to the saxon XSLT transformation jar file (.e.g. /opt/saxon/saxon8.jar)
		once
			Result := "/opt/saxon/saxon8.jar"
		end

feature -- Logging

	log_file_name: STRING is
			-- Name of file used to log servlet activity
		once
			Result := data_directory + "application.log"
		end
		
	illegal_requests_file_name: STRING is
			-- Name of file used to log full text of illegal requests
		once
			Result := data_directory + "illegal_requests.log"
		end

feature -- Servlet Names

	snoop_servlet_name: STRING is "snoop.htm"

feature -- Servlet Names

	fast_cgi_directory: STRING is 
			-- The directory configured to serve fast_cgi requests
		deferred
		end
		
feature -- Logging
		
	application_log_category: STRING is "app"
	
	application_security_log_category: STRING is "app_security"
	
feature -- Application Environment

	directory_separator: STRING is
			-- The character used to separate directories
		once
			if operating_system.is_windows then
				Result := "\"
			else
				Result := "/"
			end			
		end

invariant
	
	data_directory_is_readable: file_system.directory_exists (data_directory) and then file_system.is_directory_readable (data_directory)
	use_saxon_implies_valid_java_binary_location: use_saxon implies file_system.file_exists (java_binary_location)
	use_saxon_implies_valid_saxon_jar_file_location: use_saxon implies file_system.file_exists (saxon_jar_file_location)
		
end -- class GOA_APPLICATION_CONFIGURATION
