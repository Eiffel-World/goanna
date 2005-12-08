indexing
	description: "Objects that process user input from request parameters"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class
	GOA_REQUEST_PARAMETER
	
inherit

	GOA_DEFERRED_PARAMETER
	L4E_SHARED_HIERARCHY
	
feature -- Attributes

	processing_order: INTEGER is
			-- Order in which to process the parameters
		once
			Result := process_third
		end

feature -- Values

	display_value (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
			-- display_value for this parameter (intended for presentation to the user)
			-- suffix is used for multiple parameters (e.g. after the colon - name:1, name:2 etc)
			-- Use 0 if no suffix
		do
			if processing_result.has_parameter_result (name, suffix) then
				Result := processing_result.parameter_value (name, suffix)
			else
				Result := current_value (processing_result, suffix)
			end
		end

feature -- Queries

	parameter_processing_result (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): PARAMETER_PROCESSING_RESULT is
			-- parameter processing result in processing_result corresponding to this parameter
		do
			Result := processing_result.parameter_processing_result (name, suffix)
		end
		
	is_suffix_valid (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): BOOLEAN is
			-- Is suffix a valid value.  Default is suffix = 0 (no suffix allowed)
		do
			Result := minimum_suffix (processing_result) <= suffix and suffix <= maximum_suffix (processing_result)
		end
		
	minimum_suffix (processing_result: REQUEST_PROCESSING_RESULT): INTEGER is
			-- The minimum valid suffix value
		once
			Result := 0
		end

	maximum_suffix (processing_result: REQUEST_PROCESSING_RESULT): INTEGER is
			-- The maximum valid suffix value
		once
			Result := 0
		end
		
	suffix_list (processing_result: REQUEST_PROCESSING_RESULT): DS_LINKED_LIST [INTEGER] is
			-- A list of all suffix values used for this parameter
		local
			index: INTEGER
			minimum_index, maximum_index: INTEGER
		do
			create Result.make_equal
			from
				minimum_index := minimum_suffix (processing_result)
				maximum_index := maximum_suffix (processing_result)
				index := minimum_index
			until
				index > maximum_index
			loop
				Result.force_last (index)
				index := index + 1
			end
		end

		
feature -- As XML
		
	is_disabled (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): BOOLEAN is
			-- Default is always enabled
		once
			Result := False
		end
		
	input_class (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
			-- CSS class for input of this parameter
			-- Void if none
		once
			Result := Void
		end
		
	script_name (processing_result: REQUEST_PROCESSING_RESULT; suffix: INTEGER): STRING is
			-- Name of the script associated with this request parameter; Void if none
		once
			Result := Void
		end
		
feature -- To be removed

	is_a_dependency: BOOLEAN is
		once
			Result := False
		end
		
feature {NONE} -- Creation

	make is
			-- Creation
		require
			name_not_registered: not request_parameters.has (name)
		do
			request_parameters.force (Current, name)
		end	

end -- class GOA_REQUEST_PARAMETER
