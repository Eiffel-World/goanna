indexing
	description: "Objects that listen to HTTP Session Events"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "HTTP Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>", "Neal Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	HTTP_SESSION_EVENT_LISTENER

feature {HTTP_SESSION_MANAGER} -- Events

    expiring (session: HTTP_SESSION) is
            -- 'session' is about to be expired.
        require
            session_exists: session /= Void
        deferred
        end

    expired (session: HTTP_SESSION) is
            -- 'session' has expired and has been removed from
            -- the active list of sessions
        require
            session_exists: session /= Void
        deferred
        end

    created (session: HTTP_SESSION) is
            -- 'session' has been created
        require
            session_exists: session /= Void
        deferred
        end

    attribute_bound (session: HTTP_SESSION; name: STRING;
        attribute: ANY) is
            -- 'attribute' has been bound in 'session' to 'name'
        require
            session_exists: session /= Void
            name_exists: name /= Void
            attribute_exists: attribute /= Void
            attribute_bound: session.get_attribute (name) = attribute
        deferred
        end

    attribute_unbound (session: HTTP_SESSION; name: STRING;
        attribute: ANY) is
            -- 'attribute' has been unbound in 'session' from 'name'
        require
            session_exists: session /= Void
            name_exists: name /= Void
            attribute_exists: attribute /= Void
            attribute_unbound: not session.has_attribute (name)
        deferred
        end

end -- class HTTP_SESSION_EVENT_LISTENER
