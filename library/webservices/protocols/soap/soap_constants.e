indexing
	description: "SOAP constant values."
	project: "Project Goanna <http://sourceforge.net/projects/goanna>"
	library: "SOAP"
	date: "$Date$"
	revision: "$Revision$"
	author: "Glenn Maughan <glennmaughan@optushome.com.au>"
	copyright: "Copyright (c) 2001 Glenn Maughan and others"
	license: "Eiffel Forum Freeware License v1 (see forum.txt)."

class
	SOAP_CONSTANTS

feature -- XML constants

	Xml_prolog: STRING is "<?xml version=%"1.0%"?>"
	
feature -- Namespace constants

	Ns_separator: UC_STRING is 
		once 
			create Result.make_from_string (":")
		end
	
	Ns_prefix_env: UC_STRING is 
		once 
			create Result.make_from_string ("env")
		end
		
	Ns_name_env: UC_STRING is 
		once 
			create Result.make_from_string ("http://www.w3.org/2001/09/soap-envelope")
		end
	
	Ns_prefix_enc: STRING is "enc"
	Ns_name_enc: STRING is "http://www.w3.org/2001/09/soap-encoding"
	
	Ns_prefix_xs: STRING is "xs"
	Ns_name_xs: STRING is "http://www.w3.org/2001/XMLSchema"
	
	Ns_prefix_xsi: STRING is "xsi"
	Ns_name_xsi: STRING is "http://www.w3.org/2001/XMLSchema-instance"
	
	Ns_prefix_fault: STRING is "fault"
	Ns_name_fault: STRING is "http://www.w3.org/2001/09/soap-faults"
	
	Ns_prefix_upgrade: STRING is "upgrade"
	Ns_name_upgrade: STRING is "http://www.w3.org/2001/09/soap-upgrade"
	
feature -- Actor constants

	Actor_next: STRING is "http://www.w3.org/2001/09/soap-envelope/actor/next"
	Actor_none: STRING is "http://www.w3.org/2001/09/soap-envelope/actor/none"
	
feature -- Element constants

	Envelope_element_name: UC_STRING is 
		once 
			create Result.make_from_string ("Envelope")
		end
		
	Header_element_name: UC_STRING is 
		once 
			create Result.make_from_string ("Header")
		end
		
	Body_element_name: UC_STRING is 
		once 
			create Result.make_from_string ("Body")
		end
		
	Fault_element_name: UC_STRING is 
		once 
			create Result.make_from_string ("Fault")
		end
		
	Fault_code_element_name: UC_STRING is 
		once 
			create Result.make_from_string ("faultcode")
		end
		
	Fault_string_element_name: UC_STRING is 
		once 
			create Result.make_from_string ("faultstring")
		end
		
	Fault_actor_element_name: UC_STRING is 
		once 
			create Result.make_from_string ("faultactor")
		end
		
	Fault_detail_element_name: UC_STRING is 
		once 
			create Result.make_from_string ("detail")
		end
	
feature -- Attribute constants

	Encoding_style_attr: UC_STRING is 
		once 
			create Result.make_from_string ("encodingStyle")
		end
		
	Must_understand_attr: UC_STRING is 
		once 
			create Result.make_from_string ("mustUnderstand")
		end
		
	Actor_attr: UC_STRING is 
		once 
			create Result.make_from_string ("actor")
		end

feature -- Pre-defined fault code constants

	Version_mismatch_fault_code: STRING is "VersionMismatch"
	Must_understand_fault_code: STRING is "MustUnderstand"
	Data_encoding_unknown_fault_code: STRING is "DataEncodingUnknown"
	Client_fault_code: STRING is "Client"
	Server_fault_code: STRING is "Server"
	
feature -- Value marshalling

	value_factory: SOAP_VALUE_FACTORY is
			-- Value marshalling factory
		once
			create Result.make
		end
		
end -- class SOAP_CONSTANTS
