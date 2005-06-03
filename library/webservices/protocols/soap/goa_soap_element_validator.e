indexing
	description: "Objects that represent a SOAP envelope."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	GOA_SOAP_ELEMENT_VALIDATOR

inherit
	
	XM_NODE_PROCESSOR
		redefine
			process_document, process_element
		end

create

	make

feature {NONE} -- Initialization

	make (an_identifier_list: DS_HASH_TABLE [GOA_SOAP_ELEMENT, STRING]; an_encoding: GOA_SOAP_ENCODING; an_identity: UT_URI) is
			-- Establish invariant.
		require
			unique_identifiers_not_void: an_identifier_list /= Void
			encoding_not_void: an_encoding /= Void
			identity_not_void: an_identity /= Void
		do
			unique_identifiers := an_identifier_list
			encoding := an_encoding
			identifying_node := an_identity
		ensure
			unique_identifiers_set: unique_identifiers = an_identifier_list
			identity_set: identifying_node = an_identity
			encoding_set: encoding = an_encoding
		end

feature -- Status report

	validation_fault: GOA_SOAP_FAULT_INTENT
			-- Fault generated by unmarshalling error;
			-- Available if not `validated'.

	validated: BOOLEAN
			-- Did validation succeed?

	validation_complete: BOOLEAN
			-- Has validation completed?

feature -- Processing

	process_element (e: XM_ELEMENT) is
			-- Process element `e'.
		local
			an_element: GOA_SOAP_ELEMENT
		do

			-- We only detect the first valiation error

			if validated then
				an_element ?= e
				check
					soap_element: an_element /= Void
				end
				encoding.validate_references (an_element, unique_identifiers, identifying_node)
				if not encoding.was_valid then
					validated := False; validation_fault := encoding.validation_fault
				else
					an_element.process_children (Current)
				end
			end
		end

	process_document (a_doc: XM_DOCUMENT) is
			-- Process document `a_doc'.
		do
			validated := True
			a_doc.process_children (Current)
			validation_complete := True
		end

feature {NONE} -- Implementation
	
	unique_identifiers: DS_HASH_TABLE [GOA_SOAP_ELEMENT, STRING]
			-- Elements inded by the ID/xs:ID value

	identifying_node: UT_URI
			-- SOAP node

	encoding: GOA_SOAP_ENCODING
			-- SOAP encoding

invariant

	unique_identifiers_not_void: unique_identifiers /= Void
	validate: validated implies validation_fault = Void
	validation_fault: validation_complete and then not validated implies validation_fault /= Void
	identity_not_void: identifying_node /= Void
	encoding_not_void: encoding /= Void

end -- class GOA_SOAP_ELEMENT_VALIDATOR
