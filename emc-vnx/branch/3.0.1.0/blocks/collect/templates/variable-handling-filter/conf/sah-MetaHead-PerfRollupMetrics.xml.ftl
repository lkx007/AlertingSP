<#if use_advancedsettings>
    <#assign pollingperiod = perf.pollingperiod>
<#else>
    <#assign pollingperiod = 300>
</#if>
<?xml version="1.0" encoding="UTF-8"?>
<!--
* Copyright (c) 2014 EMC Corporation
* All Rights Reserved
*
* This software contains the intellectual property of EMC Corporation
* or is licensed to EMC Corporation from third parties.  Use of this
* software and the intellectual property contained therein is expressly
* limited to the terms and conditions of the License Agreement under which
* it is provided by or on behalf of EMC.
-->
<config xmlns="http://www.watch4net.com/spatial-aggregation-handler" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/spatial-aggregation-handler spatial-aggregation-handler.xsd">
    <aggregation id="VNX-META-ForcedFlushes" forward-input="true">
        <filter>(parttype=='MetaMember' &amp; name=='ForcedFlushes')</filter>
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>metahid</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="source">VNXBlock-Collector</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="devtype">Array</add>
            <add name="parttype">LUN</add>
            <add name="part">LOGICAL UNIT NUMBER </add>
            <add name="name">ForcedFlushes</add>
            <add name="unit">Nb/s</add>
            <add name="ismetah">1</add>
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgstype" />
            <remove name="dgtype" />
            <remove name="disksize" />
            <remove name="disktype" />
            <remove name="hasfc" />
            <remove name="hasinit" />
            <remove name="hexid" />
            <remove name="isfast" />
            <remove name="ismetam" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partdesc" />
            <remove name="partid" />
            <remove name="partsn" />
            <remove name="polname" />
            <remove name="poolname" />
            <remove name="pooltype" />
            <remove name="private" />
            <remove name="sgname" />
            <remove name="srclun" />
            <remove name="spindles" />
            <remove name="srcarray" />
            <remove name="tiername" />
        </properties>
    </aggregation>


    <aggregation id="VNX-META-PrefetchedBlocks" forward-input="true">
        <filter>(parttype=='MetaMember' &amp; name=='PrefetchedBlocks')</filter>
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>metahid</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="source">VNXBlock-Collector</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="devtype">Array</add>
            <add name="parttype">LUN</add>
            <add name="part">LOGICAL UNIT NUMBER </add>
            <add name="name">PrefetchedBlocks</add>
            <add name="unit">Nb/s</add>
            <add name="ismetah">1</add>
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgstype" />
            <remove name="dgtype" />
            <remove name="disksize" />
            <remove name="disktype" />
            <remove name="hasfc" />
            <remove name="hasinit" />
            <remove name="hexid" />
            <remove name="isfast" />
            <remove name="ismetam" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partdesc" />
            <remove name="partid" />
            <remove name="partsn" />
            <remove name="polname" />
            <remove name="poolname" />
            <remove name="pooltype" />
            <remove name="private" />
            <remove name="sgname" />
            <remove name="srclun" />
            <remove name="spindles" />
            <remove name="srcarray" />
            <remove name="tiername" />
        </properties>
    </aggregation>


    <aggregation id="VNX-META-ReadCacheHits" forward-input="true">
        <filter>(parttype=='MetaMember' &amp; name=='ReadCacheHits')</filter>
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>metahid</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="source">VNXBlock-Collector</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="devtype">Array</add>
            <add name="parttype">LUN</add>
            <add name="part">LOGICAL UNIT NUMBER </add>
            <add name="name">ReadCacheHits</add>
            <add name="unit">Nb/s</add>
            <add name="ismetah">1</add>
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgstype" />
            <remove name="dgtype" />
            <remove name="disksize" />
            <remove name="disktype" />
            <remove name="hasfc" />
            <remove name="hasinit" />
            <remove name="hexid" />
            <remove name="isfast" />
            <remove name="ismetam" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partdesc" />
            <remove name="partid" />
            <remove name="partsn" />
            <remove name="polname" />
            <remove name="poolname" />
            <remove name="pooltype" />
            <remove name="private" />
            <remove name="sgname" />
            <remove name="srclun" />
            <remove name="spindles" />
            <remove name="srcarray" />
            <remove name="tiername" />
        </properties>
    </aggregation>


    <aggregation id="VNX-META-ReadCacheMisses" forward-input="true">
        <filter>(parttype=='MetaMember' &amp; name=='ReadCacheMisses')</filter>
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>metahid</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="source">VNXBlock-Collector</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="devtype">Array</add>
            <add name="parttype">LUN</add>
            <add name="part">LOGICAL UNIT NUMBER </add>
            <add name="name">ReadCacheMisses</add>
            <add name="unit">Nb/s</add>
            <add name="ismetah">1</add>
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgstype" />
            <remove name="dgtype" />
            <remove name="disksize" />
            <remove name="disktype" />
            <remove name="hasfc" />
            <remove name="hasinit" />
            <remove name="hexid" />
            <remove name="isfast" />
            <remove name="ismetam" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partdesc" />
            <remove name="partid" />
            <remove name="partsn" />
            <remove name="polname" />
            <remove name="poolname" />
            <remove name="pooltype" />
            <remove name="private" />
            <remove name="sgname" />
            <remove name="srclun" />
            <remove name="spindles" />
            <remove name="srcarray" />
            <remove name="tiername" />
        </properties>
    </aggregation>


    <aggregation id="VNX-META-UnusedPrefetchedBlocks" forward-input="true">
        <filter>(parttype=='MetaMember' &amp; name=='UnusedPrefetchedBlocks')</filter>
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>metahid</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="source">VNXBlock-Collector</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="devtype">Array</add>
            <add name="parttype">LUN</add>
            <add name="part">LOGICAL UNIT NUMBER </add>
            <add name="name">UnusedPrefetchedBlocks</add>
            <add name="unit">Nb/s</add>
            <add name="ismetah">1</add>
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgstype" />
            <remove name="dgtype" />
            <remove name="disksize" />
            <remove name="disktype" />
            <remove name="hasfc" />
            <remove name="hasinit" />
            <remove name="hexid" />
            <remove name="isfast" />
            <remove name="ismetam" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partdesc" />
            <remove name="partid" />
            <remove name="partsn" />
            <remove name="polname" />
            <remove name="poolname" />
            <remove name="pooltype" />
            <remove name="private" />
            <remove name="sgname" />
            <remove name="srclun" />
            <remove name="spindles" />
            <remove name="srcarray" />
            <remove name="tiername" />
        </properties>
    </aggregation>


    <aggregation id="VNX-META-WriteCacheHits" forward-input="true">
        <filter>(parttype=='MetaMember' &amp; name=='WriteCacheHits')</filter>
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>metahid</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="source">VNXBlock-Collector</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="devtype">Array</add>
            <add name="parttype">LUN</add>
            <add name="part">LOGICAL UNIT NUMBER </add>
            <add name="name">WriteCacheHits</add>
            <add name="unit">Nb/s</add>
            <add name="ismetah">1</add>
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgstype" />
            <remove name="dgtype" />
            <remove name="disksize" />
            <remove name="disktype" />
            <remove name="hasfc" />
            <remove name="hasinit" />
            <remove name="hexid" />
            <remove name="isfast" />
            <remove name="ismetam" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partdesc" />
            <remove name="partid" />
            <remove name="partsn" />
            <remove name="polname" />
            <remove name="poolname" />
            <remove name="pooltype" />
            <remove name="private" />
            <remove name="sgname" />
            <remove name="srclun" />
            <remove name="spindles" />
            <remove name="srcarray" />
            <remove name="tiername" />
        </properties>
    </aggregation>

</config>
