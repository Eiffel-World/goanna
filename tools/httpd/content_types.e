indexing
	description: "Content type information"
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "tools httpd"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	CONTENT_TYPES

feature -- Access


	Content_type_text_html: INTEGER is 1
	Content_type_text_xml: INTEGER is 2
	Content_type_text_css: INTEGER is 3
	Content_type_text_xsl: INTEGER is 4
	Content_type_text_rtf: INTEGER is 5
	Content_type_image_gif: INTEGER is 6
	Content_type_image_jpeg: INTEGER is 7
	Content_type_image_png: INTEGER is 8
	Content_type_image_tiff: INTEGER is 9
	
	First_content_type: INTEGER is 1
	Last_content_type: INTEGER is 9
	
	content_type_codes: DS_HASH_TABLE [INTEGER, STRING] is
			-- Table of content type codes. Codes map into content_types table
		once
			create Result.make (30) 
			Result.put (Content_type_text_html, "html")
			Result.put (Content_type_text_html, "htm")
			Result.put (Content_type_text_xml, "xml")
			Result.put (Content_type_text_css, "css")
			Result.put (Content_type_text_xsl, "xsl")
			Result.put (Content_type_text_rtf, "rtf")
			Result.put (Content_type_image_gif, "gif")
			Result.put (Content_type_image_jpeg, "jpeg")
			Result.put (Content_type_image_jpeg, "jpg")
			Result.put (Content_type_image_png, "png")
			Result.put (Content_type_image_tiff, "tiff")
		end

	content_types: ARRAY [STRING] is
			-- Table of content types indexed by code.
		once
			create Result.make (First_content_type, Last_content_type) 
			Result.put ("text/html", Content_type_text_html)
			Result.put ("text/xml", Content_type_text_xml)
			Result.put ("text/css", Content_type_text_css)
			Result.put ("text/xsl", Content_type_text_xsl)
			Result.put ("text/rtf", Content_type_text_rtf)
			Result.put ("image/gif", Content_type_image_gif)
			Result.put ("image/jpeg", Content_type_image_jpeg)
			Result.put ("image/png", Content_type_image_png)
			Result.put ("image/tiff", Content_type_image_tiff)
		end
			
	extension (uri: STRING): STRING is
			-- extract extention from a URI
		local
			i: INTEGER
		do
			-- going from the end find the position of the "."
			from
				i := uri.count
			until
				i = 0 or else uri.item (i) = '.'
			loop
				i := i - 1
			end
			Result := uri.substring (i + 1, uri.count)
		end
	
end -- class CONTENT_TYPES