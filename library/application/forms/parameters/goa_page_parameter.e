indexing
	description: "Parameter that directs user to a specific page"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_PAGE_PARAMETER
	
inherit
	
	GOA_NON_DISPLAYABLE_PARAMETER
	GOA_NON_DATABASE_ACCESS_PARAMETER
	GOA_SHARED_SERVLET_MANAGER
	SHARED_SERVLETS
	
creation
	
	make
	
feature

	name: STRING is "page"

	process (processing_result: PARAMETER_PROCESSING_RESULT) is
			-- Process this parameter
		local
			value: STRING
			servlet: GOA_DISPLAYABLE_SERVLET
		do
			value := processing_result.value
			if servlet_by_name.has (value) then
				servlet ?= servlet_by_name.item (value)
			end
			processing_result.request_processing_result.set_page_selected_servlet (servlet)
		end
		
end -- class GOA_PAGE_PARAMETER
