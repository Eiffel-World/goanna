indexing
	description: "List of system users"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI Applications"
	date: "$Date: 2001/05/10"
	revision: "$Revision$"
	author: "Neal L. Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Lockheed-Martin Space System Company"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	USER_LIST

inherit

	USER_ANCHOR
	HASH_TABLE [USER_LIST_ELEMENT, STRING]

		export {NONE}
			all
		{LOGIN_SEQUENCE}
			has, item
		undefine
			is_equal, copy
		redefine
			extend
		end

	STORABLE

	SYSTEM_CONSTANTS
		undefine
			is_equal, copy
		end

create
	make

-- To Do: Store passwords securely rather than as clear text
-- Could possibly be done by encrypting the user_list storage file at the operating system
-- Level rather than at the application level

feature {LOGIN_SEQUENCE}

	retrieved_user (user_id, password : STRING) : like user_anchor is
		-- Retrieve a user from user_list
		require
			user_id_in_list : has (user_id)
			valid_password : equal (item(user_id).password, password)
		local
			test_file_name : STRING
			new_user : like user_anchor
			full_name : STRING
			a_file : ANY
		do
			test_file_name := item(user_id).file_name
			full_name := data_directory + directory_separator + item(user_id).file_name + file_extension
			a_file := retrieve_by_name (full_name)
			new_user ?= a_file
			result := new_user
		ensure
			valid_result : result /= Void
		end

	add_new_user (new_user_id, new_password, new_file_name : STRING) is
		-- Add a new user to the user_list
		require
			valid_new_user_id : new_user_id /= Void
			new_user_id_not_empty : not new_user_id.empty
			not_has_new_user_id : not has (new_user_id)
			valid_new_password : new_password /= Void
			valid_new_file_name : new_file_name /= Void
			new_file_name_not_empty : not new_file_name.empty
		local
			new_list_element : USER_LIST_ELEMENT
		do
			create new_list_element.make (new_user_id, new_password, new_file_name)
			extend (new_list_element, new_user_id)
		ensure
			has_new_list_element : has (new_user_id)
			new_element_name_new_user : equal (item (new_user_id).user_id, new_user_id)
			new_element_password_new_password : equal (item (new_user_id).password, new_password)
			new_element_file_name_new_file_name : equal (item (new_user_id).file_name, new_file_name)
		end


feature {NONE} -- Implementation

	extend (new: USER_LIST_ELEMENT; key: STRING) is
		-- Add a new user_element to the list, acessible through key
		do
			precursor (new, key)
			store_by_name (user_list_file_name)
		ensure then
			key_is_user_id : new.user_id = key
		end

end -- class USER_LIST
