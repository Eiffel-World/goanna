indexing
	description: "A topic in the application"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI Applications"
	date: "$Date: 2001/05/14"
	revision: "$Revision$"
	author: "Neal L. Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Lockheed-Martin Space System Company"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	TOPIC

inherit

	PROCESSOR_HOST
	UNDOABLE
	USER_ANCHOR
	DT_SHARED_SYSTEM_CLOCK

feature {PAGE, PAGE_FACTORY, TOPIC, PAGE_SEQUENCE_ELEMENT, SUBDOMAIN_ITERATOR, FORM, FORM_ELEMENT} -- Attributes

	time_last_modified : DT_DATE_TIME
		-- The date & time any attribute in the topic was last modified.

	page_sequencer : PAGE_SEQUENCER is
		-- Current page_sequencer (from user)
		do
			result := user.page_sequencer
		end

	undo is
		-- Return this topic to the state before last change
		do
		end

	user : like user_anchor

	title : STRING is
		-- The plain text title
		deferred
		end

feature {TOPIC}-- Operations

	receive_child_notification (child_time_modified : DT_DATE_TIME) is
		-- Receive notification from child that it has been modified
		require
			valid_child_time_modified : child_time_modified /= Void
		do
			time_last_modified := child_time_modified
			if has_parent then
				parent.receive_child_notification (child_time_modified)
			end
		ensure
			time_last_modified_updated : time_last_modified = child_time_modified
			has_parent_implies_updated_parent_time : has_parent IMPLIES (parent.time_last_modified = time_last_modified)
		end

	initialized : BOOLEAN
		-- Has this topic been fully initialized

	has_parent : BOOLEAN
		-- The topic has a parent

	parent : TOPIC_WITH_SUBTOPICS
		-- The parent domain of the exposure

	parent_initialized : BOOLEAN is
		-- Has the parent been initialized
		do
			if has_parent then
				result := parent.initialized
			else
				result := false
			end
		end

feature {NONE} -- Implementation

	update is
		-- update domain after an attribute has been changed
		local
			current_time : DT_DATE_TIME
		do
			time_last_modified := system_clock.date_time_now
			if has_parent then
				parent.receive_child_notification (time_last_modified)
			end
		ensure
			time_last_modified_updated : time_last_modified /= old time_last_modified
			has_parent_implies_parent_time_updated : has_parent IMPLIES parent.time_last_modified = time_last_modified
		end

feature {NONE} -- Creation

	make (proposed_parent : TOPIC_WITH_SUBTOPICS; proposed_user : like user_anchor) is
		-- make an exposure object which has a parent domain
		require
			proposed_parent_not_void : proposed_parent /= Void
		do
			has_parent := True
			parent := proposed_parent
			initialize (proposed_user)
			initialized := true
		end

	make_root (proposed_user : like user_anchor) is
		-- make an exposure object which is a root domain (no parent)
		require
			valid_proposed_user : proposed_user /= Void
		do
			initialize (proposed_user)
			initialized := true
		end

	initialize (proposed_user : like user_anchor) is
		-- Initialize the exposure domain
		do
			user := proposed_user
			time_last_modified := system_clock.date_time_now
		end

invariant
	
	valid_user : user /= Void
	valid_time_last_modified : time_last_modified /= Void
	initialized : initialized
	has_parent_implies_registered : (parent_initialized) implies parent.registered (current)
	has_parent_imples_valid_parent : has_parent implies parent /= Void
	not_has_parent_implies_void_parent : NOT has_parent implies parent = Void


end -- class TOPIC
