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

	GOA_SOAP_FAULTS

	XM_EIFFEL_PARSER_FACTORY

	KL_IMPORTED_STRING_ROUTINES

	KL_SHARED_STANDARD_FILES

	UC_SHARED_STRING_EQUALITY_TESTER

		-- This class acts as a SOAP node processor.
		-- To get customised behaviour, create a descendant
		--  and redefine some or all of the Template routines.

create

	make

feature {NONE} -- Initialization

	make (an_identity: like node) is
		require
			identity_not_void: an_identity /= Void
		do
			node := an_identity
			create known_roles.make_default
			known_roles.set_equality_tester (string_equality_tester)
			known_roles.put_new (Role_next)
			add_additional_known_roles
			create active_roles.make_default
			active_roles.set_equality_tester (string_equality_tester)
		ensure
			identity_set: node = an_identity
		end

feature -- Template routines

	add_additional_known_roles is
			-- Add non-standard roles.
		do
		end

	determine_active_roles is
			-- Determine in which roles we will act.
		require
			no_build_error: is_build_sucessful
			valid: is_valid
		local
			a_cursor: DS_LINKED_LIST_CURSOR [GOA_SOAP_HEADER_BLOCK]
		do
			active_roles.wipe_out
			if envelope.header /= Void then
				a_cursor := envelope.header.header_blocks.new_cursor
				from a_cursor.start until a_cursor.after loop
					examine_header_for_roles (a_cursor.item)
					a_cursor.forth
				end
			end
			examine_body_for_active_roles
			if is_ultimate_receiver and then not active_roles.has (Role_ultimate_receiver) then
				active_roles.force_new (Role_ultimate_receiver)
			end
		end

	examine_header_for_roles (a_header: GOA_SOAP_HEADER_BLOCK) is
			-- Examine `a_header' to determine roles in which `Current' will act.
		require
			header_block_not_void: a_header /= Void
			no_build_error: is_build_sucessful
			valid: is_valid
		local
			a_candidate_role: STRING
		do
			if a_header.role /= Void then
				a_candidate_role := a_header.role.full_reference
				if known_roles.has (a_candidate_role) and then not active_roles.has (a_candidate_role) then
					active_roles.force_new (a_candidate_role)
				end
			end
		end

	is_header_understood (a_header: GOA_SOAP_HEADER_BLOCK): BOOLEAN is
			-- Do we understand `a_header'?
		require
			header_exists: a_header /= Void
		do

			-- This default implementation doesn't understand any headers (!)

			Result := False
		end
								 
	examine_body_for_active_roles is
			-- Examine message body to determine roles in which `Current' will act.
		do
		end

	process_headers is
			-- Process all mandatory headers (and optionally, non-mandatory headers) targetted at `Current'.
		require
			all_mandatory_headers_understood: are_all_mandatory_headers_understood
		local
			a_cursor: DS_LINKED_LIST_CURSOR [GOA_SOAP_HEADER_BLOCK]
		do
			is_header_fault := False
			if envelope.header /= Void then
				a_cursor := envelope.header.header_blocks.new_cursor
				from a_cursor.start until a_cursor.after loop
					if is_mandatory_header (a_cursor.item) then
						process_header (a_cursor.item)
					elseif are_optional_headers_processed and then is_targetted_header (a_cursor.item) then
						process_header (a_cursor.item)
					end
					a_cursor.forth
				end
			end
		end

	process_header (a_header:  GOA_SOAP_HEADER_BLOCK) is
			-- Process `_header'
		require
			header_exists: a_header /= Void
		do
			is_header_fault := False
		end

	process_body is
			-- Process message body.
		require
			ultimate_receiver: is_ultimate_receiver
			no_header_faults: not is_header_fault
		local
			a_formatter: GOA_SOAP_NODE_FORMATTER
		do

			-- Default implementation just serializes message to standard output

			if envelope.is_fault_message then
				print ("Received message was a SOAP Fault%N")
			end
			--create a_formatter.make
			--a_formatter.set_output (std.output)
			--a_formatter.process_document (envelope.root_node)
			print ("%N")
		end

	create_and_send_must_understand_fault is
			-- Send a MustUnderstand fault.
		require
			some_headers_not_understood: not_understood_headers /= Void and then not_understood_headers.count > 0
		local
			a_fault_intent: GOA_SOAP_FAULT_INTENT
		do
			create a_fault_intent.make (Must_understand_fault, "At least one mandatory header was not understood", "en", node, Void)
			a_fault_intent.set_not_understood_headers (not_understood_headers)
			send_message (new_fault_message (a_fault_intent))
		end

	send_message (an_envelope: GOA_SOAP_ENVELOPE) is
			-- Send a SOAP message.
		require
			envelope_not_void: an_envelope /= Void
		local
			a_formatter: GOA_SOAP_NODE_FORMATTER
		do

			-- Default implementation just serializes message to standard output

			create a_formatter.make
			a_formatter.set_output (std.output)
			a_formatter.process_document (an_envelope.root_node)
			print ("%N")
		end

	relay_message is
			-- TODO
		do
		end

