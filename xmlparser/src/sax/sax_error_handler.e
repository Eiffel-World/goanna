indexing

	description: "Basic interface for SAX error handlers."
	author: "Glenn Maughan"
	revision: "$Revision$"
	date: "$Date$"

deferred class SAX_ERROR_HANDLER

feature 

	warning (e: SAX_PARSE_EXCEPTION) is
			-- Receive notification of a parser warning.
    		-- The default implementation does nothing.  Application writers
    		-- may override this method in a subclass to take specific actions
    		-- for each warning, such as inserting the message in a log file or
    		-- printing it to the console.
		require
			e_exists: e /= Void
		deferred
		end

	error (e: SAX_PARSE_EXCEPTION) is
			-- Receive notification of a recoverable parser error.
    		-- The default implementation does nothing.  Application writers
    		-- may override this method in a subclass to take specific actions
    		-- for each error, such as inserting the message in a log file or
    		-- printing it to the console.
		require
			e_exists: e /= Void
		deferred
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
		require
			e_exists: e /= Void
		deferred
		end

end -- class SAX_ERROR_HANDLER
