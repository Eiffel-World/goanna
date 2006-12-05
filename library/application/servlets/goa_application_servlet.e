indexing
	description: "Servlets for a Goanna Application"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class
	GOA_APPLICATION_SERVLET

inherit

	GOA_HTTP_SERVLET
		redefine
			do_get, do_post, log_service_error, service
		end
	GOA_SHARED_APPLICATION_CONFIGURATION
	GOA_TEXT_PROCESSING_FACILITIES
	EXCEPTIONS
	GOA_AUTHENTICATION_STATUS_CODE_FACILITIES
	L4E_SHARED_HIERARCHY
	GOA_SHARED_VIRTUAL_DOMAIN_HOSTS
	GOA_SHARED_SERVLET_MANAGER
	UT_STRING_FORMATTER
	GOA_TRANSACTION_MANAGEMENT
	KL_IMPORTED_STRING_ROUTINES
	SHARED_REQUEST_PARAMETERS
	SHARED_SERVLETS

feature -- Attributes

	name: STRING is
			-- Name of this servlet; used as file name portion of URL accessing this servlet
		deferred
		ensure
			contains_only_one_period: Result.occurrences ('.') <= 1
			no_spaces: not Result.has (' ')
			-- TODO Add some better validity checks
		end

	name_without_extension: STRING is
			-- The name of this servlet, without the extension
		local
			period_index: INTEGER
		do
			Result := STRING_.cloned_string (name)
			if Result.has ('.') then
				period_index := Result.index_of ('.', 1)
				Result.keep_head (period_index -1)
			end
		end

	ok_to_process_servlet (processing_result: GOA_REQUEST_PROCESSING_RESULT): BOOLEAN is
			-- Does current user have permission to have this servlet processed?
			-- May be redefined in descendents as necessary
		require
			valid_processing_result: processing_result /= Void
		once
			Result := True
		end

	receive_secure: BOOLEAN
		-- This servlet should receive information from clients via SSL

feature -- Parameter Queries

	has_mandatory_parameter (the_parameter: STRING): BOOLEAN is
			-- Does servlet include the_parameter as a mandatory parameter?
		require
			valid_the_parameter: the_parameter /= Void and then not the_parameter.is_empty
		do
			Result := mandatory_parameters.has (the_parameter)
		end

	has_expected_parameter (the_parameter: STRING): BOOLEAN is
			-- Does servlet include the_parameter as a expected parameter?
		require
			valid_the_parameter: the_parameter /= Void and then not the_parameter.is_empty
		do
			Result := expected_parameters.has (the_parameter)
		end

	has_possible_parameter (the_parameter: STRING): BOOLEAN is
			-- Does servlet include the_parameter as a possible parameter?
		require
			valid_the_parameter: the_parameter /= Void and then not the_parameter.is_empty
		do
			Result := possible_parameters.has (the_parameter)
		end

	add_database_updated_message (processing_result: REQUEST_PROCESSING_RESULT) is
			-- Add message telling user database was updated
		require
			valid_processing_result: processing_result /= Void
			processing_result_was_processed: processing_result.was_processed
			transaction_or_version_access_open: ok_to_read_data (processing_result)
		do
			-- No message
		ensure
			transaction_or_version_access_open: ok_to_read_data (processing_result)
		end

feature -- Request Processing

	do_get (request: GOA_HTTP_SERVLET_REQUEST; response: GOA_HTTP_SERVLET_RESPONSE) is
			-- Called to allow the servlet to handle a GET request.
			-- Verify form elements in request conform to semantics required by this servlet
			-- Process each request parameter if request is valid
			-- Perform any post GOA_REQUEST_PARAMETER processing
			-- Determine next page and send response to browser
		local
--			page: EXTENDED_GOA_PAGE_XML_DOCUMENT
			servlet: GOA_DISPLAYABLE_SERVLET
			parameter_names: DS_LINEAR [STRING]
			parameter_name, raw_parameter_name, parameter_value: STRING
			session_status: SESSION_STATUS
			processing_result: REQUEST_PROCESSING_RESULT
			parameter_processing_result: PARAMETER_PROCESSING_RESULT
			current_parameter_is_legal, all_parameters_are_legal, all_mandatory_parameters_are_present, all_expected_parameters_are_present, all_parameters_are_present: BOOLEAN
			mandatory_parameters_in_request, expected_parameters_in_request: DS_LINKED_LIST [STRING]
			mandatory_processing_results, non_mandatory_processing_results: DS_LINKED_LIST [PARAMETER_PROCESSING_RESULT]
