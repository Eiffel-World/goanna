indexing
	description: "Objects that represent a small amount of information sent %
		%by a servlet to a Web browser, saved by the browser, and later sent %
		%back to the server."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "HTTP Servlet API"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	COOKIE

creation

	make
	
feature -- Initialization

	make (new_name, new_value: STRING) is
			-- Create a new cookie with 'new_name' and 'new_value'
		require
			name_not_reserved_word: not is_reserved_cookie_word (new_name)
		do
			name := new_name
			value := new_value
			set_max_age (-1)
			set_version (Default_version)
		end
	
feature -- Access

	name: STRING
			-- Name of this cookie
			
	value: STRING
			-- Value of this cookie
			
	comment: STRING
			-- Optional cookie comment
			
	domain: STRING
			-- Optional dDomain that will see cookie
			
	max_age: INTEGER
			-- Optional maximum age of this cookie, -1 if no expiry.
			
	path: STRING
			-- Optional URL that will see cookie
			
	secure: BOOLEAN
			-- Optional use SSL?
			
	version: INTEGER
			-- Version
			
feature -- Status setting

	set_comment (new_comment: like comment) is
			-- Set 'comment' to 'new_comment'
		require
			new_comment_exists: new_comment /= Void
		do
			comment := clone (new_comment)
		end
	
	set_domain (new_domain: like domain) is
			-- Set 'domain' to 'new_domain'
		require
			new_domain_exists: new_domain /= Void
		do
			domain := clone (new_domain)
		end
	
	set_max_age (new_max_age: like max_age) is
			-- Set 'max_age' to 'new_max_age'
		do
			max_age := new_max_age
		end

	set_path (new_path: like path) is
			-- Set 'path' to 'new_path'
		require
			new_path_exists: new_path /= Void
		do
			path := clone (new_path)
		end
	
	set_secure (flag: like secure) is
			-- Set 'secure' to 'flag'
		do
			secure := flag
		end
	
	set_version (new_version: like version)	is
			-- Set 'version' to new_version
		do
			version := new_version
		end
	
feature -- Validation

	is_reserved_cookie_word (word: STRING): BOOLEAN is
			-- Is 'word' a reserved cookie word?
		require
			word_exists: word /= Void	
		local
			lower_word: STRING		
		do
			lower_word := clone (word)
			lower_word.to_lower
			Result := lower_word.is_equal ("comment")
				or lower_word.is_equal ("discard")
				or lower_word.is_equal ("domain")
				or lower_word.is_equal ("expires")
				or lower_word.is_equal ("max-age")
				or lower_word.is_equal ("path")
				or lower_word.is_equal ("secure")
				or lower_word.is_equal ("version")
		end
	
feature -- Conversion

	header_string: STRING is
			-- Return string representation of this cookie suitable for
			-- a request header value. This routine formats the cookie using
			-- version 0 of the cookie spec (RFC 2109).
		do
			create Result.make (50)
			Result.append (name)
			Result.append (Name_value_separator)
			Result.append ("%"" + value + "%"")
			-- version
			Result.append (Term_separator)
			Result.append (Version_label)
			Result.append (Name_value_separator)
			Result.append ("%"" + version.out + "%"")
			-- optional comment
			if comment /= Void and not comment.is_empty then
				Result.append (Term_separator)
				Result.append (Comment_label)
				Result.append (Name_value_separator)
				Result.append ("%"" + comment + "%"")
			end
			-- optional expires (depends on version)
			if max_age >= 0 then
				Result.append (Term_separator)
				Result.append (Expires_label)
				Result.append (Name_value_separator)
				if max_age = 0 then
					Result.append ("%"0%"")
				else
					Result.append ("%"Sun, 20 Jan 2001 00:00:00 GMT%"")	-- TODO: convert max-age to real date
				end
			end
			-- optional domain
			if domain /= Void and not domain.is_empty then
				Result.append (Term_separator)
				Result.append (Domain_label)
				Result.append (Name_value_separator)
				Result.append ("%"" + domain + "%"")
			end
			-- optional path
			if path /= Void and not path.is_empty then
				Result.append (Term_separator)
				Result.append (Path_label)
				Result.append (Name_value_separator)
				Result.append ("%"" + path + "%"")
			end
			-- optional secure, no value
			if secure then
				Result.append (Term_separator)
				Result.append (Secure_label)
			end
		end

	Comment_label: STRING is "Comment"
	Discard_label: STRING is "Discard"
	Domain_label: STRING is "Domain"
	Expires_label: STRING is "Expires"
	Max_age_label: STRING is "Max-Age"
	Path_label: STRING is "Path"
	Secure_label: STRING is "Secure"
	Version_label: STRING is "Version"
	
	Name_value_separator: STRING is "="
	Term_separator: STRING is "; "
	
	Default_version: INTEGER is 0
		
invariant

	name_exists: name /= Void
	value_exists: value /= Void
	
end -- class COOKIE
