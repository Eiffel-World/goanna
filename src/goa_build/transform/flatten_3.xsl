<?xml version="1.0"?> 
<!--
     	description: "Flatten a Relax NG grammer to inline referenced Include statements; combine files"
	author: "Neal L Lester <neal@3dsafety.com>"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2004 Neal L Lester"
	license:   "Eiffel Forum License V2.0 (http://www.opensource.org/licenses/ver2_eiffel.php)"

-->
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
   xmlns:rng="http://relaxng.org/ns/structure/1.0"
   exclude-result-prefixes="rng">

<xsl:template match="*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()" />
  </xsl:copy>
</xsl:template>

<xsl:template match="rng:include">
</xsl:template>

</xsl:transform>