--			page_agent: FUNCTION [ANY, TUPLE [REQUEST_PROCESSING_RESULT], EXTENDED_GOA_PAGE_XML_DOCUMENT]
			temp_name: STRING
			failed_once, failed_twice: BOOLEAN
			suffix_list: DS_LINKED_LIST [INTEGER]

		do
			debug ("goa_application_servlet")
				io.put_string ("========" + generator + "%N")
			end
			if not failed_once then
				log_hierarchy.logger (configuration.application_log_category).info ("Request: " + name + client_info (request))
--				io.put_string ("Request: " + name + client_info (request) + "%N")
				-- Obtain session status and initialize if necessary
				session_status ?= request.session.get_attribute ("SESSION_STATUS")
				check
					valid_session_status: session_status /= Void
				end
				create processing_result.make (request, response, session_status, Current)
				if not session_status.initialized then
					session_status.initialize (processing_result)
				end
				if ok_to_process_servlet (processing_result) then
					create mandatory_parameters_in_request.make_equal
					create expected_parameters_in_request.make_equal
					create mandatory_processing_results.make
					create non_mandatory_processing_results.make
					-- Verify legality of each parameter;
					-- illegal input means user has submitted obsolete form (through back button)
					-- or there is a bug in the form (or form processor) or
					-- a hacker deliberately submitting illegal form data
					-- Validity of user input is checked during parameter processing (request_processor.process)
					parameter_names := request.get_parameter_names
					from
						parameter_names.start
						all_parameters_are_legal := True
					until
						parameter_names.after
					loop
						current_parameter_is_legal := True
						raw_parameter_name := parameter_names.item_for_iteration
						parameter_name := STRING_.cloned_string (raw_parameter_name)
--						io.put_string ("Raw Parameter_name: " + parameter_name + "%N")
						parameter_name.to_lower
						parameter_name := name_from_raw_parameter (parameter_name)
