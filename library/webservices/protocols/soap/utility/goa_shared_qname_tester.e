indexing
	description: "Objects that provide shared access to a qname tester."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Colin Adams <colin@colina.demon.co.uk>"
	copyright: "Copyright (c) 2005 Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_SHARED_QNAME_TESTER

	
feature -- Access

	qname_tester: GOA_QNAME_TESTER is
			-- QName tester
		once
			create Result
		ensure
			qname_tester_not_void: Result /= Void
		end

end -- class GOA_SHARED_QNAME_TESTER
