indexing
	description: "Shared access to request parameters; SHARED_REQUEST_PARAMETERS should inherit from this class"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

deferred class

	GOA_SHARED_REQUEST_PARAMETERS
	
feature -- Parameters

	standard_submit_parameter: GOA_STANDARD_SUBMIT_PARAMETER is
			-- Submit parameter that may be used in all html forms
		once
			create Result.make
		end
		
	page_parameter: GOA_PAGE_PARAMETER is
			-- Parameter used to provide direct hyperlinks to a servlet
		once
			create Result.make
		end
		

feature {NONE} -- Implementation
	
	request_parameters: DS_HASH_TABLE [GOA_DEFERRED_PARAMETER, STRING] is
			-- form parameters, indexed by parameter_name
		once
			create Result.make_equal (50)
		end

invariant
	
	valid_request_parameters: request_parameters /= Void

end -- class GOA_SHARED_REQUEST_PARAMETERS