--						io.put_string ("Parameter_name: " + parameter_name + "%N")
						parameter_value := request.get_parameter (raw_parameter_name)
						-- Remove leading and trailing spaces from all input; normalize parameter name to lower case
						parameter_value.left_adjust
						parameter_value.right_adjust
						-- Cross check parameter name against mandatory, expected and possible parameter lists
						if mandatory_parameters.has (parameter_name) then
							if not mandatory_parameters_in_request.has (parameter_name) then
								mandatory_parameters_in_request.force_last (parameter_name)
							end
						elseif expected_parameters.has (parameter_name) then
							if not expected_parameters_in_request.has (parameter_name) then
								expected_parameters_in_request.force_last (parameter_name)
							end
						elseif possible_parameters.has (parameter_name) or add_if_absent_parameters.has (parameter_name) or pass_through_parameters.has (parameter_name) then
							-- This is a legal parameter
						else
							all_parameters_are_legal := False
							current_parameter_is_legal := False
							log_hierarchy.logger (configuration.application_security_log_category).info ("Illegal parameter [" + parameter_names.item_for_iteration + "] with value = %"" + request.get_parameter (parameter_names.item_for_iteration) + "%" received in servlet " + name)
						end
						if current_parameter_is_legal then
							-- Create a processing result for this parameter and add it to the request_processing_result
							create parameter_processing_result.make (raw_parameter_name, processing_result)
							processing_result.add_parameter_processing_result (parameter_processing_result, mandatory_parameters.has (parameter_name))
						end
						parameter_names.forth
					end
					-- Verify that all of the expected parameters are in fact present in the request
					all_mandatory_parameters_are_present := equal (mandatory_parameters.count, mandatory_parameters_in_request.count)
					all_expected_parameters_are_present := equal (expected_parameters.count, expected_parameters_in_request.count)
					all_parameters_are_present := all_mandatory_parameters_are_present and all_expected_parameters_are_present
					if not all_mandatory_parameters_are_present then
						log_hierarchy.logger (configuration.application_security_log_category).info ("Missing Mandatory Parameter(s)")
						if configuration.test_mode then
							io.put_string ("Missing Mandatory Parameters:%N")
							from
								mandatory_parameters.start
							until
								mandatory_parameters.after
							loop
								if not mandatory_parameters_in_request.has (mandatory_parameters.item_for_iteration) then
									io.put_string (mandatory_parameters.item_for_iteration + "%N")
								end
								mandatory_parameters.forth
							end
						end
					end
					if not all_expected_parameters_are_present then
						log_hierarchy.logger (configuration.application_security_log_category).info ("Missing Expected Parameter")
						if configuration.test_mode then
							io.put_string ("Missing Mandatory Parameters:%N")
							from
								expected_parameters.start
							until
								expected_parameters.after
							loop
								if not expected_parameters_in_request.has (expected_parameters.item_for_iteration) then
									io.put_string (expected_parameters.item_for_iteration + "%N")
								end
								expected_parameters.forth
							end
						end

					end
					all_parameters_are_legal := all_parameters_are_legal and all_parameters_are_present
					if all_parameters_are_legal then
						-- add any add_if_absent parameters which are in fact absent
						from
							add_if_absent_parameters.start
						until
							add_if_absent_parameters.after
						loop
							temp_name := add_if_absent_parameters.item_for_iteration
							start_version_access (processing_result)
								suffix_list := request_parameter_for_name (temp_name).suffix_list (processing_result)
							end_version_access (processing_result)
							from
								suffix_list.start
							until
								suffix_list.after
							loop
								if not processing_result.has_parameter_result (add_if_absent_parameters.item_for_iteration, suffix_list.item_for_iteration) then
									create parameter_processing_result.make (full_parameter_name (add_if_absent_parameters.item_for_iteration, suffix_list.item_for_iteration), processing_result)
									processing_result.add_parameter_processing_result (parameter_processing_result,  False)
								end
								suffix_list.forth
							end
							add_if_absent_parameters.forth
						end
						processing_result.process_parameters
						-- Perform additional processing
						if processing_result.was_updated then
							start_version_access (processing_result)
								add_database_updated_message (processing_result)
							end_version_access (processing_result)
						end
						if processing_result.all_mandatory_parameters_are_valid then
							perform_final_processing (processing_result)
						else
							perform_invalid_mandatory_parameters_processing (processing_result)
						end
					else
						-- I don't remember why I'm doing this, but it is necessary under certain circumstances!
						-- Neal
						processing_result.process_submit_parameter_if_present
					end
				end
				start_transaction (processing_result)
					servlet := configuration.next_page (processing_result)
				commit (processing_result)
			elseif not failed_twice then
				start_transaction (processing_result)
					servlet := configuration.next_page (processing_result)
				commit (processing_result)
			else
				servlet ?= servlet_manager.default_servlet
				if servlet = Void and then servlet_manager.default_servlet = Void then
					raise ("No default servlet; Please set servlet_manager.default_servlet")
				elseif servlet = Void then
					raise ("servlet_manager.default_servlet must conform to " + generating_type)
				end
			end
			debug ("goa_application_servlet")
				io.put_string ("Generating Servlet: " + servlet.name + "%N")
			end
			if session_status.virtual_domain_host.use_ssl and servlet.send_secure and not request.is_secure then
				-- We received an insecure request, but response must be sent via SSL
				-- Redirect client to an SSL page so they may obtain the response securely
				processing_result.session_status.set_secure_page (servlet)
--				io.put_string ("Redirect to: " +  + "%N")
				response.send_redirect (secure_redirection_servlet.hyperlink (processing_result, "Dummy Text").url)
			else
				servlet.send_response (processing_result)

			end
			session_status.set_has_served_a_page
			debug ("goa_application_servlet")
				io.put_string ("========" + generator + " response sent%N")
			end
		rescue
			if ok_to_write_data (processing_result) then
				commit (processing_result)
			elseif ok_to_read_data (processing_result) then
				end_version_access (processing_result)
			end
			if exception_is_shutdown_signal then
				-- Do Nothing; we want this propogate on up
			elseif not failed_once then
				log_hierarchy.logger (configuration.application_log_category).info (generator + " Failed Once")
				log_hierarchy.logger (configuration.application_log_category).info (exception_trace)
				-- TODO This should be done in a generic (not application specific) way.
				failed_once := True
				retry
			elseif not failed_twice then
				log_hierarchy.logger (configuration.application_log_category).info (generator + " Failed Twice")
				log_hierarchy.logger (configuration.application_log_category).info (exception_trace)
				failed_twice := True
				retry
			end
		end

	do_post (request: GOA_HTTP_SERVLET_REQUEST; response: GOA_HTTP_SERVLET_RESPONSE) is
			-- Called to allow the servlet to handle a POST request.
		do
			do_get (request, response)
		end

