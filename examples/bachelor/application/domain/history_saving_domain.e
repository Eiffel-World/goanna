indexing
	description: "Domains that maintain a history of their past states"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI Applications"
	date: "$Date: 2001/06/13"
	revision: "$Revision$"
	author: "Neal L. Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Lockheed-Martin Space System Company"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class
	HISTORY_SAVING_DOMAIN

inherit
	DOMAIN

feature

	undo is
		-- Undo the last change to the domain
		do
			if history.count <= 1 then
					-- nothing
			else
				history.prune_first (1)
				copy (history.first)
			end				
		ensure then
			history_copied : equal(history.first,current)
			history_first_is_not_current : history.first /= current
		end

feature {NONE} -- Implementation

	history : DS_LINKED_LIST [like CURRENT]
		-- Previous values of the current topic

	initialize is
		do
			create history.make
			history_initialized := true
			history.put_first (clone(current))
		ensure then
			history.count = 1
		end

	history_initialized: BOOLEAN

	update is
		do
			history.put_first(clone(current))
		ensure then
			old_current_and_history_first_equal: equal(old current, history.first)
		end

	initialized: BOOLEAN is
		do
			result := history_initialized
		end

invariant

	initilaized_implies_history_initialized: initialized implies history_initialized
	history_exists: history /= Void

end -- class HISTORY_SAVING_DOMAIN

