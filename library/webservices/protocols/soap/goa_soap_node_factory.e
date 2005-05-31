indexing
	description: "Objects that create SOAP nodes."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Colin Adams <colin@colina.demon.co.uk>"
	copyright: "Copyright (c) 2005 Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_SOAP_NODE_FACTORY

inherit

	GOA_SOAP_CONSTANTS

	KL_IMPORTED_STRING_ROUTINES

create

	make

feature {NONE} -- Initialization

	make is
			-- Do nothing.
		do
		end

feature -- Creation

	new_document_element (a_document: XM_DOCUMENT; ns_prefix: STRING): XM_ELEMENT is
			-- New SOAP Envelope
		require
			document_not_void: a_document /= Void
		local
			a_namespace: XM_NAMESPACE
		do
			create a_namespace.make (ns_prefix, Ns_name_env)
			create {GOA_SOAP_ENVELOPE} Result.make_root (a_document, Envelope_element_name, a_namespace)
		ensure
			document_element_not_void: Result /= Void
		end

	new_element (a_parent: XM_ELEMENT; a_name, namespace, ns_prefix: STRING; is_header_block, is_body_block: BOOLEAN):  XM_ELEMENT is
			-- New element
		require
			parent_not_void: a_parent /= Void
			name_not_empty: a_name /= Void and then not a_name.is_empty
			not_header_and_body: not (is_header_block and is_body_block)
		local
			a_namespace: XM_NAMESPACE
		do
			if namespace /= Void then
				create a_namespace.make (ns_prefix, namespace)
			end
			if namespace /= Void and then STRING_.same_string (namespace, Ns_name_env)
				and then STRING_.same_string (a_name, Header_element_name) then
				create {GOA_SOAP_HEADER} Result.make_last (a_parent, a_name, a_namespace)
			elseif  namespace /= Void and then STRING_.same_string (namespace, Ns_name_env)
				and then STRING_.same_string (a_name, Body_element_name) then
				create {GOA_SOAP_BODY}  Result.make_last (a_parent, a_name, a_namespace)
			elseif is_header_block then
				create {GOA_SOAP_HEADER_BLOCK} Result.make_last (a_parent, a_name, a_namespace)
			elseif is_body_block then
				if  namespace /= Void and then STRING_.same_string (namespace, Ns_name_env)
					and then STRING_.same_string (a_name, Fault_element_name) then
					create {GOA_SOAP_FAULT} Result.make_last (a_parent, a_name, a_namespace)
				else
					create {GOA_SOAP_BLOCK} Result.make_last (a_parent, a_name, a_namespace)
				end
			else
				create {GOA_SOAP_ELEMENT} Result.make_last (a_parent, a_name, a_namespace)
			end
		ensure
			element_not_void: Result /= Void
		end

end -- class GOA_SOAP_NODE_FACTORY
