<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" indent="yes" />
	
	<xsl:template name="show">
		<xsl:param name="indent"/>
		<xsl:param name="name"/>
		<xsl:param name="value"/>
		<xsl:if test="$value">
			<xsl:value-of select="$indent" />
			<xsl:text>| </xsl:text>
			<xsl:value-of select="$name" />
			<xsl:choose>
				<xsl:when test="contains($value, '&#10;') or contains($value, '&#13;')">
					<xsl:text>&#10;---------------------------&#10;'</xsl:text>
					<xsl:value-of select="$value" />
					<xsl:text>'&#10;---------------------------&#10;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring('                ', 1, 16 - string-length($name))" />
					<xsl:text>: '</xsl:text>
					<xsl:value-of select="$value" />
					<xsl:text>'&#10;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="/ | node() | @*">
		<xsl:param name="path" select="''" />
		<xsl:param name="indent" />
		<xsl:param name="type">
			<xsl:apply-templates select="." mode="type"/>
		</xsl:param>
		<xsl:value-of select="$indent" />
		<xsl:text>---------------------------&#10;</xsl:text>
		<xsl:call-template name="show">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="name"   select="'$path'"/>
			<xsl:with-param name="value"  select="$path"/>
		</xsl:call-template>
		<xsl:call-template name="show">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="name"   select="'match'"/>
			<xsl:with-param name="value"  select="$type"/>
		</xsl:call-template>
		<xsl:call-template name="show">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="name"   select="'position()'"/>
			<xsl:with-param name="value"  select="position()"/>
		</xsl:call-template>
		<xsl:call-template name="show">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="name"   select="'name()'"/>
			<xsl:with-param name="value"  select="name()"/>
		</xsl:call-template>
		<xsl:call-template name="show">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="name"   select="'local-name()'"/>
			<xsl:with-param name="value"  select="local-name()"/>
		</xsl:call-template>
		<xsl:call-template name="show">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="name"   select="'namespace-uri()'"/>
			<xsl:with-param name="value"  select="namespace-uri()"/>
		</xsl:call-template>
		<xsl:call-template name="show">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="name"   select="'string(.)'"/>
			<xsl:with-param name="value"  select="string(.)"/>
		</xsl:call-template>

		<xsl:if test="@*">
			<xsl:call-template name="show">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="name"   select="'count(@*)'"/>
				<xsl:with-param name="value"  select="count(@*)"/>
			</xsl:call-template>
			<xsl:value-of select="$indent" />
			<xsl:text>| @*&#10;</xsl:text>
			<xsl:apply-templates select="@*">
				<xsl:with-param name="indent" select="concat('|&#9;', $indent)" />
				<xsl:with-param name="path" select="concat($path, name(), '/')" />
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="node()">
			<xsl:call-template name="show">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="name"   select="'count(node())'"/>
				<xsl:with-param name="value"  select="count(node())"/>
			</xsl:call-template>
			<xsl:value-of select="$indent" />
			<xsl:text>| node()&#10;</xsl:text>
			<xsl:apply-templates select="node()">
				<xsl:with-param name="indent" select="concat('|&#9;', $indent)" />
				<xsl:with-param name="path" select="concat($path, name(), '/')" />
			</xsl:apply-templates>
		</xsl:if>
		<xsl:value-of select="$indent" /><xsl:text>---------------------------&#10;</xsl:text>
	</xsl:template>
	
	<xsl:template mode="type" match="/">/</xsl:template>
	
	<xsl:template mode="type" match="node()">node()</xsl:template>
	
	<xsl:template mode="type" match="*">*</xsl:template>
	
	<xsl:template mode="type" match="@*">@*</xsl:template>
	
	<xsl:template mode="type" match="text()">text()</xsl:template>
	
	<xsl:template mode="type" match="comment()">comment()</xsl:template>
	
	<xsl:template mode="type" match="processing-instruction()">processing-instruction()</xsl:template>
</xsl:stylesheet>