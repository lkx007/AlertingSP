<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" name="xml"/>
	<xsl:template match="/">
		<xsl:for-each select="//VALUE.OBJECTWITHPATH/INSTANCE">
		<xsl:variable name="filePath" select="'tmp/Brocade_VirtualFabric/VirtualFabricForLogicalSwitch_Req_Folder/'"/>
		<xsl:variable name="filename" select="position()"/>
		<xsl:variable name="msgid" select="//MESSAGE/@ID"/>
		<xsl:variable name="deviceid" select="tokenize($msgid, ',')[1]"/>
		<xsl:variable name="device" select="tokenize($msgid, ',')[2]"/>		
		<xsl:variable name="logicaldeviceid" select="./PROPERTY[@NAME='Name']/VALUE"/>		
		<xsl:variable name="logicaldevicename" select="./PROPERTY[@NAME='ElementName']/VALUE"/>	
		<xsl:variable name="logicaldevicetype" select="./PROPERTY.ARRAY[@NAME='OtherIdentifyingInfo']/VALUE.ARRAY/VALUE[2]"/>	
		<xsl:variable name="logicalandphysicalswitchattributes" select="string-join(($deviceid, $device, $logicaldeviceid, $logicaldevicename, $logicaldevicetype), ',')"/>
		<xsl:variable name="requestFilename" select="concat($filePath, $deviceid, '_', $logicaldeviceid, '.xml')"/>	
		<xsl:result-document href="{$requestFilename}" format="xml">

		<CIM CIMVERSION="2.0" DTDVERSION="2.0">
       		<MESSAGE ID="{$logicalandphysicalswitchattributes}" PROTOCOLVERSION="1.0">
                <SIMPLEREQ>
                    <IMETHODCALL NAME="Associators">
                        <LOCALNAMESPACEPATH>
								<NAMESPACE NAME="root"/>
                                <NAMESPACE NAME="brocade1"/>
                        </LOCALNAMESPACEPATH>
                        <IPARAMVALUE NAME="ObjectName">
							<INSTANCENAME CLASSNAME="Brocade_Switch">
								<KEYBINDING NAME="CreationClassName">
									<KEYVALUE VALUETYPE="string">Brocade_Switch</KEYVALUE>
								</KEYBINDING>
								<KEYBINDING NAME="Name">
									<KEYVALUE VALUETYPE="string"><xsl:value-of select="string($logicaldeviceid)" disable-output-escaping="yes"/></KEYVALUE>
								</KEYBINDING>								
							</INSTANCENAME>
						</IPARAMVALUE>
                        <IPARAMVALUE NAME="AssocClass">
                            <CLASSNAME NAME="Brocade_SwitchInFabric" />
                        </IPARAMVALUE>
                        <IPARAMVALUE NAME="ResultClass">
                            <CLASSNAME NAME="Brocade_Fabric" />
                        </IPARAMVALUE>
						<IPARAMVALUE NAME="PropertyList">
							<VALUE.ARRAY>
								<VALUE>Name</VALUE>
								<VALUE>ElementName</VALUE>
								<VALUE>EnabledState</VALUE>
								<VALUE>OtherIdentifyingInfo</VALUE>
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
