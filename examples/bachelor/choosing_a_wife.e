indexing
	description: "Advice on choosing a wife"
	author: "Neal L. Lester (neal@3dsafety.com)"
	date: "$ May 11, 2001: $"
	revision: "$version 1.0$"

class
	CHOOSING_A_WIFE

inherit
	BACHELOR_TOPIC_WITH_SUBTOPICS

create
	make_root

feature -- Attributes

	compatibility : COMPATIBILITY

	compatibility_sequence : PAGE_SEQUENCE is
		do
			result := compatibility
		end

	he_drinks : HE_DRINKS

feature -- Implement deferred features

	add_subtopics is
		do
			create compatibility.make (current, user)
			create he_drinks.make (current, user)
			subtopic_list.force (compatibility)
			subtopic_list.force (he_drinks)
		end

	title : STRING is
		do
			if user.personal_information.name.empty then
				result := text.choosing_a_wife
			else
				result := text.choosing_a_wife_for + user.personal_information.name
			end
		end

	create_sequence is
		do
			add_element_container (~always_true, "True", ~compatibility_sequence)
			add_element_container (~ask_he_drinks, "Not Pregnant", page_factory~yes_no (he_drinks))
			add_element_container (~always_true, "True", page_factory~advice (current))
		end

	ask_he_drinks : BOOLEAN is
		do
			result := compatibility.she_is_pregnant.no
		end

invariant

	valid_compatibility : compatibility /= Void
	valid_he_drinks : he_drinks /= Void

end -- class CHOOSING_A_WIFE
