<?xml version="1.0"?> 
<!--
     	description: "Transform xml conforming to page.rnc to html"
	author: "Neal L Lester	<neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2004 Neal L Lester"

-->
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:page="http://www.mysafetyprogram.com/page"
  xmlns:goa_common="http://www.sourceforge.net/projects/goanna/goa_common"
  xmlns:msp_common="http://www.mysafetyprogram.com/msp_common"
  exclude-result-prefixes="page goa_common msp_common"
  >
  
<xsl:output method="html" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" />

<xsl:include href="msp_common.xsl" />

<!-- FREEFORM TEMPLATE STARTS HERE -->

<xsl:template match="page:page">

	<HTML>
	<HEAD>
	
	<!-- Page Title -->

	<TITLE><xsl:value-of select="/page:page/@page_title" /></TITLE>

	<xsl:element name="LINK">
	
		<!-- Link to external stylesheet -->

		<xsl:attribute name="rel">stylesheet</xsl:attribute>
		<xsl:attribute name="type">text/css</xsl:attribute>
		<xsl:attribute name="href">http://<xsl:value-of select="/page:page/@server_name" />/<xsl:value-of select="/page:page/@style_sheet" /></xsl:attribute>
	</xsl:element>
	</HEAD>
	<BODY>
		<xsl:apply-templates />
	</BODY>
	</HTML>

</xsl:template>

</xsl:transform>