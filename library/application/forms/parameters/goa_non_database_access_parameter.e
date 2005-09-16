indexing
	description: "A parameter that does not require access to an open database"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"

deferred class
	GOA_NON_DATABASE_ACCESS_PARAMETER
	
inherit
	
	GOA_DEFERRED_PARAMETER
	GOA_NON_DATABASE_ACCESS_TRANSACTION_MANAGEMENT

end -- class GOA_NON_DATABASE_ACCESS_PARAMETER
