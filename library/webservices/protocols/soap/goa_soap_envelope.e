indexing
	description: "Objects that represent a SOAP envelope."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	GOA_SOAP_ENVELOPE

inherit
	
	GOA_SOAP_ELEMENT
		redefine
			validate
		end

creation
	
	make_root, construct, construct_with_header
	
feature -- Initialisation

	construct_with_header (a_header: GOA_SOAP_HEADER; a_body: GOA_SOAP_BODY) is
			-- Initialise envelope with header and body
		require
			header_exists: a_header /= Void
			body_exists: a_body /= Void
		do
			-- TODO
		end
	
	construct (a_body: GOA_SOAP_BODY) is
			-- Initialise envelope with body
		require
			body_exists: a_body /= Void
		do
			-- TODO
		end	
		
	
feature -- Access

	header: GOA_SOAP_HEADER
			-- Envelope header. `Void' if no header
			
	body: GOA_SOAP_BODY
			-- Envelope body

feature -- Status report

	validation_complete: BOOLEAN
			-- Has `validate' finished?

feature -- Status Setting

	set_header (a_header: like header) is
			-- Set 'header' to 'a_header'
		require
			new_header_exists: a_header /= Void
		do
			header := a_header
		ensure
			header_set: header = a_header
		end
		
	set_body (a_body: like body) is
			-- Set 'body' to 'a_body'
		require
			new_body_exists: a_body /= Void
		do
			body := a_body
		ensure
			body_set: body = a_body
		end

	validate is
			-- Validate `Current'.
		local
			child_elements: DS_LIST [XM_ELEMENT]
			a_count: INTEGER
		do
			Precursor
			if validated then check_encoding_style_attribute (Void, Void) end
			if validated then
				child_elements := elements
				a_count := child_elements.count
				if a_count = 0 then
					set_validation_fault (Sender_fault, "Missing env:Body element", Void, Void)
				elseif a_count > 2 then
					set_validation_fault (Sender_fault, "Too many child elements in env:Envelope", Void, Void)
				elseif a_count = 2 then
					header ?= elements.item (1)
					if header = Void then
						set_validation_fault (Sender_fault, "First child element of env:Envelope is not env:Header", Void, Void)
					else
						body ?= elements.item (2)
						if body = Void then
							set_validation_fault (Sender_fault, "Second child element of env:Envelope is not env:Body", Void, Void)
						end
					end
				else
					body ?= elements.item (1)
					if body = Void then
						set_validation_fault (Sender_fault, "Sole child element of env:Envelope is not env:Body", Void, Void)
					end
				end
				if validated then
					if header /= Void then
						header.validate
						if not header.validated then
							validated := False; validation_fault := header.validation_fault
						end
					end
				end
				if validated then
					body.validate
					if not body.validated then
						validated := False; validation_fault := body.validation_fault
					end
				end
			end
			validation_complete := True
		end

invariant

	body_exists: validation_complete and then validated implies body /= Void
	
end -- class GOA_SOAP_ENVELOPE
