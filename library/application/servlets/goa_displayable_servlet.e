indexing
	description: "An application servlet that may generate a response to the user"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	MSP_DISPLAYABLE_SERVLET
	
inherit
	
	GOA_DISPLAYABLE_SERVLET
		undefine
			perform_final_processing
		end
	MSP_SERVLET
	KL_SHARED_FILE_SYSTEM
	
feature -- Attributes

	ok_to_display (processing_result: REQUEST_PROCESSING_RESULT): BOOLEAN is
			-- Is it OK to display this servlet to the user?
		once
			Result := True
		end		
		
end -- class MSP_DISPLAYABLE_SERVLET
