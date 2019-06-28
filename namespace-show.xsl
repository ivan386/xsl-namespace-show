<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" indent="yes" />
	<xsl:template match="node()">
		<xsl:param name="indent" />
<xsl:value-of select="$indent" />element: <xsl:value-of select="name()" /><xsl:text>&#10;</xsl:text>
<xsl:value-of select="$indent" />namespace: <xsl:value-of select="namespace-uri()" /><xsl:text>&#10;</xsl:text>
<xsl:value-of select="$indent" />value: "<xsl:value-of select="." />"<xsl:text>&#10;&#10;</xsl:text>
		<xsl:apply-templates select="@*|node()">
			<xsl:with-param name="indent" select="concat('&#9;', $indent)" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="@*">
		<xsl:param name="indent" />
<xsl:value-of select="$indent" />attribut: <xsl:value-of select="name()" /><xsl:text>&#10;</xsl:text>
<xsl:value-of select="$indent" />namespace: <xsl:value-of select="namespace-uri()" /><xsl:text>&#10;</xsl:text>
<xsl:value-of select="$indent" />value: "<xsl:value-of select="." />"<xsl:text>&#10;&#10;</xsl:text>
		<xsl:apply-templates select="@*|node()">
			<xsl:with-param name="indent" select="concat('&#9;', $indent)" />
		</xsl:apply-templates>
	</xsl:template>
</xsl:stylesheet>