feature -- Access

	node: UT_URI
			-- Identity of this SOAP node

	known_roles: DS_HASH_SET [STRING]
			-- Roles in which `Current' may act

	active_roles: DS_HASH_SET [STRING]
			-- Roles in which `Current' acts while processing current message

	mandatory_headers: DS_LINKED_LIST [GOA_SOAP_HEADER_BLOCK]
			-- Mandatory headers of current message

	not_understood_headers: DS_LINKED_LIST [GOA_SOAP_HEADER_BLOCK]
			-- Mandatory headers of current message which are not understood

	is_relaying: BOOLEAN
			-- Are we relaying messages?

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

	is_header_fault: BOOLEAN
			-- Has a header_fault_occurred?

	are_optional_headers_processed: BOOLEAN
			-- Do we process optional headers targetted at us?

	is_build_sucessful: BOOLEAN is
			-- Was the envelope built without error?
		do
			Result := tree_builder /= Void and then not tree_builder.error.has_error and then not tree_builder.tree_filter.is_error
		end

	is_valid: BOOLEAN is
			-- Did `envelope' validate?
		require
			no_build_error: is_build_sucessful
		do
			Result := envelope.validated
		end

	validation_fault: GOA_SOAP_FAULT_INTENT is
			-- Fault from validation
		require
			no_build_error: is_build_sucessful
			no_valid: not is_valid
		do
			Result := envelope.validation_fault
		ensure
			fault_not_void: Result /= Void
		end

	is_ultimate_receiver: BOOLEAN is
			-- Are we acting as the ultimate receiver for the next or current call to `process'?
		do
			Result := known_roles.has (Role_ultimate_receiver)
		end

feature -- Status setting

	set_ultimate_receiver (yes_or_no: BOOLEAN) is
			-- Determine if we are to act as the ultimate receiver for the next call to `process'.
		do
			if yes_or_no then
				if not is_ultimate_receiver then
					known_roles.force_new (Role_ultimate_receiver)
				end
			else
				if is_ultimate_receiver then
					known_roles.remove (Role_ultimate_receiver)
				end
			end
		end

	set_process_optional_headers  (yes_or_no: BOOLEAN) is
			-- Determine if we process optional headers targetted at us.
		do
			are_optional_headers_processed := yes_or_no
		ensure
			set: are_optional_headers_processed = yes_or_no
		end

feature -- Process

	process (a_message: STRING) is
			-- Process message.
		require
			message_not_void: a_message /= Void
		do
			parse_xml (a_message, Void)
			if tree_builder.error.has_error then
				send_build_failure_message (tree_builder.error.last_error)
			elseif tree_builder.tree_filter.is_error then
				if tree_builder.tree_filter.no_envelope then
					send_version_mismatch_fault
				elseif tree_builder.tree_filter.is_parse_error then
					send_build_failure_message (STRING_.concat ("Error parsing SOAP message: ",tree_builder.tree_filter.last_parse_error))
				elseif tree_builder.tree_filter.invalid_standalone then
					send_build_failure_message ("Standalone cannot be 'no' in a SOAP message")
				elseif tree_builder.tree_filter.dtd_seen then
					send_build_failure_message ("DTD is not allowed in a SOAP message")
				elseif tree_builder.tree_filter.pi_seen then
					send_build_failure_message ("Processing instructions are not allowed in a SOAP message")
				elseif tree_builder.tree_filter.invalid_comment then
					send_build_failure_message ("Comments are not allowed outside of the SOAP Envelope")
				end
			else
				envelope.validate (node)
				if is_valid then
					determine_active_roles
					identify_mandatory_headers
					if are_all_mandatory_headers_understood then
						process_headers
						if is_ultimate_receiver then
							if is_header_fault then process_body end
						else
							if is_relaying then relay_message end
						end
					else
						create_and_send_must_understand_fault
					end
				else
					create_and_send_fault (envelope.validation_fault)
				end
			end
		end

	identify_mandatory_headers is
			-- Identify all mandatory headers.
		require
			no_build_error: is_build_sucessful
			valid: is_valid
		local
			a_cursor: DS_LINKED_LIST_CURSOR [GOA_SOAP_HEADER_BLOCK]
		do
			create mandatory_headers.make_default
			create not_understood_headers.make_default
			if envelope.header /= Void then
				a_cursor := envelope.header.header_blocks.new_cursor
				from a_cursor.start until a_cursor.after loop
					if is_mandatory_header (a_cursor.item) then
						mandatory_headers.force_last (a_cursor.item)
					end
					a_cursor.forth
				end
			end
		end

	are_all_mandatory_headers_understood: BOOLEAN is
			-- Are all of `mandatory_headers' understood by `Current'?
		require
			mandatory_headers_not_void: mandatory_headers /= Void
			not_understood_headers_not_void: not_understood_headers /= Void
		local
			a_cursor: DS_LINKED_LIST_CURSOR [GOA_SOAP_HEADER_BLOCK]
		do
			from a_cursor := mandatory_headers.new_cursor; a_cursor.start until a_cursor.after loop
				if not is_header_understood (a_cursor.item) then
					not_understood_headers.force_last (a_cursor.item)
				end
				a_cursor.forth
			end
			Result := not_understood_headers.is_empty
		end

