indexing

	description: "Fast non-validating SAX parser."
	author: "Glenn Maughan"
	revision: "$Revision$"
	date: "$Date$"

class XML_PARSER

inherit

	SAX_PARSER

creation

	make

feature -- Initialisation

	make is
			-- Initialise this parser
		do
			create char_tmp.make (2)
			is_validating := False
			fast_standalone := False
			is_in_attribute := False
			create elements.make (47)
			create params.make (7)
			create notations.make (7)
			create entities.make (17)
			-- setup handlers
			create locator
			set_handlers
		end

feature -- Access

	set_locale (l: STRING) is
			-- Used by applications to request locale for diagnostics.
		do
			locale := l
		end

	get_local: STRING is
			-- Return the current locale
		do
			Result := locale
		end
	
feature {} -- Implementation

	in: INPUT_ENTITY
			-- Stach of input entities being merged.

	att_tmp: SAX_ATTRIBUTE_LIST_IMPL
	str_tmp: STRING
	name_tmp: ARRAY [CHARACTER]
	name_cache: NAME_CACHE
	char_tmp: ARRAY [CHARACTER]

	is_validating: BOOLEAN
	fast_standalone: BOOLEAN
	is_in_attribute: BOOLEAN
	
	in_external_pe: BOOLEAN
	do_lexical_pe: BOOLEAN
	done_prologue: BOOLEAN

	is_standalone: BOOLEAN
	root_element_name: STRING

	ignore_declarations: BOOLEAN
	elements: HASH_TABLE [ELEMENT]
	params: HASH_TABLE [PARAM]

	notations: HASH_TABLE [NOTATION]
	entities: HASH_TABLE [ENTITY]
	
	doc_handler: SAX_DOCUMENT_HANDLER
	dtd_handler: SAX_DTD_HANDLER
	resolver: SAX_ENTITY_RESOLVER
	err_handler: SAX_ERROR_HANDLER
	locale: STRING
	locator: SAX_LOCATOR

	dtd_listener: DTD_EVENT_LISTENER
	lexical_listener: LEXICAL_EVENT_LISTENER

	str_any: STRING is "ANY"
	str_empty: STRING is "EMPTY"

end -- class XML_PARSER
