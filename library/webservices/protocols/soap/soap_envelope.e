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
		rename
			make as element_make
		export
			{NONE} element_make
		end
	
creation
	
	make, unmarshall
	
feature -- Initialisation

	make is
			-- Initialise with default namespace declarations
		do
			element_make
			declare_namespace (Ns_pre_soap_env, Ns_uri_soap_env)
			declare_namespace (Ns_pre_schema_xsi, Ns_uri_schema_xsi_2001)
			declare_namespace (Ns_pre_schema_xsd, Ns_uri_schema_xsd_2001)
		end
		
	unmarshall (node: DOM_NODE) is
			-- Initialise SOAP header from DOM element.
		local
			root: DOM_ELEMENT
			header_element, body_element, temp_element: DOM_ELEMENT
			new_entries: like entries
		do
			element_make
			root ?= node
			check root /= Void end
			if Q_elem_envelope.matches (root) then
				-- deserialize attributes into this element.
				unmarshall_attributes (root)
				-- deserialize sub-elements
				temp_element ?= root.first_child
				check temp_element /= Void end
				if Q_elem_header.matches (temp_element) then
					header_element := temp_element
					temp_element ?= header_element.next_sibling
				end
				if Q_elem_body.matches (temp_element) then
					body_element := temp_element
					temp_element ?= body_element.next_sibling
				end
				-- deserialize header if found
				if header_element /= Void then
					create header.unmarshall (header_element)
				end
				if body_element /= Void then
					create body.unmarshall (body_element)
				end
				-- deserialize any further elements to entries collection
				if temp_element /= Void then
					from
						create new_entries.make_default
					until
						temp_element = Void
					loop
						new_entries.force_last (temp_element)
						temp_element ?= temp_element.next_sibling
					end
					set_entries (new_entries)
				end
			end	
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
	
invariant
	
	attributes_exists: attributes /= Void
	
end -- class SOAP_ENVELOPE
