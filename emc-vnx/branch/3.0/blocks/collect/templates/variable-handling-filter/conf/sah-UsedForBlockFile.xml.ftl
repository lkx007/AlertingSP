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
<config xmlns="http://www.watch4net.com/spatial-aggregation-handler"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.watch4net.com/spatial-aggregation-handler spatial-aggregation-handler.xsd">


    <!-- Array File Used Capacity -->
    <aggregation id="VNX-Collector-FileUsedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; name=='UsedCapacity' &amp;
                    ( (parttype=='LUN' &amp; usedby=='File' &amp; isused=='1') )
                | name=='RemoveMeZero')
        </filter>
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
[#if use_advancedsettings]
            <inventory period="${topology.pollingperiod}" removal-timeout="${topology.pollingperiod}" />
[#else]
            <inventory period="900" removal-timeout="900" />
[/#if]
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="source">VNXBlock-Collector</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="name">FileUsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>

            <remove name="parttype" />
            <remove name="part" />
            <remove name="partsn" />
            <remove name="luntagid" />
            <remove name="disktype" />
            <remove name="diskrpm" />
            <remove name="spindles" />
            <remove name="purpose" />
            <remove name="isbound" />
            <remove name="isused" />
            <remove name="ismapped" />
            <remove name="ismasked" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="ismetah" />
            <remove name="usedby" />
            <remove name="mainpool" />
            <remove name="poolname" />
            <remove name="svclevel" />
            <remove name="sgname" />
            <remove name="dgraid" />
            <remove name="dgstype" />
            <remove name="config" />
            <remove name="devconf" />
            <remove name="partconf" />
            <remove name="roc1" />
            <remove name="roc2" />
            <remove name="mvsgname" />
            <remove name="pdname" />
            <remove name="hypercnt" />
        </properties>
    </aggregation>

    <!-- Array Block Used Capacity -->
    <aggregation id="VNX-Collector-BlockUsedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; name=='UsedCapacity' &amp;
                    ( (parttype=='LUN' &amp; usedby=='Block' &amp; isused=='1')) 
                | name=='RemoveMeZero')
        </filter>
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>

        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
[#if use_advancedsettings]
            <inventory period="${topology.pollingperiod}" removal-timeout="${topology.pollingperiod}" />
[#else]
            <inventory period="900" removal-timeout="900" />
[/#if]
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="source">VNXBlock-Collector</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="name">BlockUsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>

            <remove name="parttype" />
            <remove name="part" />
            <remove name="partsn" />
            <remove name="luntagid" />
            <remove name="disktype" />
            <remove name="diskrpm" />
            <remove name="spindles" />
            <remove name="purpose" />
            <remove name="isbound" />
            <remove name="isused" />
            <remove name="ismapped" />
            <remove name="ismasked" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="ismetah" />
            <remove name="usedby" />
            <remove name="mainpool" />
            <remove name="poolname" />
            <remove name="svclevel" />
            <remove name="sgname" />
            <remove name="dgraid" />
            <remove name="dgstype" />
            <remove name="config" />
            <remove name="devconf" />
            <remove name="partconf" />
            <remove name="roc1" />
            <remove name="roc2" />
            <remove name="mvsgname" />
            <remove name="pdname" />
            <remove name="hypercnt" />
        </properties>
    </aggregation>

	<!-- Array Used Capacity -->
    <aggregation id="VNX-Collector-UsedCapacity" forward-input="true">
        <filter>((devtype=='Array' &amp; name=='UsedCapacity' &amp;
                    parttype=='LUN' &amp;  isused=='1')
                 | name=='RemoveMeZero')
        </filter>
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>

        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
[#if use_advancedsettings]
            <inventory period="${topology.pollingperiod}" removal-timeout="${topology.pollingperiod}" />
[#else]
            <inventory period="900" removal-timeout="900" />
[/#if]
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="source">VNXBlock-Collector</add>
            <add name="datagrp">VNX-SAF-ARRAY-USED</add>
            <add name="name">UsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>

            <remove name="parttype" />
            <remove name="part" />
            <remove name="partsn" />
            <remove name="luntagid" />
            <remove name="disktype" />
            <remove name="diskrpm" />
            <remove name="spindles" />
            <remove name="purpose" />
            <remove name="isbound" />
            <remove name="isused" />
            <remove name="ismapped" />
            <remove name="ismasked" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="ismetah" />
            <remove name="usedby" />
            <remove name="mainpool" />
            <remove name="poolname" />
            <remove name="svclevel" />
            <remove name="sgname" />
            <remove name="dgraid" />
            <remove name="dgstype" />
            <remove name="config" />
            <remove name="devconf" />
            <remove name="partconf" />
            <remove name="roc1" />
            <remove name="roc2" />
            <remove name="mvsgname" />
            <remove name="pdname" />
            <remove name="hypercnt" />
        </properties>
    </aggregation>
</config>