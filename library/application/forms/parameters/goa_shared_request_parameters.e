indexing
	description: "Shared access to request parameters; SHARED_GOA_REQUEST_PARAMETERS should inherit from this class"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_SHARED_GOA_REQUEST_PARAMETERS
	
feature
	
	request_parameters: DS_HASH_TABLE [GOA_DEFERRED_PARAMETER, STRING] is
			-- form parameters, indexed by parameter_name
		once
			create Result.make_equal (50)
		end

	standard_submit_parameter: GOA_DEFERRED_PARAMETER is
--			-- This is the parameter in the system 
		deferred
		end

invariant
	
	valid_request_parameters: request_parameters /= Void

end -- class GOA_SHARED_GOA_REQUEST_PARAMETERS
