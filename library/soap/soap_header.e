indexing
	description: "Objects that represent a SOAP envelope header."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_HEADER

inherit
	
	SOAP_ELEMENT

create
	make, unmarshall

feature -- Initialisation

	unmarshall (node: DOM_NODE) is
			-- Initialise SOAP header from DOM node.
		do
			make
		end
		
feature -- Marshalling

	marshall (sink: IO_MEDIUM) is
			-- Serialize this envelope on 'sink' in XML format
		do

		end
		
end -- class SOAP_HEADER