indexing
	description: "Objects that represent a SOAP envelope."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_ENVELOPE

inherit
	
	SOAP_ELEMENT
	
creation
	
	make, unmarshall
	
feature -- Initialisation

	unmarshall (element: DOM_ELEMENT) is
			-- Initialise SOAP header from DOM element.
		do
			
		end
	
feature -- Access

	header: SOAP_HEADER
			-- Envelope header
			
	body: SOAP_BODY
			-- Envelope body
	
feature -- Status Setting

	set_header (new_header: like header) is
			-- Set 'header' to 'new_header'
		require
			new_header_exists: new_header /= Void
		do
			header := new_header
		end
		
	set_body (new_body: like body) is
			-- Set 'body' to 'new_body'
		require
			new_body_exists: new_body /= Void
		do
			body := new_body
		end
		
feature -- Marshalling

	marshall (sink: IO_MEDIUM) is
			-- Serialize this envelope on 'sink' in XML format
		do
			
		end
	
	ref: SOAP_FAULT
	
invariant
	
	attributes_exists: attributes /= Void
	
end -- class SOAP_ENVELOPE
