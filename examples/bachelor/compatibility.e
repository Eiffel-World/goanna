indexing
	description: "Compatibility between user and girl friend"
	author: "Neal L. Lester (neal@3dsafety.com)"
	date: "$ May 11, 2001: $"
	revision: "$version 1.0$"

class
	COMPATIBILITY

inherit
	BACHELOR_TOPIC_WITH_SUBTOPICS

create
	make

feature -- Attributes

	she_is_pregnant : SHE_IS_PREGNANT

	has_a_girlfriend : HAS_A_GIRLFRIEND

	she_drinks : SHE_DRINKS

feature -- Implement deferred features

	add_subtopics is
		do
			create she_is_pregnant.make (current, user)
			create has_a_girlfriend.make (current, user)
			create she_drinks.make (current, user)
			subtopic_list.force (she_is_pregnant)
			subtopic_list.force (has_a_girlfriend)
			subtopic_list.force (she_drinks)
		end

	title : STRING is
		do
			result := text.compatibility
		end

	create_sequence is
		do
			add_element_container (~always_true, "True", page_factory~yes_no (she_is_pregnant))
			add_element_container (~ask_has_a_girlfriend, "Not Pregnant", page_factory~yes_no (has_a_girlfriend))
			add_element_container (~ask_she_drinks, "Not Pregnant and Has a Girlfriend", page_factory~yes_no (she_drinks))	
		end

	ask_has_a_girlfriend : BOOLEAN is
		-- Should the sequence activate the has a girlfriend question
		do
			result := not she_is_pregnant.yes
		end

	ask_she_drinks : BOOLEAN is
		-- Should the sequence active the does she drink question
		do
			result := (not she_is_pregnant.yes) and (has_a_girlfriend.yes)
		end

invariant

	valid_she_is_pregnant : she_is_pregnant /= Void
	valid_has_a_girlfriend : has_a_girlfriend /= Void
	valid_she_drinks : she_drinks /= Void

end -- class COMPATIBILITY
