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

	unmarshall (doc: DOM_DOCUMENT) is
			-- Initialise SOAP header from DOM document.
		do
			
		end
		
feature -- Marshalling

	marshall (sink: IO_MEDIUM) is
			-- Serialize this envelope on 'sink' in XML format
		do

		end
		
end -- class SOAP_BODY
