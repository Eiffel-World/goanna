indexing
	description: "Logging category."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "log4e"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."
	
class LOG_CATEGORY
	
inherit
	
	LOG_PRIORITY_CONSTANTS
		export
			{NONE} all
		end
			
creation
	
	make
	
feature {LOG_CATEGORY_FACTORY} -- Initialisation
	
	make (hierarchy: LOG_HIERARCHY; cat_name: STRING) is
			-- Create new category with 'cat_name'
		require
			cat_name_exists: cat_name /= Void
		do
			context := hierarchy
			name := cat_name
			create appenders.make (1)
		end
	
feature -- Status Report
	
	name: STRING
			-- Name of this category
	
	
	priority: LOG_PRIORITY is
			-- Starting from this caregory, search the category 
			-- hieararchy for a non-null priority and return it. 
			-- Otherwise, return the priority of the root category.
			--| Does not use recursion to speed up the search
		local
			next: LOG_CATEGORY
		do
			from
				next := Current
			until
				Result /= Void
			loop	
				-- check internal priority
				Result := next.cat_priority
			end
		end
	
	parent: LOG_CATEGORY
			-- The parent of this category.
	
	context: LOG_HIERARCHY
			-- The hierarchy in which this category operates.
	
	is_disabled: BOOLEAN
			-- Is this category disabled?
	
	is_additive: BOOLEAN
			-- Should appenders of this category's parent be used?
	
	priority: LOG_PRIORITY
			-- The logging priority of this category
	
	appenders: DS_LINKED_LIST [LOG_APPENDER]
			-- Appenders for this category.
	
	is_enabled_for (check_priority: LOG_PRIORITY): BOOLEAN is
			-- Is this category enabled for 'check_priority'?
		require
			check_priority_exists: check_priority /= Void
		do
			Result := context.disable >= check_priority.level and then priority >= check_priority
		ensure
			true_if_priority_enabled: Result = (context.disable >= check_priority.level
						  and priority >= check_priority)
		end
	
feature -- Status Setting
	
	set_priority (new_priority: LOG_PRIORITY) is
			-- Set the priority for this category.
		require
			priority_exists: cat_priority /= Void
		do
			cat_priority := new_priority
		end
	
	add_appender (new_appender: LOG_APPENDER) is
			-- Add 'new_appender' to the list of 
			-- appenders for this category.
		require
			new_appender_exists: new_appender /= Void
			not_added: not appenders.has (new_appender)
		do
			appenders.force_last (new_appender)
		ensure
			appender_added: appenders.has (new_appender)
		end
	
	remove_appender (name: STRING) is
			-- Remove appender with 'name'
			-- Iterates to find matching appender.
		require
			name_exists: name /= Void
		do
			from
				appenders.start
			until
				appenders.off
			loop
				if appenders.item_for_iteration.name.is_equal (name) then
					found := True
				else
					appenders.forth
				end
			end
			if not appenders.off then
				appenders.remove
			end
		end
	
	
	call_appenders (event: LOG_EVENT) is
			-- Send 'event' to all appenders of this 
			-- category and recursively parents appenders if
			-- additive.
		require
			event_exists: event /= Void
		local
			c: DS_LINKED_LIST_CURSOR [LOG_APPENDER]
		do
			-- loop through all appenders
			from
				c := appenders.new_cursor
				c.start
			until
				c.off
			loop
				c.item.do_append (event)
				c.next
			end
			-- if additive then recurse to parent
			if is_additive and then parent /= Void then
				parent.call_appenders (event)
			end
		end
	
	close_appenders is
			-- Close all appenders
		do
			-- loop through all appenders
			from
				c := appenders.new_cursor
				c.start
			until
				c.off
			loop
				c.item.close
				c.next
			end		
		end
	
