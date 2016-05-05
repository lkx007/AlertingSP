<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" >

<xsl:output method="xml" indent="yes" name="xml"/>

<xsl:variable name="epoch" select="current-dateTime() - xs:dateTime('1970-01-01T00:00:00+00:00')" />
<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - 600)" />

<xsl:template match="/">
<xsl:result-document href="conf/tmp/out.xml" format="xml">
<data>
	<xsl:for-each select="//VALUE.NAMEDINSTANCE/INSTANCE">
		<xsl:if test="$startdate &lt; PROPERTY[@NAME='timeStamp']/VALUE">
		<xsl:copy-of select="." copy-namespaces="no"/>
		</xsl:if>
	</xsl:for-each>
</data>
</xsl:result-document>
</xsl:template>
</xsl:stylesheet>