feature {NONE} -- Implementation

	tree_builder: GOA_SOAP_TREE_BUILDER
			-- Tree constructor

	is_mandatory_header (a_header: GOA_SOAP_HEADER_BLOCK): BOOLEAN is
			-- Is `a_header' mandatory?
		require
			header_not_void: a_header /= Void
		do
			if a_header.must_understand then
				Result := is_targetted_header (a_header)
			end
		end

	is_targetted_header (a_header: GOA_SOAP_HEADER_BLOCK): BOOLEAN is
			-- Is `a_header' targetted at us?
		require
			header_not_void: a_header /= Void
		local
			a_cursor: DS_HASH_SET_CURSOR [STRING]
			a_role: UT_URI
		do
			a_role := a_header.role
			if a_role = Void then
				Result := is_ultimate_receiver
			elseif STRING_.same_string (Role_none, a_role.full_reference) then
				Result := False
			else
				a_cursor := active_roles.new_cursor
				from a_cursor.start until
					a_cursor.after
				loop
					if STRING_.same_string (a_cursor.item, a_role.full_reference) then
						Result := True; a_cursor.go_after
					else
						a_cursor.forth
					end
				end
			end
		end

	parse_xml (an_xml: STRING; a_base_uri: UT_URI) is
			-- Parse xml source.
		require
			xml_not_void: an_xml /= Void
		local
			a_parser: XM_PARSER
			a_stop_parser: XM_PARSER_STOP_ON_ERROR_FILTER
		do
			-- TODO: use `a_base_uri'
			create tree_builder.make
			a_parser := new_eiffel_parser
			create a_stop_parser.make (a_parser)
			tree_builder.last.set_next (a_stop_parser)
			a_parser.set_callbacks (tree_builder.start)
			a_parser.set_dtd_callbacks (tree_builder.dtd_target)
			a_parser.parse_from_string (an_xml)
		ensure
			tree_builder_created: tree_builder /= Void
		end

	send_build_failure_message (a_message: STRING) is
			-- Send a build-failure message.
		require
			message_not_empty: a_message /= Void and then not a_message.is_empty
		do
			-- TODO
			print (a_message);print ("%N")
		end

	send_version_mismatch_fault is
			-- Send a versionMismatch fault.
		local
			a_fault_intent: GOA_SOAP_FAULT_INTENT
		do
			create a_fault_intent.make (Version_mismatch_fault, "Version mismatch", "en", node, Void)
			create_and_send_fault (a_fault_intent)
		end

	create_and_send_fault (a_fault_intent: GOA_SOAP_FAULT_INTENT) is
			-- Create and send a fault_message.
		require
			fault_intent_not_void: a_fault_intent /= Void
		local
			an_envelope: GOA_SOAP_ENVELOPE
		do
			an_envelope := new_fault_message (a_fault_intent)
			send_message (an_envelope)
		end

invariant

	node_not_void: node /= Void
	known_roles_not_void: known_roles /= Void
	active_roles_not_void: active_roles /= Void

end -- class GOA_SOAP_PROCESSOR
