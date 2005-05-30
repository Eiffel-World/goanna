indexing
	description: "Objects that represent user session information."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "HTTP Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>", "Neal Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	HTTP_SESSION

inherit
	
	DT_SHARED_SYSTEM_CLOCK
--		export
--			{NONE} all
--		end

	SHARED_HTTP_SESSION_MANAGER
		export
			{NONE} all
		end

creation
	make

feature {HTTP_SESSION_MANAGER}-- Initialization

	make (session_id: STRING) is
			-- Create a new session with 'id' set to 'session_id'
		require
			session_id_exists: session_id /= Void			
		do			
			id := session_id
			debug ("session_management")
				print ("New session: " + id + "%R%N")
			end	
			validated := True
			is_new := True
			max_inactive_interval := 14400
			create attributes.make (5)
			creation_time := system_clock.date_time_now
			touch
		ensure
			valid_session: validated
			new_session: is_new
		end
	
feature -- Access

	get_attribute (name: STRING): ANY is
			-- Returns the object bound to 'name'
		require
			valid_session: validated
			name_exists: name /= Void
			name_bound: has_attribute (name)
		do		
			Result := attributes.item (name)
		end
		
	get_attribute_names: DS_ARRAYED_LIST [STRING] is
			-- Return a list of all attribute names bound in this session 
		require
			valid_session: validated
		do
			create Result.make (attributes.count)
			from
				attributes.start
			until
				attributes.after
			loop
				Result.put_last (attributes.key_for_iteration)
				attributes.forth
			end
		end
	
feature -- Status report

	id: STRING
			-- Session id
			
	creation_time: DT_DATE_TIME
			-- Date and time session was created
			
	last_accessed_time: DT_DATE_TIME
			-- The last time a client sent a request associated with this session
			
	max_inactive_interval: INTEGER
			-- The maximum time interval, in seconds, that the session will remain open
			-- between client requests
			
	is_new: BOOLEAN
			-- Does the client know about the session?
		
	validated: BOOLEAN
			-- Is the session valid?
			
	has_attribute (name: STRING): BOOLEAN is
			-- Is a value bound to 'name'
		require
			valid_session: validated
			name_exists: name /= Void			
		do
			Result := attributes.has (name)
		end
		
feature -- Status setting

	set_max_inactive_interval (new_interval: like max_inactive_interval) is
			-- Set the maximum inactive interval			
		require
			valid_session: validated
		do
			max_inactive_interval := new_interval
		end
	
	invalidate is
			-- Invalidates the session and unbinds any objects bound to it			
		require
			valid_session: validated
		do
			validated := False
			attributes := Void
		ensure
			invalidated: not validated
		end
	
feature -- Element change

	set_attribute (name: STRING; value: ANY) is
			-- Bind 'name' to 'value' in this session
		require
			valid_session: validated
			not_already_bound: not has_attribute (name)			
		do
			debug ("session_management")
				print ("Binding session attribute: " + name + " to session " + id + "%R%N")
			end
			attributes.put (value, name)
			session_manager.attribute_bound_notification (current, name, value)
		end
	
feature -- Removal

	remove_attribute (name: STRING) is
			-- Unbind the value bound to 'name'
		require
			valid_session: validated
			name_is_bound: has_attribute (name)
		local
			removed_attribute : ANY
		do
			debug ("session_management")
				print ("Unbinding session attribute: " + name + " from session " + id + "%R%N")
			end
			removed_attribute := attributes.item (name)
			attributes.remove (name)
			session_manager.attribute_unbound_notification (current, name, removed_attribute)
		end
	
feature {HTTP_SESSION_MANAGER}

	set_old is
			-- Register that the client has joined the session.
		do
			is_new := False
		ensure
			not_new: not is_new
		end
	
	touch is
			-- Update the last accessed time.
		require
			valid_session: validated
		do
			last_accessed_time := system_clock.date_time_now
			debug ("session_management")
				print ("Touching session: " + id + " at " + last_accessed_time.out + "%R%N")
			end
		end
	
feature {NONE} -- Implementation

	attributes: DS_HASH_TABLE [ANY, STRING]
			-- Table of bound attributes
			
end -- class HTTP_SESSION
