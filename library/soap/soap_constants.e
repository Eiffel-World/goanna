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

  	Header_post: STRING is "POST"
	Header_host: STRING is "Host"
	Header_content_type: STRING is "Content-Type"
	Header_content_length: STRING is "Content-Length"
	Header_content_location: STRING is "Content-Location"
	Header_content_id: STRING is "Content-ID"
	Header_soap_action: STRING is "SOAPAction"
	Header_authorization: STRING is "Authorization"

	Headerval_default_charset: STRING is "iso-8859-1"
	Headerval_charset_utf8: STRING is "utf-8"
	Headerval_content_type: STRING is "text/xml"
	Headerval_content_type_utf8: STRING is 
		once
			Result := Headerval_content_type + ";charset=" + Headerval_charset_utf8		
		end
	Headerval_content_type_multipart_primary: STRING is "multipart"
	Headerval_multipart_content_subtype: STRING is "related"
	Headerval_content_type_multipart: STRING is
		once
			Result := Headerval_content_type_multipart_primary + "/" + Headerval_multipart_content_subtype
		end

	Xml_decl: STRING is "<?xml version='1.0' encoding='UTF-8'?>%R%N"

	Elem_envelope: STRING is "Envelope"
	Elem_body: STRING is "Body"
	Elem_header: STRING is "Header"
	Elem_fault: STRING is "Fault"
	Elem_fault_code: STRING is "faultcode"
	Elem_fault_string: STRING is "faultstring"
	Elem_fault_actor: STRING is "faultactor"
	Elem_detail: STRING is "detail"
	Elem_fault_detail_entry: STRING is "detailEntry"

	Q_elem_envelope: Q_NAME is
		once
			create Result.make (Ns_uri_soap_env, Elem_envelope)
		end
	Q_elem_header: Q_NAME is
		once
			create Result.make (Ns_uri_soap_env, Elem_header)
		end
	Q_elem_body: Q_NAME is
		once
			create Result.make (Ns_uri_soap_env, Elem_body)
		end
	Q_elem_fault: Q_NAME is
		once
			create Result.make (Ns_uri_soap_env, Elem_fault)
		end

	Attr_encoding_style: STRING is "encodingStyle"
	Attr_must_understand: STRING is "mustUnderstand"
	Attr_type: STRING is "type"
	Attr_null: STRING is "null"
	Attr_array_type: STRING is "arrayType"
	Attr_reference: STRING is "href"
	Attr_id: STRING is "id"

	Q_attr_must_understand: Q_NAME is
		once
			create Result.make (Ns_uri_soap_env, Attr_must_understand)
		end

	Attrval_true: STRING is "true"

	Fault_code_version_mismatch: STRING is 
		once
			Result := Ns_pre_soap_env + ":VersionMismatch"
		end
	Fault_code_must_understand: STRING is
		once
			Result := Ns_pre_soap_env + ":MustUnderstand"
		end
	Fault_code_client: STRING is
		once
			Result := Ns_pre_soap_env + ":Client"
		end
	Fault_code_server: STRING is
		once
			Result := Ns_pre_soap_env + ":Server"
		end
	Fault_code_protocol: STRING is
		once
			Result := Ns_pre_soap_env + ":Protocol"
		end

	Fault_code_server_bar_target_object_uri: STRING is
		once
			Result := Fault_code_server + ".BadTargetObjectURI"
		end

	Err_msg_version_mismatch: STRING is
		once
			Result := Fault_code_version_mismatch + 
				": Envelope element must be associated with the '" +
      			Ns_uri_soap_env +
      			"' namespace."
      	end

end -- class SOAP_CONSTANTS
