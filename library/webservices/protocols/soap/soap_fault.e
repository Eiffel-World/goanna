indexing
	description: "Objects that represent a SOAP fault."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_FAULT

inherit

	SOAP_BLOCK
		rename
			make as block_make
		export
			{NONE} block_make
		redefine
			unmarshall, marshall
		end
	
creation

	make, make_with_detail, unmarshall

feature -- Initialization

	make (new_fault_code, new_fault_string: STRING) is
			-- Initialise new fault
		require
			new_fault_code_exists: new_fault_code /= Void
			new_fault_string_exists: new_fault_string /= Void
		do
			fault_code := new_fault_code
			fault_string := new_fault_string
			unmarshall_ok := True	
		end
		
	make_with_detail (new_fault_code, new_fault_string: STRING; new_detail_node: XM_ELEMENT) is
			-- Initialise new fault
		require
			new_fault_string_exists: new_fault_string /= Void
			new_fault_code_exists: new_fault_code /= Void
			new_fault_node_exists: new_detail_node /= Void
		do
			block_make (new_detail_node)
			fault_string := new_fault_string
			fault_code := new_fault_code
			unmarshall_ok := True	
		end

	unmarshall (init_node: XM_ELEMENT) is
			-- Initialise SOAP fault from XML node.
		do
			unmarshall_ok := True
		end

feature -- Access

	fault_string: STRING
			-- Human readable explanation of the fault.

	fault_code: STRING
			-- Provides an algorithmic mechanism for identifying the fault.
			
feature -- Element change

	set_fault_string (a_fault_string: STRING) is
			-- Assign `a_fault_string' to `fault_string'.
		do
			fault_string := a_fault_string
		ensure
			fault_string_assigned: fault_string = a_fault_string
		end

	set_fault_code (a_fault_code: STRING) is
			-- Assign `a_fault_code' to `fault_code'.
		do
			fault_code := a_fault_code
		ensure
			fault_code_assigned: fault_code = a_fault_code
		end

feature -- Mashalling

	marshall: STRING is
			-- Serialize this envelope to XML format
		do
			create Result.make (100)
			-- start Header element
			Result.append ("<env:Fault>")
			-- add faultcode element
			Result.append ("<faultcode>")
			Result.append (fault_code)
			Result.append ("</faultcode>")
			-- add faultstring element
			Result.append ("<faultstring>")
			Result.append (fault_string)
			Result.append ("</faultstring>")
			-- add actor if it exists
			if actor /= Void then
				Result.append ("<faultactor>")
				Result.append (actor.out)
				Result.append ("</faultactor>")
			end
			-- add detail nodes if they exist
			
			-- end element
			Result.append ("</env:Fault>")
		end

invariant
	
	fault_code_exists: unmarshall_ok implies fault_code /= Void
	fault_string_exists: unmarshall_ok implies fault_string /= Void
	
end -- class SOAP_FAULT
