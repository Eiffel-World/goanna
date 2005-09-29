indexing
	description: "Interface for a parameters in an HTML form"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"
	
-- All parameters should be instantiated as once functions in class SHARED_GOA_REQUEST_PARAMETERS
-- Suffix may be used if the parameter is included in the request multiple times.
-- Suffix = 0 indicates there is only one occurence of the parameter in a request

deferred class
	GOA_DEFERRED_PARAMETER
	
inherit
	
	SHARED_GOA_REQUEST_PARAMETERS
	GOA_TEXT_PROCESSING_FACILITIES
	GOA_TRANSACTION_MANAGEMENT
	
feature -- Attributes

	name: STRING is
			-- Name of this request parameter; each parameter must have a unique name
		deferred
		ensure
			-- TODO Add logic that ensures that the name is valid (i.e. can legally be used as an HTML parameter name)
		end

feature -- Queries
		
	parameter_processing_result (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): PARAMETER_PROCESSING_RESULT is
			-- parameter processing result in processing_result corresponding to this parameter
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
		deferred
		ensure
			ok_to_read_data: ok_to_read_data (processing_result)
		end

	is_suffix_valid (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): BOOLEAN is
			-- Is suffix a valid value?
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
		deferred
		end

feature {GOA_PARAMETER_PROCESSING_RESULT, PARAMETER_PROCESSING_RESULT_COMPARATOR}-- Processing

	process (processing_result: PARAMETER_PROCESSING_RESULT) is
			-- Process the paramter
		require
			valid_processing_result: processing_result /= Void
			ok_to_process: ok_to_process (processing_result)
			is_suffix_valid: is_suffix_valid (processing_result.request_processing_result, processing_result.parameter_suffix)
		deferred
		ensure
			ok_to_process: ok_to_process (processing_result)
		end
		
	ok_to_process (processing_result: PARAMETER_PROCESSING_RESULT): BOOLEAN is
			-- Is it OK to process the paramter
		require
			valid_processing_result: processing_result /= Void
		deferred
		end

	processing_order: INTEGER is
			-- Integer that gives the order in which to process this parameter relative to others in the request
			-- Use the constants process_first - process_fifth
		deferred
		end

feature -- Parameter Value

	display_value (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
			-- The value of this parameter that will be displayed to the user
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
		deferred
		ensure
			valid_result: Result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
		end

	current_value (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
			-- Current value of the parameter in the data model.
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
		deferred
		ensure
			valid_result: Result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
		end

feature -- As XML

	add_to_document (xml: GOA_XML_DOCUMENT; processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER) is
			-- Add a representation of this parameter to xml
		require
			valid_xml: xml /= Void
			valid_processing_result: processing_result /= Void
			valid_suffix: is_suffix_valid (processing_result, suffix)
		deferred
		end

	ok_to_add (xml: GOA_XML_DOCUMENT): BOOLEAN is
			-- Would adding a representation of this parameter to xml at this point in the document conform with
			-- The schema for xml?
		require
			valid_xml: xml /= Void
		deferred
		end

	is_disabled (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): BOOLEAN is
			-- Should this parameter be displayed as disabled?
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
			is_suffix_valid: is_suffix_valid (processing_result, suffix)
		deferred
		ensure
			ok_to_read_data: ok_to_read_data (processing_result)
		end
		
	input_class (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
			-- CSS class to use with this parameter; Void if none
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
			is_suffix_valid: is_suffix_valid (processing_result, suffix)
		deferred
		ensure
			ok_to_read_data: ok_to_read_data (processing_result)
		end
		
	script_name (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
			-- Name of the script associated with this request parameter; Void if none
		require
			valid_processing_result: processing_result /= Void
			ok_to_read_data: ok_to_read_data (processing_result)
			is_suffix_valid: is_suffix_valid (processing_result, suffix)
		deferred
		ensure
			ok_to_read_data: ok_to_read_data (processing_result)
		end

feature -- To Be Removed

	is_a_dependency: BOOLEAN is
			-- Does this parameter change something in the database that may impact future evaluations
			obsolete "Application Specific Hack"
		deferred
		end

feature {NONE} -- Processing Order Constants

	process_first: INTEGER is 1
	process_second: INTEGER is 2
	process_third: INTEGER is 3
	process_fourth: INTEGER is 4
	process_fifth: INTEGER is 5
		
invariant
	
	valid_name: name /= Void and then not name.is_empty and then not (name.has (configuration.parameter_separator))
	is_registered: request_parameters.item (name) = Current
	valid_processing_order: process_first <= processing_order and processing_order <= process_fifth

end -- class GOA_DEFERRED_PARAMETER
