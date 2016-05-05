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
    
    <!-- Pool Subscribed Capacity -->
    <!-- Sum of all array thin pool subscribed.  SubscribedCapacity is computed using an ICF -->
    <aggregation id="VMAX-Collector-PoolSubscribedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; pooltype=='Thin Pool' &amp; name=='SubscribedCapacity')
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">PoolSubscribedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
            
            <remove name="parttype" />
            <remove name="part" />
            <remove name="partstat"/>
            <remove name="dgstype"/>
            <remove name="poolemul"/>
            <remove name="raidtype"/>
        </properties>
    </aggregation>
    
    <!-- Pool Oversubscribed Capacity -->
    <!-- Sum of all array thin pool oversubscribed.  OversubscribedCapacity is computed using an ICF -->
    <aggregation id="VMAX-Collector-PoolOversubscribedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; pooltype=='Thin Pool' &amp; name=='OversubscribedCapacity')
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">PoolOversubscribedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
            
            <remove name="parttype" />
            <remove name="part" />
            <remove name="partstat"/>
            <remove name="dgstype"/>
            <remove name="poolemul"/>
            <remove name="raidtype"/>
        </properties>
    </aggregation>

</config>