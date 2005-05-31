indexing
	description: "Objects that hold essence of a SOAP Fault"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Colin Adams <colin@colina.demon.co.uk>"
	copyright: "Copyright (c) 2005 Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	GOA_SOAP_FAULT_INTENT

inherit

	GOA_SOAP_FAULTS

create

	make

feature {NONE} -- Initialization

	make (a_code: INTEGER; a_text, a_language: STRING; a_node_uri, a_role_uri: UT_URI; a_detail: ANY) is
			-- Establish invariant.
		require
			text_not_empty: a_text /= Void and then not a_text.is_empty
			language_not_empty: a_language /= Void and then not a_language.is_empty
			valid_code: is_valid_fault_code (a_code)
			node_uri_not_void: a_role_uri /= Void and then not STRING_.same_string (a_role_uri.full_reference, Role_ultimate_receiver) implies a_node_uri /= Void
		do
		end

end -- class GOA_SOAP_FAULT_INTENT
