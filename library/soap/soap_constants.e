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

feature -- Constants

	Ns_pre_xmlns: STRING is "xmlns"
	
	Ns_pre_soap: STRING is "SOAP"
	
	Ns_pre_soap_env: STRING is
	  	once
	  		Result := Ns_pre_soap + "-ENV"
	  	end
	  	
	Ns_pre_soap_enc: STRING is
		once
			Result := Ns_pre_soap + "-ENC"
		end
		
	Ns_pre_schema_xsi: STRING is "xsi"
	
	Ns_pre_schema_xsd: STRING is "xsd"

	Ns_uri_xmlns: STRING is "http://www.w3.org/2000/xmlns/"
	
	Ns_uri_soap_env: STRING is "http://schemas.xmlsoap.org/soap/envelope/"
	
	Ns_uri_soap_enc: STRING is "http://schemas.xmlsoap.org/soap/encoding/"
	
	Ns_uri_schema_xsi: STRING is "http://www.w3.org/1999/XMLSchema-instance"
	
	Ns_uri_schema_xsd: STRING is "http://www.w3.org/1999/XMLSchema"
	
	Ns_uri_xml_soap: STRING is "http://xml.apache.org/xml-soap"
	
	Ns_uri_xml_soap_deployment: STRING is "http://xml.apache.org/xml-soap/deployment"
	
	Ns_uri_literal_xml: STRING is "http://xml.apache.org/xml-soap/literalxml"
	
	Ns_uri_xmi_enc: STRING is "http://www.ibm.com/namespaces/xmi"

end -- class SOAP_CONSTANTS
