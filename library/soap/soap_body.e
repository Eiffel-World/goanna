indexing
	description: "Objects that represent a SOAP envelope body."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_BODY

inherit
	
	SOAP_ELEMENT

create
	make, unmarshall

feature -- Initialisation

	unmarshall (node: DOM_NODE) is
			-- Initialise SOAP header from DOM node.
		local
			root, temp_element: DOM_ELEMENT
			body_entries: like entries
		do
			make
			root ?= node
			check root /= Void end
			unmarshall_attributes (root)
			from
				temp_element ?= root.first_child
				create body_entries.make_default
			until
				temp_element = Void
			loop
				body_entries.force_last (temp_element)
				temp_element ?= temp_element.next_sibling
			end
			set_entries (body_entries)
		end
		
feature -- Marshalling

	marshall (sink: IO_MEDIUM) is
			-- Serialize this envelope on 'sink' in XML format
		do

		end
		
end -- class SOAP_BODY
