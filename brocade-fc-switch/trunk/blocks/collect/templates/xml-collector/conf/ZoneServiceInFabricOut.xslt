<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" name="xml"/>
	<xsl:template match="/">
		<xsl:for-each select="//VALUE.OBJECTWITHPATH/INSTANCE">
		<xsl:variable name="filePath" select="'tmp/ZoneServiceInFabricOut/'"/>
		<xsl:variable name="filename" select="position()"/>
                <xsl:variable name="msgid" select="//MESSAGE/@ID"/>
		<xsl:variable name="fabricid" select="tokenize($msgid, ',')[1]"/>	
		<xsl:variable name="requestFilename" select="concat($filePath, $fabricid, '_', $filename, '.xml')"/>
	
		
		<xsl:result-document href="{$requestFilename}" format="xml">
        	       	<MESSAGE FABRIC="{$fabricid}">
				<xsl:copy-of select="." copy-namespaces="no"/>
			</MESSAGE>
		</xsl:result-document>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
