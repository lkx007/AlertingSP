[#ftl]
<?xml version="1.0" encoding="utf-8" ?>
<CIM CIMVERSION="2.0" DTDVERSION="2.0">
    <MESSAGE ID="1009" PROTOCOLVERSION="1.0">
        <SIMPLEREQ>
            <METHODCALL NAME="GetStatisticsCollection">
                <LOCALINSTANCEPATH>
                    <LOCALNAMESPACEPATH>
                        <NAMESPACE NAME="root" />
                        <NAMESPACE NAME="emc" />
                    </LOCALNAMESPACEPATH>
                    <INSTANCENAME CLASSNAME="Symm_BlockStatisticsService">
                        <KEYBINDING NAME="CreationClassName">
                            <KEYVALUE VALUETYPE="string">Symm_BlockStatisticsService</KEYVALUE>
                        </KEYBINDING>
                        <KEYBINDING NAME="Name">
                            <KEYVALUE VALUETYPE="string">EMCBlockStatisticsService</KEYVALUE>
                        </KEYBINDING>
                        <KEYBINDING NAME="SystemCreationClassName">
                            <KEYVALUE VALUETYPE="string">Symm_StorageSystem</KEYVALUE>
                        </KEYBINDING>
                        <KEYBINDING NAME="SystemName">
[#if serialnb??]
                            <KEYVALUE VALUETYPE="string">SYMMETRIX+${serialnb?left_pad(12, "0")}</KEYVALUE>
[/#if]
                        </KEYBINDING>
                    </INSTANCENAME>
                </LOCALINSTANCEPATH>
                <PARAMVALUE NAME="StatisticsFormat" PARAMTYPE="uint16">
                    <VALUE>2</VALUE>
                </PARAMVALUE>
                <PARAMVALUE NAME="ElementTypes" PARAMTYPE="uint16">
                    <VALUE.ARRAY>
                        <VALUE>8</VALUE>
                    </VALUE.ARRAY>
                </PARAMVALUE>
            </METHODCALL>
        </SIMPLEREQ>
    </MESSAGE>
</CIM>

