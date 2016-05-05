<#if use_advancedsettings>
	<#assign pollingperiod = topology.pollingperiod>
<#else>
	<#assign pollingperiod = 900>
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
    <aggregation id="VNX-SNAPSHOT-METRICS-CAPACITY" forward-input="true">
        <!--  Capacity of snapshot luns is the capacity of the primary lun of its src lun. 
        We rollup Capacity of src lun's primary lun.
        Also, snapshot luns have hardcoded dgraid and purpose so later this metric will have part updated via CRF based
        on dgraid, purpose and srclun property.-->
        <filter>(parttype=='LUN' &amp; srclun &amp; !srclun=='N/A' &amp; name=='Capacity')</filter>
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>parttype</group-by>
        <group-by>srclun</group-by>
        <group-by>pooltype</group-by>
        <group-by>poolname</group-by>
        <group-by>dgname</group-by>
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
            <add name="purpose">Local Replica</add>
            <add name="dgraid">Snapshot Unknown RAID level</add>
            <add name="name">Capacity</add>
            <add name="unit">GB</add>
            <remove name="part" />
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
            <remove name="private" />
            <remove name="sgname" />
            <remove name="spindles" />
            <remove name="srcarray" />
            <remove name="tiername" />
        </properties>
    </aggregation>
</config>
