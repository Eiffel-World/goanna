indexing
	description: "All of the text that may be presented to the user as content"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI Applications"
	date: "$Date: 2001/05/11"
	revision: "$Revision$"
	author: "Neal L. Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Lockheed-Martin Space System Company"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	TEXT_LIST


create
	make

feature {NONE} -- Initialization
	make is
		do
		end

feature  -- Text

	application_title : STRING is ""
		-- This string is placed in the title bar of every page with the page context

	language : STRING is "english"

	yes : STRING is "Yes"

	no : STRING is "No"

	more : STRING is "More"

	previous : STRING is "Previous"

	submit : STRING is "Submit"

	no_text : STRING is ""

	continue : STRING is "Continue"

	done : STRING is "Done"

-- Personal information

	personal_information : STRING is "Personal Information"

-- Login Sequence

	user_login : STRING is "User Login"

	login_user_id : STRING is "User ID:"

	login_password : STRING is "Password:"

	login_confirm_password : STRING is "Confirm Password:"

	login_new_user : STRING is "Your Name:"

	login_user_id_error_message : STRING is 
		do
			result := "This User ID does not match anything on our user list.  Please enter a different User ID or click on '" + login_wrong_form_button_text + "'.  Check your CAPS LOCK key, this entry is case sensitive."
		end

	login_password_error_message : STRING is "The password you entered does match the one on file for this User ID.  Please re-enter your password.  Check your CAPS LOCK key, this entry is case sensitive."

	login_button_label : STRING is "Login"

	new_user_button_label : STRING is "Login as a New User"

	login_wrong_form_button_text : STRING is "I Don't Have a User ID"

	new_user_wrong_form_button_text : STRING is "I Already Have a User ID"

	new_user_id_empty : STRING is "You may not enter a blank User ID.  Please enter a User ID."

	new_user_id_exists : STRING is 
		do
			result := "The User ID you entered is already in use by another person.  Please enter another user ID or click on %"" + new_user_wrong_form_button_text + "%"."
		end

	confirm_password_error_message : STRING is "The entry in the 'Confirm Password' box does not match the entry in the 'Password' box.  Please retype them both; they must be the same in order to confirm that we have correctly understood your proposed password."

-- Choosing a wife

	goanna_application : STRING is "This is a GOANNA Application"

	choosing_a_wife : STRING is "Choosing A Wife"

	choosing_a_wife_for : STRING is "Choosing A Wife For "
		-- Needs trailing space; users name will be added

	compatibility : STRING is "Compatibility"

	he_drinks : STRING is "Do you drink?"

	she_drinks : STRING is "Does she drink?"

	has_a_girlfriend : STRING is "Do you have a girlfriend?"

	she_is_pregnant : STRING is "Is she pregnant?"

	her_habits : STRING is "Her Habits"

	his_habits : STRING is "Your Habits"

	too_late : STRING is "It is too late for you, my friend, she has already chosen you!"

	marry_at_pub : STRING is "Marry her soon, at the pub!"

	marry_at_church : STRING is "Marry her soon, at a church/mosque/temple!"

	your_a_saint : STRING is "She will never be happy with such a saint!"

	your_a_drunkard : STRING is "She will never be happy with such a drunkard!"

	try_a_pub : STRING is "You won't find a wife here.  Try going to the local pub!"

	try_a_church : STRING is "You won't find a wife here.  Try going to the local church/mosque/temple!"



end -- class TEXT_LIST