<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" name="xml"/>
	<xsl:template match="/">
		<xsl:for-each select="//VALUE.NAMEDINSTANCE/INSTANCE">
		<xsl:variable name="filePath" select="'tmp/Brocade_VirtualFabric/LogicalSwitchInPhysicalSwitch_Req_Folder/'"/>
		<xsl:variable name="filename" select="position()"/>
		<xsl:variable name="deviceid" select="./PROPERTY[@NAME='Name']/VALUE"/>
		<xsl:variable name="device" select="./PROPERTY[@NAME='ElementName']/VALUE"/>
		<xsl:variable name="deviceattributes" select="string-join(($deviceid, $device ), ',')"/>
		<xsl:variable name="requestFilename" select="concat($filePath, $deviceid, '_', $filename, '.xml')"/>
		<xsl:result-document href="{$requestFilename}" format="xml">

<CIM CIMVERSION="2.0" DTDVERSION="2.0">
        <MESSAGE ID="{$deviceattributes}" PROTOCOLVERSION="1.0">
                <SIMPLEREQ>
                        <IMETHODCALL NAME="Associators">
                            <LOCALNAMESPACEPATH>
                                <NAMESPACE NAME="root"/>
                                <NAMESPACE NAME="brocade1"/>
                            </LOCALNAMESPACEPATH>
                            <IPARAMVALUE NAME="ObjectName">
								<INSTANCENAME CLASSNAME="Brocade_PhysicalComputerSystem">
									<KEYBINDING NAME="CreationClassName">
										<KEYVALUE VALUETYPE="string">Brocade_PhysicalComputerSystem</KEYVALUE>
									</KEYBINDING>
									<KEYBINDING NAME="Name">
										<KEYVALUE VALUETYPE="string"><xsl:value-of select="string($deviceid)" disable-output-escaping="yes"/></KEYVALUE>
									</KEYBINDING>
								</INSTANCENAME>
							</IPARAMVALUE>
                            <IPARAMVALUE NAME="AssocClass">
                                <CLASSNAME NAME="Brocade_SwitchInPCS" />
                            </IPARAMVALUE>
                            <IPARAMVALUE NAME="ResultClass">
                                <CLASSNAME NAME="Brocade_Switch" />
                            </IPARAMVALUE>
							<IPARAMVALUE NAME="PropertyList">
								<VALUE.ARRAY>
								<VALUE>Name</VALUE>
								<VALUE>ElementName</VALUE>
								<VALUE>OtherIdentifyingInfo</VALUE>
								<VALUE>EnabledState</VALUE>
								<VALUE>SwitchRole</VALUE>
								<VALUE>OperationalStatus</VALUE>
								</VALUE.ARRAY>
							</IPARAMVALUE>								
                        </IMETHODCALL>
                        </SIMPLEREQ>
                </MESSAGE>
        </CIM>
	</xsl:result-document>
        </xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
