indexing
	description: "The result of processing a request from the user"
	author: "Neal L. Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) 2005 Neal L. Lester and others"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	REQUEST_PROCESSING_RESULT
	
inherit
	
	GOA_REQUEST_PROCESSING_RESULT
	SHARED_REQUEST_PARAMETERS
	SHARED_SERVLETS
	
creation
	
	make

end -- class REQUEST_PROCESSING_RESULT
