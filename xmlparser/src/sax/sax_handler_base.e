indexing

	description: "Default base class for handlers."
	author: "Glenn Maughan"
	revision: "$Revision$"
	date: "$Date$"

deferred class SAX_HANDLER_BASE

inherit

	SAX_ENTITY_RESOLVER
	
	SAX_DTD_HANDLER

	SAX_DOCUMENT_HANDLER

	SAX_ERROR_HANDLER

feature -- Entity Resolver features

	resolve_entity (public_id, system_id: STRING): SAX_INPUT_SOURCE is
			-- Resolve an external entity.
    		-- Always return null, so that the parser will use the system
    		-- identifier provided in the XML document.  This method implements
    		-- the SAX default behaviour: application writers can override it
    		-- in a subclass to do special translations such as catalog lookups
    		-- or URI redirection.
		do
		end

feature -- DTD Handler features

	notation_decl (name, public_id, system_id: STRING) is
			-- Receive notification of a notation declaration.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass if they wish to keep track of the notations
    		-- declared in a document.
		do
		end

	unparsed_entity_decl (name, public_id, system_id, notation_name: STRING) is
			-- Receive notification of an unparsed entity declaration.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass to keep track of the unparsed entities
    		-- declared in a document.
		do
		end

feature -- Document Handler features

	set_document_locator (locator: SAX_LOCATOR) is
			-- Receive a Locator object for document events.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass if they wish to store the locator for use
    		-- with other document events.
		do
		end

	start_document is
			-- Receive notification of the beginning of the document.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass to take specific actions at the beginning
    		-- of a document (such as allocating the root node of a tree or
    		-- creating an output file).
		do
		end

	end_document is
			-- Receive notification of the end of the document.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass to take specific actions at the beginning
    		-- of a document (such as finalising a tree or closing an output
    		-- file).
		do
		end

	start_element (name: STRING; attributes: SAX_ATTRIBUTE_LIST) is
			-- Receive notification of the start of an element.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass to take specific actions at the start of
    		-- each element (such as allocating a new tree node or writing
    		-- output to a file).
		do
		end

	end_element (name: STRING) is
			-- Receive notification of the end of an element.
    		-- By default, do nothing.  Application writers may override this
   			-- method in a subclass to take specific actions at the end of
    		-- each element (such as finalising a tree node or writing
    		-- output to a file).
		do
		end

	characters (ch: ARRAY[CHARACTER]; start, length: INTEGER) is
			-- Receive notification of character data inside an element.
    		-- By default, do nothing.  Application writers may override this
    		-- method to take specific actions for each chunk of character data
    		-- (such as adding the data to a node or buffer, or printing it to
    		-- a file).
		do
		end

	ignorable_whitespace (ch: ARRAY[CHARACTER]; start, length: INTEGER) is
			-- Receive notification of ignorable whitespace in element content.
    		-- By default, do nothing.  Application writers may override this
    		-- method to take specific actions for each chunk of ignorable
    		-- whitespace (such as adding data to a node or buffer, or printing
    		-- it to a file).
		do
		end

	processing_instruction (target, data: STRING) is
			-- Receive notification of a processing instruction.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass to take specific actions for each
    		-- processing instruction, such as setting status variables or
    		-- invoking other methods.
		do
		end

feature -- Error Handler features

	warning (e: SAX_PARSE_EXCEPTION) is
			-- Receive notification of a parser warning.
    		-- The default implementation does nothing.  Application writers
    		-- may override this method in a subclass to take specific actions
    		-- for each warning, such as inserting the message in a log file or
    		-- printing it to the console.
		do
		end

	error (e: SAX_PARSE_EXCEPTION) is
			-- Receive notification of a recoverable parser error.
    		-- The default implementation does nothing.  Application writers
    		-- may override this method in a subclass to take specific actions
    		-- for each error, such as inserting the message in a log file or
    		-- printing it to the console.
		do
		end

	fatal_error (e: SAX_PARSE_EXCEPTION) is
			-- Report a fatal XML parsing error.
    		-- The default implementation throws a SAXParseException.
    		-- Application writers may override this method in a subclass if
    		-- they need to take specific actions for each fatal error (such as
    		-- collecting all of the errors into a single report): in any case,
    		-- the application must stop all regular processing when this
    		-- method is invoked, since the document is no longer reliable, and
    		-- the parser may no longer report parsing events.
		do
		end

end -- class SAX_HANDLER_BASE