feature -- Linking

	hyperlink (processing_result: REQUEST_PROCESSING_RESULT; text: STRING): GOA_INTERNAL_HYPERLINK is
			-- A hyperlink to this servlet
		require
			valid_processing_result: processing_result /= Void
			valid_text: text /= Void
		do
			create Result.make (processing_result, Current, text)

-- I'm having trouble with compatibility with my Wizard Code; I'll have to rethink this later
-- Neal
--			if tool_tip (processing_result) /= Void	then
--				Result.set_tool_tip (tool_tip_class (processing_result), tool_tip (processing_result))
--			end
		end

	post_hyperlink (processing_result: REQUEST_PROCESSING_RESULT; text: STRING): GOA_EXTERNAL_HYPERLINK is
			-- A hyperlink to the this servlet
		require
			valid_processing_result: processing_result /= Void
			valid_text: text /= Void
		do
			create Result.make (processing_result.virtual_domain_host.host_name + configuration.fast_cgi_directory + name, text)
			if receive_secure then
				Result.set_secure
			end
		end

	post_url (processing_result: REQUEST_PROCESSING_RESULT): STRING is
			-- URL to which data should be posted for this servlet
		require
			valid_processing_result: processing_result /= Void
		do
			Result := "http"
			if receive_secure and processing_result.virtual_domain_host.use_ssl then
				Result.extend ('s')
			end
			Result.append ("://")
			Result.append (processing_result.virtual_domain_host.host_name + configuration.fast_cgi_directory + name)
		end

feature -- Suplementary Processing

	perform_post_mandatory_parameter_processing (processing_result: GOA_REQUEST_PROCESSING_RESULT) is
			-- Called after all mandatory parameters have been processed and verified valid
			-- but before other types of parameters (e.g. expected_parameters) have been processeed
			-- Descendents may redefine
		require
			valid_processing_result: processing_result /= Void
			all_mandatory_parameters_are_valid: processing_result.all_mandatory_parameters_are_valid
			not_ok_to_read_write_data: implements_transaction_and_version_access implies not (ok_to_read_data (processing_result) or ok_to_write_data (processing_result))
		do
			-- Default is do nothing
		ensure
			not_ok_to_read_write_data: implements_transaction_and_version_access implies not (ok_to_read_data (processing_result) or ok_to_write_data (processing_result))
		end

-- I'm having trouble with compatibility with my Wizard Code; I'll have to rethink this later

--	tool_tip_class (the_topic: PAGE_SEQUENCE_ELEMENT_TOPIC; processing_result: REQUEST_PROCESSING_RESULT): STRING is
			-- Class of the tool tip associated with this URL
--		require
--			valid_processing_result: processing_result /= Void
--		do
--			Result := Void
--		end

--	tool_tip (the_topic: PAGE_SEQUENCE_ELEMENT_TOPIC; processing_result: REQUEST_PROCESSING_RESULT): STRING is
--			-- Text of the tool tip associated with this URL
--		do
--			Result := Void
--		ensure
--			valid_result_implies_valid_tool_tip_class: Result /= Void implies tool_tip_class (processing_result) /= Void
--		end


	perform_final_processing (processing_result: GOA_REQUEST_PROCESSING_RESULT) is
			-- Called after all parameters in servlet form have completed their processing
			-- Note this means that all mandatory parameters must be valid for this to fire.
			-- Descendents may redefine
		require
			valid_processing_result: processing_result /= Void
			all_mandatory_parameters_are_valid: processing_result.all_mandatory_parameters_are_valid
			not_ok_to_read_write_data: implements_transaction_and_version_access implies not (ok_to_read_data (processing_result) or ok_to_write_data (processing_result))
		do
-- Nothing
		ensure
			not_ok_to_read_write_data: implements_transaction_and_version_access implies not (ok_to_read_data (processing_result) or ok_to_write_data (processing_result))
		end

	perform_invalid_mandatory_parameters_processing (processing_result: GOA_REQUEST_PROCESSING_RESULT) is
			-- Called after parameters in servlet form have completed their processing
			-- if one or more mandatory parameters in the servlet are invalid
			-- Note this means that other parameters (e.g. expected parameters) will not have performed their processing
			-- Descendents may redefine
		require
			valid_processing_result: processing_result /= Void
			all_mandatory_parameters_are_valid: not processing_result.all_mandatory_parameters_are_valid
			not_ok_to_read_write_data: implements_transaction_and_version_access implies not (ok_to_read_data (processing_result) or ok_to_write_data (processing_result))
		do
			-- Nothing by default
		ensure
			not_ok_to_read_write_data: implements_transaction_and_version_access implies not (ok_to_read_data (processing_result) or ok_to_write_data (processing_result))
		end

