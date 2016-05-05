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


    <!-- Tag ALL Virtual used or FILE used LUNs with isused==1 -->
    <!-- This PTF will override the isused flag for LUNs where usedby=='Virtual|File' -->
    <text-file encoding="UTF-8" path="conf/reset-isused.csv">
        <accessor accessor-class="StaticAccessor">
            <parameter name="line">LUN,File,1,1,1</parameter>
            <parameter name="line">LUN,Virtual,1,1,1</parameter>
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
