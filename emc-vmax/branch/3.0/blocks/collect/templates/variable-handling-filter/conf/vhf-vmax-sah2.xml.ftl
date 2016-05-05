<#if use_advancedsettings>
	<#assign pollingperiod = topology.pollingperiod>
<#else>
	<#assign pollingperiod = 1200>
</#if>
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
<config xmlns="http://www.watch4net.com/spatial-aggregation-handler" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.watch4net.com/spatial-aggregation-handler spatial-aggregation-handler.xsd">
    
    <!-- Must guarantee I get count or zero for StoragePoolIsFast1Count.  
         Can't put this in the same SAH file where count is defined. -->
    <aggregation id="VMAX-Collector-FastLunCount" forward-input="false">
        <filter>(datagrp=='VMAX-SAF' &amp; parttype=='Storage Pool' &amp; name=='FastLunCount') 
                    | (datagrp=='VMAX-POOLS-CAPACITY' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <group-by>part</group-by>
        <compute spatial="max">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">FastLunCount</add>
            <add name="devtype">Array</add>
            <add name="parttype">Storage Pool</add>
        </properties>
    </aggregation>

</config>