feature -- Logging
	
	debugging (message: ANY) is
			-- Log a message object with the priority Debug.
			-- First checks if this category is enabled 
			-- by comparing the priority of this category 
			-- with the Debug priority. If this category 
			-- is debug enabled, then it converts the 
			-- message object to a string by invoking 
			-- 'out'. It then proceeds to call all the 
			-- registered appenders in this category and 
			-- also higher in the hierarchy depending on 
			-- the value of the additivity flag.
		require
			message_exists: message /= Void
		do
			if is_enabled_for (Debugging) then
				forced_log (Debugging, message)
			end
		end
	
	warn (message: ANY) is
			-- Log a message object with the priority Warn.
			-- First checks if this category is enabled 
			-- by comparing the priority of this category 
			-- with the Warn priority. If this category 
			-- is warn enabled, then it converts the 
			-- message object to a string by invoking 
			-- 'out'. It then proceeds to call all the 
			-- registered appenders in this category and 
			-- also higher in the hierarchy depending on 
			-- the value of the additivity flag.
		require
			message_exists: message /= Void
		do
			if is_enabled_for (Warn) then
				forced_log (Warn, message)
			end
		end
	
	info (message: ANY) is
			-- Log a message object with the priority Info.
			-- First checks if this category is enabled 
			-- by comparing the priority of this category 
			-- with the Info priority. If this category 
			-- is info enabled, then it converts the 
			-- message object to a string by invoking 
			-- 'out'. It then proceeds to call all the 
			-- registered appenders in this category and 
			-- also higher in the hierarchy depending on 
			-- the value of the additivity flag.
		require
			message_exists: message /= Void
		do
			if is_enabled_for (Info) then
				forced_log (Info, message)
			end
		end
	
	error (message: ANY) is
			-- Log a message object with the priority Error.
			-- First checks if this category is enabled 
			-- by comparing the priority of this category 
			-- with the Error priority. If this category 
			-- is info enabled, then it converts the 
			-- message object to a string by invoking 
			-- 'out'. It then proceeds to call all the 
			-- registered appenders in this category and 
			-- also higher in the hierarchy depending on 
			-- the value of the additivity flag.
		require
			message_exists: message /= Void
		do
			if is_enabled_for (Error) then
				forced_log (Error, message)
			end
		end
	
	fatal (message: ANY) is
			-- Log a message object with the priority Fatal.
			-- First checks if this category is enabled 
			-- by comparing the priority of this category 
			-- with the Fatal priority. If this category 
			-- is error enabled, then it converts the 
			-- message object to a string by invoking 
			-- 'out'. It then proceeds to call all the 
			-- registered appenders in this category and 
			-- also higher in the hierarchy depending on 
			-- the value of the additivity flag.
		require
			message_exists: message /= Void
		do
			if is_enabled_for (Fatal) then
				forced_log (Fatal, message)
			end
		end
	
	log (event_priority: LOG_PRIORITY; message: ANY) is
			-- Log a general message. 
		require
			event_priority_exists: event_priority /= Void
			message_exists: message /= Void
		do
			if is_enabled_for (event_priority) then
				forced_log (event_priority, message)
			end
		end
	
feature {NONE} -- Implementation
	
	forced_log (event_priority: LOG_PRIORITY; message: STRING) is
			-- Create new logging event and send to appenders.
		require
			priority_exists: event_priority /= Void
			message_exists: message /= Void
		do
			call_appenders (create {LOGGING_EVENT}.make (Current, event_priority, message))
		end
	
feature {LOG_CATEGORY} -- Internal
	
	cat_priority: LOG_PRIORITY
			-- The assigned priority of this category. Void if the 
			-- categories priority should be inherited 
			-- from an ancestor.
				
invariant
	
	name_exists: name /= Void and then not name.empty
	no_parent_if_root: context.root = Current implies parent = Void 
	parent_if_not_root: context.root /= Current implies parent /= Void
	appenders_exist: appenders /= Void
	
end -- class LOG_CATEGORY
