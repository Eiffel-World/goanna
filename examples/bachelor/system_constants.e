indexing
	description: "Constants used by the entire application"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI Applications"
	date: "$Date: 2001/05/10"
	revision: "$Revision$"
	author: "Neal L. Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Lockheed-Martin Space System Company"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SYSTEM_CONSTANTS
	
inherit
	KL_SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Drive & directory locations

	data_directory : STRING is 
			-- The directory where data files are stored
		once
			Result := Execution_environment.interpreted_string ("$GOANNA\examples\bachelor\data")
		end

	directory_separator : STRING is "\"

feature -- URL's for this application

	web_server_url : STRING is "http://localhost"
		-- The URL for the web_server hosting this application
		
feature -- Subdirectories for this application

	fast_cgi_directory : STRING is "servlet"
		-- The Apache subdirectory mapped to FastCGI applications; does not include directory separators

	application_directory : STRING is "bachelor"
		-- The FastCGI subdirectory that maps to this servlet; does not include directory separators

feature -- Application Configuration

	port : INTEGER is 80
		-- The port the application uses to communicate with the FastCGI

	backlog_requests : INTEGER is 5
		-- The number of queued requests the servlet can accommodate

	session_timeout_interval : INTEGER is 900
		-- The number of seconds of inactivity before a session expires

------------ Modifications Below This Line Normally Not Required ----------------------


	web_file_name : STRING is 
		-- The subdirectory mapped to the application's GET request processor
		do
			result := fast_cgi_directory + "/" + application_directory
		end

	web_form_name : STRING is
		-- The subdirectory mapped to the application's POST request processor
		do
			result := fast_cgi_directory + "/" + application_directory
		end

feature -- File names

	file_extension : STRING is ".sto"
		-- The extension added to data files

	unique_query_string_factory_file_name : STRING is
		-- The file name used to store the current unique query string values
		do
			Result := data_directory + directory_separator +"unique_query_string_factory_file" + file_extension
		end

	unique_request_string_factory_file_name : STRING is
		-- The file name used to store the current unique request identifier string
		do
			Result := data_directory + directory_separator + "unique_request_string_factory_file" + file_extension
		end

	unique_form_element_name_factory_file_name : STRING is
		-- The file name used to store the current unique name identifier string
		do
			Result := data_directory + directory_separator + "unique_form_element_name_factory_file" + file_extension
		end

	unique_to_do_anchor_factory_file_name : STRING is
		-- The file name used to store current unique to_do anchors
		do
			result := data_directory + directory_separator + "unique_to_do_anchor_factory_file" + file_extension
		end

	unique_goanna_session_identifier_factory_file_name : STRING is
		-- The file name used to store goanna_session_identifiers
		do
			result := data_directory + directory_separator + "unique_goanna_session_identifier_factory_file" + file_extension
		end

	user_list_file_name : STRING is
		-- The file name used to store the storable user_list
		do
			Result := data_directory + directory_separator + "user_list" + file_extension
		end

	user_file_name_file : STRING is
		-- Used to store current vallue of the user_file_name_sequence
		do
			Result := data_directory + directory_separator + "user_file_name_file" + file_extension
		end

feature -- string contants

		new_line : STRING is
				-- string containing only a new line character
			local
				temp_new_line : CHARACTER
			once
				temp_new_line := '%N'
				Result := temp_new_line.out
			end
	
end -- class SYSTEM_CONSTANTS