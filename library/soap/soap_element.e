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

feature -- Initialization

	make is
			-- Initialise new SOAP envelope
		do
			create attributes.make_default
		end
	
	unmarshall (doc: DOM_DOCUMENT) is
			-- Initialise SOAP envelope from DOM document.
		require
			doc_exists: doc /= Void
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

	attributes: DS_HASH_TABLE [STRING, STRING]

feature -- Status setting

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

end -- class SOAP_ELEMENT