feature {GOA_PARAMETER_PROCESSING_RESULT} -- Parameter Semantics

	mandatory_parameters: DS_LINKED_LIST [STRING]
			-- Names of parameters that must all be valid for to allow processing of other parameters

	expected_parameters: DS_LINKED_LIST [STRING]
			-- Names of parameters that must be present in the request

	possible_parameters: DS_LINKED_LIST [STRING]
			-- Parameters that may or may not be present in the request

	add_if_absent_parameters: DS_LINKED_LIST [STRING]
			-- Parameters that should be added to the request if they are not present int he request

	pass_through_parameters: DS_LINKED_LIST [STRING]
			-- Parameters that are passed through to the processing result without processing them

feature -- Logging Facilities

	client_info (req: GOA_HTTP_SERVLET_REQUEST): STRING is
			-- A string describing the client the sent req
		require
			valid_req: req /= Void
		do
			Result := " [host: "
			if req.has_header ("HTTP_HOST") then
				Result.append (req.get_header ("HTTP_HOST"))
			else
				Result.append ("Not Available")
			end
			Result.append ("][client: ")
			if req.has_header ("REMOTE_HOST") then
				Result.append (req.get_header ("REMOTE_HOST"))
			else
				Result.append ("Not Available")
			end
			Result.append ("][client ip: ")
			if req.has_header ("REMOTE_ADDR") then
				Result.append (req.get_header ("REMOTE_ADDR"))
			else
				Result.append ("Not Available")
			end
			Result.append ("][Cookies: ")
			from
				req.cookies.start
			until
				req.cookies.after
			loop
				Result.append (req.cookies.item_for_iteration.name + "|")
				Result.append (req.cookies.item_for_iteration.value)
				req.cookies.forth
				if not req.cookies.after then
					Result.append (" ")
				end

			end
			Result.append ("][Content: ")
			if req.content /= Void then
				 Result.append (eiffel_string_out (req.content))
			end
			Result.append ("][Query String: ")
			if req.query_string /= Void then
				 Result.append (eiffel_string_out (req.query_string) + "]")
			end
		end

	log_service_error is
			-- Called if service routine generates an exception; may be redefined by descendents
		do
			if not exception_is_shutdown_signal then
				log_hierarchy.logger (configuration.application_log_category).info (generator + ".service:%N" + exception_trace)
			end
		end

	exception_is_shutdown_signal: BOOLEAN is
			-- Was the last developer exception a signal to shutdown the application
		do
			Result := equal (configuration.bring_down_server_exception_description, developer_exception_name)
		end

	service (req: GOA_HTTP_SERVLET_REQUEST; resp: GOA_HTTP_SERVLET_RESPONSE) is
			-- Handle a request by dispatching it to the correct method handler.
		do
			precursor (req, resp)
			if configuration.bring_down_server then
				raise (configuration.bring_down_server_exception_description)
				-- The default version of this routine will swallow the exception and continue serving requests
				-- So re-raise the exception here
			end
		end

feature {NONE} -- Creation

	make is
			-- Creation
		do
			servlet_by_name.force (Current, name_without_extension)
			check
				registered: servlet_by_name.has (name_without_extension)
			end
			create mandatory_parameters.make_equal
			create expected_parameters.make_equal
			create possible_parameters.make_equal
			create add_if_absent_parameters.make_equal
			create pass_through_parameters.make_equal
			possible_parameters.force_last (standard_submit_parameter.name)
			init (configuration.servlet_configuration)
		end

invariant

	valid_name: name /= Void and then not name.is_empty
	valid_mandatory_parameters: mandatory_parameters /= Void
	valid_expected_parameters: expected_parameters /= Void
	valid_possible_parameters: possible_parameters /= Void
	valid_add_if_absent_parameters: add_if_absent_parameters /= Void
	possible_parameters_has_submit: possible_parameters.has (standard_submit_parameter.name)
	is_registered: servlet_by_name.has (name_without_extension)


end -- class GOA_APPLICATION_SERVLET
