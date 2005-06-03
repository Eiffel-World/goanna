indexing
	description: "SOAP constant values."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum License v2 (see forum.txt)."

class GOA_SOAP_CONSTANTS

inherit

	XM_MARKUP_CONSTANTS

feature -- XML constants and routines

	Xml_prolog: STRING is "<?xml version=%"1.0%" encoding=%"UTF-8%"?>"

	Xml_start_tag (a_tag_name: STRING): STRING is
			-- Opening start tag
		require
			tag_name_not_empty: a_tag_name /= Void and then not a_tag_name.is_empty
		do
			create Result.make (a_tag_name.count + Ns_prefix_env.count + 2)
			Result.append (Stag_start)
			Result.append (Ns_prefix_env)
			Result.append (Prefix_separator)
			Result.append (a_tag_name)
		ensure
			result_not_void: Result /= Void
		end

	Xml_close_tag (a_tag_name: STRING): STRING is
			-- Closing tag
		require
			tag_name_not_empty: a_tag_name /= Void and then not a_tag_name.is_empty
		do
			create Result.make (a_tag_name.count + Ns_prefix_env.count + 4)
			Result.append (Etag_start)
			Result.append (Ns_prefix_env)
			Result.append (Prefix_separator)
			Result.append (a_tag_name)
			Result.append (Etag_end)
		ensure
			result_not_void: Result /= Void
		end

feature -- Namespace constants

	Ns_opening_brace: STRING is 
		once 
			create Result.make_from_string ("{")
		end

	Ns_closing_brace: STRING is 
		once 
			create Result.make_from_string ("}")
		end

	Ns_prefix_env: STRING is 
		once 
			create Result.make_from_string ("env")
		end
		
	Ns_name_env: STRING is 
		once 
			create Result.make_from_string ("http://www.w3.org/2003/05/soap-envelope")
		end
	
	Ns_prefix_enc: STRING is "enc"
	Ns_name_enc: STRING is "http://www.w3.org/2003/09/soap-encoding"
	
	Ns_prefix_xs: STRING is "xs"
	Ns_name_xs: STRING is "http://www.w3.org/2001/XMLSchema"
	
	Ns_prefix_xsi: STRING is "xsi"
	Ns_name_xsi: STRING is "http://www.w3.org/2001/XMLSchema-instance"
	
feature -- Role constants

	Role_next: STRING is "http://www.w3.org/2003/05/soap-envelope/role/next"
	Role_ultimate_receiver: STRING is "http://www.w3.org/2003/05/soap-envelope/role/ultimateReceiver"
	Role_none: STRING is "http://www.w3.org/2003/05/soap-envelope/role/none"
	
feature -- Element constants

	Envelope_element_name: STRING is 
		once 
			create Result.make_from_string ("Envelope")
		end
		
	Header_element_name: STRING is 
		once 
			create Result.make_from_string ("Header")
		end
		
	Body_element_name: STRING is 
		once 
			create Result.make_from_string ("Body")
		end
		
	Fault_element_name: STRING is 
		once 
			create Result.make_from_string ("Fault")
		end
		
	Fault_node_element_name: STRING is 
		once 
			create Result.make_from_string ("Node")
		end
		
	Fault_reason_element_name: STRING is 
		once 
			create Result.make_from_string ("Reason")
		end

	Reason_text_element_name: STRING is 
		once 
			create Result.make_from_string ("Text")
		end

	Fault_value_element_name: STRING is 
		once 
			create Result.make_from_string ("Value")
		end
				
	Fault_role_element_name: STRING is 
		once 
			create Result.make_from_string ("Role")
		end

	Fault_code_element_name: STRING is 
		once 
			create Result.make_from_string ("Code")
		end
		
	Fault_subcode_element_name: STRING is 
		once 
			create Result.make_from_string ("Subcode")
		end
		
	Fault_detail_element_name: STRING is 
		once 
			create Result.make_from_string ("Detail")
		end

	Upgrade_element_name: STRING is 
		once 
			create Result.make_from_string ("Upgrade")
		end

	Not_understood_element_name: STRING is 
		once 
			create Result.make_from_string ("NotUnderstood")
		end

	Supported_envelope_element_name: STRING is 
		once 
			create Result.make_from_string ("SupportedEnvelope")
		end

feature -- Attribute constants

	Encoding_style_attr: STRING is 
		once 
			create Result.make_from_string ("encodingStyle")
		end
		
	Must_understand_attr: STRING is 
		once 
			create Result.make_from_string ("mustUnderstand")
		end
		
	Role_attr: STRING is 
		once 
			create Result.make_from_string ("role")
		end

	Relay_attr: STRING is 
		once 
			create Result.make_from_string ("relay")
		end

	Qname_attr: STRING is 
		once 
			create Result.make_from_string ("qname")
		end

feature -- Error strings

	Wrong_envelope_error: STRING is 
		once 
			create Result.make_from_string ("Not a recognised Envelope")
		end

feature -- Value marshalling

	True_value: STRING is
		once 
			create Result.make_from_string ("true")
		end

	value_factory: GOA_SOAP_VALUE_FACTORY is
			-- Value marshalling factory
		once
			create Result.make
		end
		
end -- class GOA_SOAP_CONSTANTS
