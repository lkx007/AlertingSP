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
<property-tagging-filter-config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.watch4net.com/APG/Filter/PropertyTaggingFilter" xsi:schemaLocation="http://www.watch4net.com/APG/Filter/PropertyTaggingFilter  property-tagging-filter-config.xsd">
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
                    SELECT distinct ?device ?parttype ?partid ?usedby
                    WHERE {
                        ?sv a srm:StorageVolume .
                        ?sv srm:displayName ?partid .
                        BIND ("LUN" as ?parttype)
                        ?sv srm:residesOnStorageArray /srm:displayName ?device .
                        OPTIONAL {
                            ?sv srm:lunTagId ?id .
                            ?nd srm:lunTagId ?id .
                            ?nd a srm:NASDisk .
                        }
                        LET (?usedby := IF( bound(?nd), "File", "Block"))
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
                <key-property delete-after-use="false" string-type="string">partid</key-property>
            </key-properties>
            <new-properties>
                <new-property>usedby</new-property>
            </new-properties>
        </text-file>
[/#if]

    <text-file encoding="UTF-8" path="conf/reset-isused.csv">
        <accessor accessor-class="StaticAccessor">
            <parameter name="line">LUN,File,1,1,1</parameter>
        </accessor>
        <field-separator>,</field-separator>
        <default-symbol>**</default-symbol>
        <null-symbol>@@</null-symbol>
        <key-properties>
            <key-property delete-after-use="false" string-type="string">parttype</key-property>
            <key-property delete-after-use="false" string-type="string">usedby</key-property>
        </key-properties>
        <new-properties>
            <new-property>isused</new-property>
            <new-property>ismapped</new-property>
            <new-property>ismasked</new-property>
        </new-properties>
    </text-file>

    <!-- 
        VNX thick lun disk info for luns from raid group - no need to check for thick as 
            it is automatic if dgtype is RAID Group
        VNX thick and thin lun disk info for luns from NON FAST pools (FAST managed pools will be updated later)
        This one uses property accessor, then move the data from pool contributors (Disks) to consumers (LUNs). 
        Please note I move from ispolctr to ispolcsu: -->
        <text-file path="conf/poolraidluns.csv">
            <accessor accessor-class="PropertyAccessor">
                <parameter name="url">http://${propertystore.host}:${propertystore.port}/APG-WS/wsapi/db</parameter>
                <parameter name="user">${propertystore.username}</parameter>
                <parameter name="password">${propertystore.password}</parameter>
                <parameter name="properties">device ispolctr dgroup dgtype disktype disksize</parameter>
                <parameter name="filter">devtype=='Array' &amp; parttype=='Disk' &amp; ispolctr=='1' &amp; dgroup &amp;
                    (dgtype='RAID Group' | (dgtype='Storage Pool' &amp; isfast=='0'))</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">device</key-property>
                <key-property delete-after-use="false" string-type="string">ispolcsu</key-property>
                <key-property delete-after-use="false" string-type="string">dgroup</key-property>
                <key-property delete-after-use="false" string-type="string">dgtype</key-property>
            </key-properties>
            <new-properties>
                <new-property>disktype</new-property>
                <new-property>disksize</new-property>
            </new-properties>
        </text-file>

    </files>
</property-tagging-filter-config>
