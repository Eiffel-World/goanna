indexing

	description: "Basic interface for resolving entities."
	author: "Glenn Maughan"
	revision: "$Revision$"
	date: "$Date$"

deferred class SAX_ENTITY_RESOLVER

feature 

	resolve_entity (public_id, system_id: STRING): SAX_INPUT_SOURCE is
			-- Resolve an external entity.
    		-- Always return null, so that the parser will use the system
    		-- identifier provided in the XML document.  This method implements
    		-- the SAX default behaviour: application writers can override it
    		-- in a subclass to do special translations such as catalog lookups
    		-- or URI redirection.
		require
			system_id_exists: system_id /= Void
		deferred
		end

end -- class SAX_ENTITY_RESOLVER
