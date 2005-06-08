indexing
	description: "SOAP Request-Response Message Exchange Pattern"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Colin Adams <colin@colina.demon.co.uk>"
	copyright: "Copyright (c) 2005 Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	GOA_SOAP_REQUEST_RESPONSE_MEP

inherit

	GOA_SOAP_MESSAGE_EXCHANGE_PATTERN

create
	
	make

feature {NONE} -- Initialization

	make (a_role: UR_URI) is
			-- Establish invariant.
		local
			a_name: UT_URI
		do
			create a_name.make (Request_response_name_property)
			init (a_name, a_role)
		end
	
end -- class GOA_SOAP_REQUEST_RESPONSE_MEP

