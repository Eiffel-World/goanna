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
	
	make, make_with_header, unmarshall
	
feature -- Initialisation

	make_with_header (new_header: SOAP_HEADER; new_body: SOAP_BODY) is
			-- Initialise envelope with header and body
		require
			new_header_exists: new_header /= Void
			new_body_exists: new_body /= Void
		do
			header := new_header
			body := new_body
			unmarshall_ok := True
		end
	
	make (new_body: SOAP_BODY) is
			-- Initialise envelope with body
		require
			new_body_exists: new_body /= Void
		do
			body := new_body
			unmarshall_ok := True
		end	
		
	unmarshall (node: XM_ELEMENT) is
			-- Initialise SOAP envelope from XML element.
		local
			header_elem, body_elem: XM_ELEMENT
			encoding_attr: XM_ATTRIBUTE
		do
			unmarshall_ok := True
			
			if node.is_root_node and node.name.is_equal (Envelope_element_name) then
				-- search for optional encodingStyle attribute
				unmarshall_encoding_style_attribute (node)
				if unmarshall_ok then
					-- search for a header element and unmarshall (optional)
					header_elem := get_named_element (node, Header_element_name)
					if header_elem /= Void then
						create header.unmarshall (header_elem)
						if not header.unmarshall_ok then
							unmarshall_ok := False
							unmarshall_fault := header.unmarshall_fault
						end
					end
					-- search for a body element and unmarshall. Only continue if header unmarshalling
					-- was ok.
					if unmarshall_ok then
						body_elem := get_named_element (node, Body_element_name)
						if body_elem /= Void then
							create body.unmarshall (body_elem)
							if not body.unmarshall_ok then
								unmarshall_ok := False
								unmarshall_fault := body.unmarshall_fault
							end
						else
							-- missing mandatory body element
							unmarshall_ok := False
							unmarshall_fault := create_fault (Client_fault_code, Missing_body_element_fault_code)
						end
					end
				end
			else
				unmarshall_ok := False
				unmarshall_fault := create_fault (Client_fault_code, Missing_envelope_element_fault_code)
			end
		end
	
feature -- Access

	header: SOAP_HEADER
			-- Envelope header. Void if no header
			
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

	marshall: STRING is
			-- Serialize this envelope to XML format
		do	
			create Result.make (100)
			-- start Envelope element
			Result.append ("<env:Envelope")
			-- add all globally used namespaces
			Result.append (" xmlns:env=%"http://www.w3.org/2001/09/soap-envelope%"")
			Result.append (" xmlns:enc=%"http://www.w3.org/2001/09/soap-encoding%"")
			Result.append (" xmlns:xs=%"http://www.w3.org/2001/XMLSchema%"")
			Result.append (" xmlns:xsi=%"http://www.w3.org/2001/XMLSchema-instance%"")
			-- add encoding style attribute if it exists
			if encoding_style /= Void then
				Result.append (encoding_style_attribute)
			end
			Result.append (">")
			-- marshall header if it exists
			if header /= Void then
				Result.append (header.marshall)
			end
			-- marshall body
			Result.append (body.marshall)
			-- end Envelope element
			Result.append ("</env:Envelope>")
		end
	
invariant

	body_exists: unmarshall_ok implies body /= Void
	
end -- class SOAP_ENVELOPE
