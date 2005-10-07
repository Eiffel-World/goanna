indexing
	description: "A servlet that processes requests to go directly to another page"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

class
	GOA_GO_TO_SERVLET
	
inherit
	
	GOA_APPLICATION_SERVLET
		redefine
			make
		end
	GOA_NON_DATABASE_ACCESS_TRANSACTION_MANAGEMENT
	
creation
	
	make
	
feature

	name: STRING is "go_to.htm"

feature {NONE} -- Creation
	
	make is
			-- Creation
		do
			Precursor
			expected_parameters.force_last (page_parameter.name)
		end
		
end -- class GOA_GO_TO_SERVLET
