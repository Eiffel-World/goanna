indexing
	description: "Objects that process SOAP messages"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Colin Adams <colin@colina.demon.co.uk>"
	copyright: "Copyright (c) 2005 Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class	GOA_SOAP_PROCESSOR

inherit

	XM_EIFFEL_PARSER_FACTORY

	KL_IMPORTED_STRING_ROUTINES

create

	make

feature {NONE} -- Initialization

	make is
		do
		end

feature -- Access

		envelope: GOA_SOAP_ENVELOPE is
			-- Parsed envelope
		require
			no_build_error: is_build_sucessful
		do
			Result ?= tree_builder.document.root_element
		ensure
			envelope_not_void: Result /= Void
		end

feature -- Status report

	is_build_sucessful: BOOLEAN is
			-- Was the envelope built without error?
		do
			Result := tree_builder /= Void and then not tree_builder.error.has_error and then not tree_builder.tree_filter.is_error
		end

feature -- Process

	process (a_message: STRING) is
			-- Process message.
		require
			message_not_void: a_message /= Void
		do
			parse_xml (a_message)
			if tree_builder.error.has_error then
				send_build_failure_message (tree_builder.error.last_error)
			elseif tree_builder.tree_filter.is_error then
				if tree_builder.tree_filter.is_parse_error then
					send_build_failure_message (STRING_.concat ("Error parsing SOAP message: ",tree_builder.tree_filter.last_parse_error))
				elseif tree_builder.tree_filter.invalid_standalone then
					send_build_failure_message ("Standalone cannot be 'no' in a SOAP message")
				elseif tree_builder.tree_filter.dtd_seen then
					send_build_failure_message ("DTD is not allowed in a SOAP message")
				elseif tree_builder.tree_filter.pi_seen then
					send_build_failure_message ("Processing instructions are not allowed in a SOAP message")
				elseif tree_builder.tree_filter.invalid_comment then
					send_build_failure_message ("Comments are not allowed outside of the SOAP Envelope")
				elseif tree_builder.tree_filter.no_envelope then
					send_build_failure_message ("The document element is not a SOAP Envelope")
				end
			else
				envelope.validate
			end
		end

feature {NONE} -- Implementation

	tree_builder: GOA_SOAP_TREE_BUILDER
			-- Tree constructor

	parse_xml (an_xml: STRING) is
			-- Parse xml source.
		require
			xml_not_void: an_xml /= Void
		local
			a_parser: XM_PARSER
		do
			create tree_builder.make
			a_parser := new_eiffel_parser
			a_parser.set_callbacks (tree_builder.start)
			a_parser.set_dtd_callbacks (tree_builder.dtd_target)
			a_parser.parse_from_string (an_xml)
		ensure
			tree_builder_created: tree_builder /= Void
		end

	send_build_failure_message (a_message: STRING)is
			-- Send a build-failure message.
		require
			message_not_empty: a_message /= Void and then not a_message.is_empty
		do
			-- TODO
			print (a_message)
		end

end -- class GOA_SOAP_PROCESSOR
