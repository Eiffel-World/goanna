indexing

	description: "Basic interface for SAX (Simple API for XML) parsers.";
	author: "Glenn Maughan";
	revision: "$Revision$";
	date: "$Date$";

deferred class SAX_PARSER

feature

	set_locale (locale: STRING) is
			-- Allow an application to request a locale for errors
			-- and warnings.
			-- SAX parsers are not required to provide localisation for errors
			-- and warnings; if they cannot support the requested locale,
			-- however, they must throw a SAX exception. Applications may
			-- not request a locale change in the middle of a parse.
		deferred
		end

	set_entity_resolver (resolver: SAX_ENTITY_RESOLVER) is
			-- Allow an application to register a custom entity resolver.
			-- If the application does not register an entity resolver, the
			-- SAX parser will resolve system identifiers and open connections
			-- to entities itself (this is the default behaviour implemented in
			-- SAX_HANDLER_BASE.
			-- Applications may register a new or different entity resolver
			-- in the middle of a parse, and the SAX parser must begin using
			-- the new resolver immediately.
		require
			resolver_exists: resolver /= Void
		deferred
		end

	set_dtd_handler (dtd_handler: SAX_DTD_HANDLER) is
			-- Allow an application to register a DTD event handler.
    		-- If the application does not register a DTD handler, all DTD
    		-- events reported by the SAX parser will be silently
    		-- ignored (this is the default behaviour implemented by
    		-- HandlerBase).
    		-- Applications may register a new or different
    		-- handler in the middle of a parse, and the SAX parser must
    		-- begin using the new handler immediately.
		require
			dtd_handler_exists: dtd_handler /= Void
		deferred
		end

	set_document_handler (document_handler: SAX_DOCUMENT_HANDLER) is
			-- Allow an application to register a document event handler.
    		-- If the application does not register a document handler, all
    		-- document events reported by the SAX parser will be silently
    		-- ignored (this is the default behaviour implemented by
   			-- HandlerBase).
    		-- Applications may register a new or different handler in the
    		-- middle of a parse, and the SAX parser must begin using the new
    		-- handler immediately.
		require
			document_handler: document_handler /= Void
		deferred
		end

	set_error_handler (error_handler: SAX_ERROR_HANDLER) is
			-- Allow an application to register an error event handler.
    		-- If the application does not register an error event handler,
    		-- all error events reported by the SAX parser will be silently
    		-- ignored, except for fatalError, which will throw a SAXException
    		-- (this is the default behaviour implemented by HandlerBase).
    		-- Applications may register a new or different handler in the
    		-- middle of a parse, and the SAX parser must begin using the new
    		-- handler immediately.
		require
			error_handler_exists: error_handler /= Void
		deferred
		end

	parse (input: SAX_INPUT_SOURCE) is
			-- Parse an XML document.
    		-- The application can use this method to instruct the SAX parser
    		-- to begin parsing an XML document from any valid input
    		-- source (a character stream, a byte stream, or a URI).
    		-- Applications may not invoke this method while a parse is in
    		-- progress (they should create a new Parser instead for each
    		-- additional XML document).  Once a parse is complete, an
    		-- application may reuse the same Parser object, possibly with a
    		-- different input source.
		require
			input_exists: input /= Void
		deferred
		end

	parse_from_uri (system_id: STRING) is
			-- Parse an XML document from a system identifier (URI).
    		-- This method is a shortcut for the common case of reading a
    		-- document from a system identifier.  It is the exact
    		-- equivalent of the following:
			--
    		-- parse(new InputSource(systemId));
    		-- 
    		-- If the system identifier is a URL, it must be fully resolved
    		-- by the application before it is passed to the parser.
		require
			system_id_exists: system_id /= Void
		deferred
		end

end -- class SAX_PARSER





