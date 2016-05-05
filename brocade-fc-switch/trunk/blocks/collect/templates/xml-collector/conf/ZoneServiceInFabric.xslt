<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" name="xml"/>
	<xsl:template match="/">
		<xsl:for-each select="//VALUE.NAMEDINSTANCE/INSTANCE">
		<xsl:variable name="filePath" select="'tmp/ZoneServiceInFabric/'"/>
		<xsl:variable name="filename" select="position()"/>
		<xsl:variable name="fabricid" select="./PROPERTY[@NAME='Name']/VALUE"/>
		<xsl:variable name="requestFilename" select="concat($filePath, $fabricid, '_', $filename, '.xml')"/>
		<xsl:result-document href="{$requestFilename}" format="xml">

<CIM CIMVERSION="2.0" DTDVERSION="2.0">
        <MESSAGE ID="{$fabricid}" PROTOCOLVERSION="1.0">
                <SIMPLEREQ>
                        <IMETHODCALL NAME="Associators">
                                <LOCALNAMESPACEPATH>
                                        <NAMESPACE NAME="root"/>
                                        <NAMESPACE NAME="brocade1"/>
                                </LOCALNAMESPACEPATH>
                                <IPARAMVALUE NAME="ObjectName">
					<INSTANCENAME CLASSNAME="Brocade_Fabric">
						<KEYBINDING NAME="CreationClassName">
							<KEYVALUE VALUETYPE="string">Brocade_Fabric</KEYVALUE>
						</KEYBINDING>
						<KEYBINDING NAME="Name">
							<KEYVALUE VALUETYPE="string"><xsl:value-of select="string($fabricid)" disable-output-escaping="yes"/></KEYVALUE>
						</KEYBINDING>
					</INSTANCENAME>
				</IPARAMVALUE>
                                <IPARAMVALUE NAME="AssocClass">
                                        <CLASSNAME NAME="Brocade_ZoneServiceInFabric" />
                                </IPARAMVALUE>
                                <IPARAMVALUE NAME="ResultClass">
                                        <CLASSNAME NAME="Brocade_ZoneService" />
                                </IPARAMVALUE>
                        </IMETHODCALL>
                        </SIMPLEREQ>
                </MESSAGE>
        </CIM>
	</xsl:result-document>
        </xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
