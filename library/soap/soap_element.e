indexing
	description: "Abstract bjects that represent general SOAP element facilities."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

deferred class

	SOAP_ELEMENT

inherit
	
	SOAP_CONSTANTS
		export
			{NONE} all
		end
		
feature -- Initialization

	make is
			-- Initialise new SOAP envelope
		do
			create attributes.make_default
			create entries.make_default
		end
	
	unmarshall (element: DOM_ELEMENT) is
			-- Initialise SOAP envelope from DOM element.
		require
			element_exists: element /= Void
		deferred			
		end

feature -- Mashalling

	marshall (sink: IO_MEDIUM) is
			-- Serialize this envelope on 'sink' in XML format
		require
			sink_exists: sink /= Void
		deferred	
		end

feature -- Access

	entries: DS_LINKED_LIST [DOM_ELEMENT]
			-- Child elements of this element.

	attributes: DS_HASH_TABLE [STRING, STRING]
			-- Element attributes.

feature -- Element change

	add_attribute (name, value: STRING) is
			-- Add attribute named 'name' with 'value'
		require
			name_exists: name /= Void
			value_exists: value /= Void
			not_has_attribute: not has_attribute (name)
		do
			attributes.force (value, name)
		ensure
			has_attribute: has_attribute (name) and then attributes.item (name).is_equal (value)
		end
		
	has_attribute (name: STRING): BOOLEAN is
			-- Does the body have an attribute named 'name'?
		require
			name_exists: name /= Void
		do
			Result := attributes.has (name)
		ensure
			true_if_found: Result = attributes.has (name)
		end
		
	remove_attribute (name: STRING) is
			-- Remove attribute named 'name'
		require
			name_exists: name /= Void
		do
			attributes.remove (name)
		ensure
			removed: not attributes.has (name)
		end

	set_entries (new_entries: DS_LINKED_LIST [DOM_ELEMENT]) is
			-- Assign `new_entries' to `elements'.
		require
			new_entries_exist: new_entries /= Void
		do
			entries := new_entries
		ensure
			entries_assigned: entries = new_entries
		end

invariant

	entries_exist: entries /= Void
	attributes_exist: attributes /= Void
	
end -- class SOAP_ELEMENT
