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
        <!-- Tag Thin LUN with pool contributor's (DATADEV or SAVEDEV) disk type, disk size, diskrpm, and dgraid -->
        <text-file path="conf/thindiskraid.csv">
            <accessor accessor-class="PropertyAccessor">
                <parameter name="url">http://${propertystore.host}:${propertystore.port}/APG-WS/wsapi/db</parameter>
                <parameter name="user">${propertystore.username}</parameter>
                <parameter name="password">${propertystore.password}</parameter>
                <parameter name="properties">device parttype ispolctr poolname disktype disksize diskrpm dgraid</parameter>
                <parameter name="filter">devtype=='Array' &amp; parttype=='LUN' &amp; ispolctr=='1' &amp; ispcbnd=='1' &amp; (poolname &amp; !poolname=='N/A')</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
                
            <key-properties>
                <key-property delete-after-use="false" string-type="string">device</key-property>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">ispolcsu</key-property>
                <key-property delete-after-use="false" string-type="string">poolname</key-property>
            </key-properties>
            
            <new-properties>
                <new-property>disktype</new-property>
                <new-property>disksize</new-property>
                <new-property>diskrpm</new-property>
                <new-property>dgraid</new-property>
            </new-properties>
        </text-file>
    </files>
</property-tagging-filter-config>