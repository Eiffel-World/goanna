indexing
	description: "Example for generating class documentation for all Goanna clases"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "examples"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class ALL_CLASSES

creation

	make

feature 

	make is
		do
		end

feature -- References

	dom: ALL_NODES
	servlet: SERVLET_SERVER
	parser: TREE_BUILDER
	xmle: XMLE
	routine: EIFFEL_ROUTINE

end
