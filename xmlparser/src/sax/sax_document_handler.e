indexing

	description: "Receive notification of general document events."
	author: "Glenn Maughan"
	revision: "$Revision$"
	date: "$Date$"

deferred class SAX_DOCUMENT_HANDLER

feature 

	set_document_locator (locator: SAX_LOCATOR) is
			-- Receive a Locator object for document events.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass if they wish to store the locator for use
    		-- with other document events.
		require
			locator_exists: locator /= Void
		deferred
		end

	start_document is
			-- Receive notification of the beginning of the document.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass to take specific actions at the beginning
    		-- of a document (such as allocating the root node of a tree or
    		-- creating an output file).
		deferred
		end

	end_document is
			-- Receive notification of the end of the document.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass to take specific actions at the beginning
    		-- of a document (such as finalising a tree or closing an output
    		-- file).
		deferred
		end

	start_element (name: STRING; attributes: SAX_ATTRIBUTE_LIST) is
			-- Receive notification of the start of an element.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass to take specific actions at the start of
    		-- each element (such as allocating a new tree node or writing
    		-- output to a file).
		require
			name_exists: name /= Void
			attributes_exists: attributes /= Void
		deferred
		end

	end_element (name: STRING) is
			-- Receive notification of the end of an element.
    		-- By default, do nothing.  Application writers may override this
   			-- method in a subclass to take specific actions at the end of
    		-- each element (such as finalising a tree node or writing
    		-- output to a file).
		require
			name_exists: name /= Void
		deferred
		end

	characters (ch: ARRAY[CHARACTER]; start, length: INTEGER) is
			-- Receive notification of character data inside an element.
    		-- By default, do nothing.  Application writers may override this
    		-- method to take specific actions for each chunk of character data
    		-- (such as adding the data to a node or buffer, or printing it to
    		-- a file).
		require
			ch_exist: ch /= Void
			positive_start: start >= 0
			positive_length: length >= 0
			enough_chars: length <= ch.count
		deferred
		end

	ignorable_whitespace (ch: ARRAY[CHARACTER]; start, length: INTEGER) is
			-- Receive notification of ignorable whitespace in element content.
    		-- By default, do nothing.  Application writers may override this
    		-- method to take specific actions for each chunk of ignorable
    		-- whitespace (such as adding data to a node or buffer, or printing
    		-- it to a file).
		require
			ch_exists: ch /= Void
			positive_start: start >= 0
			positive_length: length >= 0
			enough_chars: length <= ch.count
		deferred
		end

	processing_instruction (target, data: STRING) is
			-- Receive notification of a processing instruction.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass to take specific actions for each
    		-- processing instruction, such as setting status variables or
    		-- invoking other methods.
		require
			target_exists: target /= Void
		deferred
		end

end -- class SAX_DOCUMENT_HANDLER
