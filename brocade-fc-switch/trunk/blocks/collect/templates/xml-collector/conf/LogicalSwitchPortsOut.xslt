<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" name="xml"/>
	<xsl:template match="/">
		<xsl:for-each select="//VALUE.OBJECTWITHPATH/INSTANCE">
		<xsl:variable name="filePath" select="'tmp/Brocade_FCSwitch_Port/LogicalSwitchPortsOut/'"/>
		<xsl:variable name="filename" select="position()"/>
		<xsl:variable name="msgid" select="//MESSAGE/@ID"/>
		<xsl:variable name="deviceid" select="tokenize($msgid, ',')[1]"/>
		<xsl:variable name="device" select="tokenize($msgid, ',')[2]"/>
		<xsl:variable name="logicaldeviceid" select="tokenize($msgid, ',')[3]"/>
		<xsl:variable name="logicaldevicename" select="tokenize($msgid, ',')[4]"/>	
		<xsl:variable name="logicaldevicetype" select="tokenize($msgid, ',')[5]"/>
		<xsl:variable name="requestFilename" select="concat($filePath, $deviceid, '_',  $logicaldeviceid, '_', $filename, '.xml')"/>
		<xsl:result-document href="{$requestFilename}" format="xml">
        	       	<MESSAGE DEVICEID="{$deviceid}" LOGICALDEVICEID="{$logicaldeviceid}" DEVICE="{$device}" LOGICALDEVICENAME="{$logicaldevicename}" LOGICALDEVICETYPE="{$logicaldevicetype}" >					
				<xsl:copy-of select="." copy-namespaces="no"/>
			</MESSAGE>
		</xsl:result-document>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
