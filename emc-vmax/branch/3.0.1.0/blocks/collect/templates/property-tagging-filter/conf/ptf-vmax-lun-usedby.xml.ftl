[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<!--
* Copyright (c) 2013 EMC Corporation
* All Rights Reserved
*
* This software contains the intellectual property of EMC Corporation
* or is licensed to EMC Corporation from third parties.  Use of this
* software and the intellectual property contained therein is expressly
* limited to the terms and conditions of the License Agreement under which
* it is provided by or on behalf of EMC.
-->
<property-tagging-filter-config xmlns="http://www.watch4net.com/APG/Filter/PropertyTaggingFilter"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.watch4net.com/APG/Filter/PropertyTaggingFilter  property-tagging-filter-config.xsd" >
    <refresh unit="minutes">60</refresh>
    <files>

[#if use_topo]
        <!-- Tag usedby (File/Block) based on Topology Service file to block linkage via luntagid -->
        <text-file path="conf/usedby.csv" encoding="UTF-8">
            <accessor accessor-class="com.watch4net.apg.v2.collector.plugins.propertytaggingfilter.accessor.SparqlAccessor">
                <parameter name="url">https://${topologyservice.host}:${topologyservice.gateway.port}/Backends/Topology-Service/Default/topology/repository/sparql</parameter>
                <parameter name="user">${topologyservice.gateway.username}</parameter>
                <parameter name="password">${topologyservice.gateway.password}</parameter>
                <parameter name="disableSSLValidation">true</parameter>
                <parameter name="query">
                    PREFIX srm: &lt;http://ontologies.emc.com/2013/08/srm#&gt;
                    SELECT distinct ?device ?parttype ?part ?usedby
                    WHERE {
                        ?sv a srm:StorageVolume .
                        ?sv srm:displayName ?part .
                        ?sv srm:residesOnStorageArray /srm:displayName ?device .
                        BIND ("LUN" as ?parttype)
                        OPTIONAL {
                            ?sv srm:volumeWWN ?wwn .
                            ?vsv srm:volumeWWN ?wwn .
                            ?vsv a srm:VPlexStorageVolume .
                        }
                        OPTIONAL {
                            ?sv srm:lunTagId ?id .
                            ?nd a srm:NASDisk .
                            ?nd srm:lunTagId ?id .
                        }
                        BIND( IF( bound(?vsv), "Virtual", (IF( bound(?nd), "File", "Block" )) ) as ?usedby )
                    }
                </parameter>
            </accessor>
            <field-separator>,</field-separator>
            <field-quoting>"</field-quoting>
            <default-symbol>**</default-symbol>
            <property-insertion start="[" end="]"/>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">device</key-property>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">part</key-property>
            </key-properties>
            <new-properties>
                <new-property>usedby</new-property>
            </new-properties>
        </text-file>
[/#if]

</files>
</property-tagging-filter-config>
