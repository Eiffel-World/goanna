indexing
	description: "Creates unique URL strings"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "FastCGI Applications"
	date: "$Date: 2001/05/11"
	revision: "$Revision$"
	author: "Neal L. Lester <neal@3dsafety.com>"
	copyright: "Copyright (c) 2001 Lockheed-Martin Space System Company"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	UNIQUE_QUERY_STRING_FACTORY

inherit

	UNIQUE_STRING_SEQUENCE

create
	make

feature 

	storage_file_name : STRING is
		once
			Result := unique_query_string_factory_file_name
		end

end -- class UNIQUE_QUERY_STRING_FACTORY
