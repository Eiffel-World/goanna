indexing
	description: "Domains that that have a status of yes or no"
	author: "Neal Lester"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	YES_NO

inherit
	TIME_STAMPED_DOMAIN
		redefine
			update, initialize, initialized
		end
	STATUS_DOMAIN
		redefine
			update, initialize, initialized
		end
	HISTORY_SAVING_DOMAIN
		redefine
			update, initialize, initialized
		end
	DOMAIN_WITH_PARENT
		redefine
			update, initialize, initialized
		end
	TOPIC

feature -- attributes

	yes: BOOLEAN is
			-- The status is 'yes'
		do
			result := equal (status_code, yes_code)
		end

	no: BOOLEAN is
			-- The status is 'no'
		do
			result := equal (status_code, no_code)
		end

	set_yes is
			-- Set status to yes
		do
			set_status_code (yes_code)
		ensure
			yes : yes
		end

	set_no is
			-- Set status to no
		do
			set_status_code (no_code)
		ensure
			no : no
		end

	question: STRING is
			-- The question that this topic asks
		deferred
		end

feature {NONE} -- implementation

	yes_code, no_code: INTEGER is unique
			-- Status codes

	update is
		do
			{TIME_STAMPED_DOMAIN} precursor
			{DOMAIN_WITH_PARENT} precursor
			{HISTORY_SAVING_DOMAIN} precursor
		end

	initialize is
		do
			{TIME_STAMPED_DOMAIN} precursor
			{HISTORY_SAVING_DOMAIN} precursor
		end

	initialized: BOOLEAN is
		do
			result := {TIME_STAMPED_DOMAIN} precursor and {HISTORY_SAVING_DOMAIN} precursor
		end

feature {NONE} -- Creation

	make_with_user_and_parent (new_parent: DOMAIN_WITH_CHILDREN; new_user: like user_anchor) is
		require
			new_user_exists: new_user /= Void
			new_parent_exists: new_parent /= Void
		do
			set_user (new_user)
			make_with_parent (new_parent)
		end
		
invariant

	yes_implies_evaluated : yes implies evaluated
	no_implies_evaluated : no implies evaluated
	yes_implies_not_no : yes implies not no
	no_implies_not_yes : no implies not yes

end -- class YES_NO
