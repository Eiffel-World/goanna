indexing
	description: "A PAGE_XML_DOCUMENT with Manually extended features"
	author: "Neal L Lester <neallester@users.sourceforge.net>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "(c) Neal L Lester"
	License: "Eiffel Forum License Version 2 (see forum.txt)"

class
	EXTENDED_PAGE_XML_DOCUMENT

inherit
	PAGE_XML_DOCUMENT
	XML_FACILITIES
	GOA_SHARED_APPLICATION_CONFIGURATION
	GOA_TEXT_PROCESSING_FACILITIES
	SHARED_GOA_REQUEST_PARAMETERS
	SHARED_DATABASE_SESSION
	GOA_HYPERLINK_FACTORY
	
creation

	make_iso_8859_1_encoded, make_utf8_encoded

		
feature
		

end -- class EXTENDED_PAGE_XML_DOCUMENT
