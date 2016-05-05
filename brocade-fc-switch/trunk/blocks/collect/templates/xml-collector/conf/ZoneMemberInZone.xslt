<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" name="xml"/>
	<xsl:template match="/">
		<xsl:for-each select="//VALUE.OBJECTWITHPATH/INSTANCE">
		<xsl:variable name="filePath" select="'tmp/ZoneMemberInZone/'"/>
		<xsl:variable name="filename" select="position()"/>
	        
		<xsl:variable name="zonesetinfabid" select="//MESSAGE/@ID"/>
		<xsl:variable name="fabricid" select="tokenize($zonesetinfabid, ',')[1]"/>	
	        <xsl:variable name="zonesetname" select="tokenize($zonesetinfabid, ',')[2]"/>			

		<xsl:variable name="zoneinstid" select="./PROPERTY[@NAME='InstanceID']/VALUE"/>
		<xsl:variable name="zonename" select="./PROPERTY[@NAME='ElementName']/VALUE"/>
		
		<xsl:variable name="zoneinsetinfabid" select="string-join(($zonesetinfabid, $zonename), ',')"/>

		<xsl:variable name="requestFilename" select="concat($filePath, $fabricid, '_', $zonesetname, '_', $zonename, '_', $filename, '.xml')"/>

		<xsl:if test="contains($zoneinstid, 'ACTIVE=true')">
		<xsl:result-document href="{$requestFilename}" format="xml">

	<CIM CIMVERSION="2.0" DTDVERSION="2.0">
       		 <MESSAGE ID="{$zoneinsetinfabid}" PROTOCOLVERSION="1.0">
                	<SIMPLEREQ>
                        <IMETHODCALL NAME="Associators">
                                <LOCALNAMESPACEPATH>
                                        <NAMESPACE NAME="root"/>
                                        <NAMESPACE NAME="brocade1"/>
                                </LOCALNAMESPACEPATH>
                                <IPARAMVALUE NAME="ObjectName">
					<INSTANCENAME CLASSNAME="Brocade_Zone">
						<KEYBINDING NAME="InstanceID"><KEYVALUE VALUETYPE="string"><xsl:value-of select="string($zoneinstid)" disable-output-escaping="yes"/></KEYVALUE></KEYBINDING>
					</INSTANCENAME>
				</IPARAMVALUE>
                                <IPARAMVALUE NAME="AssocClass">
                                        <CLASSNAME NAME="Brocade_ZoneMembershipSettingDataInZone" />
                                </IPARAMVALUE>
                                <IPARAMVALUE NAME="ResultClass">
                                        <CLASSNAME NAME="Brocade_ZoneMembershipSettingData" />
                                </IPARAMVALUE>
                        </IMETHODCALL>
                        </SIMPLEREQ>
                </MESSAGE>
        </CIM>
	</xsl:result-document>
	</xsl:if>
        </xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
