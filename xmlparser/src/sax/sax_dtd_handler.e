indexing

	description: "Receive notification of basic DTD-related events."
	author: "Glenn Maughan"
	revision: "$Revision$"
	date: "$Date$"

deferred class SAX_DTD_HANDLER

feature 

	notation_decl (name, public_id, system_id: STRING) is
			-- Receive notification of a notation declaration.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass if they wish to keep track of the notations
    		-- declared in a document.
		require
			name_exists: name /= Void
		deferred
		end

	unparsed_entity_decl (name, public_id, system_id, notation_name: STRING) is
			-- Receive notification of an unparsed entity declaration.
    		-- By default, do nothing.  Application writers may override this
    		-- method in a subclass to keep track of the unparsed entities
    		-- declared in a document.
		require
			name_exists: name /= Void
			system_id_exists: system_id /= Void
			notation_name_exists: notation_name /= Void
		end

end -- class SAX_DTD_HANDLER
