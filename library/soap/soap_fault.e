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

	SOAP_ELEMENT
		rename
			entries as detail_entries,
			set_entries as set_detail_entries
		redefine
			make
		end

create
	make, unmarshall

feature -- Initialization

	make is
			-- Initialise new SOAP envelope
		do
			create attributes.make_default
			create fault_entries.make_default
			create detail_entries.make_default
		end

	unmarshall (doc: DOM_ELEMENT) is
			-- Initialise SOAP fault from DOM element.
		do
		end

feature -- Access

	fault_actor: STRING
			-- Information about who causes the fault to happen within the message path. 
			-- Indicates the source of the fault.

	fault_string: STRING
			-- Human readable explanation of the fault.

	fault_code: STRING
			-- Provides an algorithmic mechanism for identifying the fault.

	fault_entries: DS_LINKED_LIST [DOM_ELEMENT]
			-- Child elements of this element.

feature -- Element change

	set_fault_actor (a_fault_actor: STRING) is
			-- Assign `a_fault_actor' to `fault_actor'.
		do
			fault_actor := a_fault_actor
		ensure
			fault_actor_assigned: fault_actor = a_fault_actor
		end

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

	set_fault_entries (new_entries: DS_LINKED_LIST [DOM_ELEMENT]) is
			-- Assign `new_entries' to `fault_entries'.
		require
			new_entries_exist: new_entries /= Void
		do
			fault_entries := new_entries
		ensure
			entries_assigned: fault_entries = new_entries
		end

feature -- Mashalling

	marshall (sink: IO_MEDIUM) is
			-- Serialize this envelope on 'sink' in XML format
		do	
		end

invariant
	
	fault_entries_exist: fault_entries /= Void
	
end -- class SOAP_FAULT
