<#if use_advancedsettings>
    <#assign pollingperiod = topology.pollingperiod>
<#else>
    <#assign pollingperiod = 900>
</#if>
<?xml version="1.0" encoding="UTF-8"?>
<!--
* Copyright (c) 2013-2014 EMC Corporation
* All Rights Reserved
*
* This software contains the intellectual property of EMC Corporation
* or is licensed to EMC Corporation from third parties.  Use of this
* software and the intellectual property contained therein is expressly
* limited to the terms and conditions of the License Agreement under which
* it is provided by or on behalf of EMC.
-->
<config xmlns="http://www.watch4net.com/spatial-aggregation-handler" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.watch4net.com/spatial-aggregation-handler spatial-aggregation-handler.xsd">

    <!-- Compute Service Level Usable for all cases except when Pool Contributor --> 
    <aggregation id="VNX-ServiceLevel-UsableCapacity" forward-input="true">
        <filter>(parttype=='LUN' &amp; name=='UsedCapacity' &amp; svclevel &amp; !svclevel=='Pool Contributor') | name=='RemoveMeZeroLun'</filter>

        <!--Indicate the properties to propagate up from the aggregated metrics-->
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>source</group-by>
        <group-by>devtype</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>svclevel</group-by>

    <!-- spatial aggregation : avg, sum, min, max, count -->
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>

        <!--Set the properties for the new metric-->
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="parttype">Service Level</add>
            <add name="name">Capacity</add>
            <add name="unit">GB</add>
            <remove name="part" />
            <remove name="partsn" />
            <remove name="partdesc" />
            <remove name="disktype" />
            <remove name="disksize" />
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgtype" />
            <remove name="dgstype" />
            <remove name="ismapped" />
            <remove name="ismasked" />
            <remove name="isused" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partid" />
            <remove name="private" />
            <remove name="purpose" />
            <remove name="spindles" />
            <remove name="usedcap" />
            <remove name="tiername" />
            <remove name="hasinit" />
            <remove name="sgname" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="pooltype" />
            <remove name="poolname" />
            <remove name="ismetam" />
            <remove name="ismetah" />
            <remove name="metahead" />
            <remove name="metahid" />
        </properties>
    </aggregation>



    <!-- Compute Service Level Usable when svclevel = Pool Contributor --> 
    <aggregation id="VNX-ServiceLevel-UsableCapacity-PoolContributor" forward-input="true">
        <filter>(parttype=='LUN' &amp; name=='Capacity' &amp; svclevel=='Pool Contributor') | name=='RemoveMeZeroLun'</filter>

        <!--Indicate the properties to propagate up from the aggregated metrics-->
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>source</group-by>
        <group-by>devtype</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>svclevel</group-by>

    <!-- spatial aggregation : avg, sum, min, max, count -->
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>

        <!--Set the properties for the new metric-->
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="parttype">Service Level</add>
            <add name="name">Capacity</add>
            <add name="unit">GB</add>
            <remove name="part" />
            <remove name="partsn" />
            <remove name="partdesc" />
            <remove name="disktype" />
            <remove name="disksize" />
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgtype" />
            <remove name="dgstype" />
            <remove name="ismapped" />
            <remove name="ismasked" />
            <remove name="isused" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partid" />
            <remove name="private" />
            <remove name="purpose" />
            <remove name="spindles" />
            <remove name="usedcap" />
            <remove name="tiername" />
            <remove name="hasinit" />
            <remove name="sgname" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="pooltype" />
            <remove name="poolname" />
            <remove name="ismetam" />
            <remove name="ismetah" />
            <remove name="metahead" />
            <remove name="metahid" />
        </properties>
    </aggregation>



    <!-- Compute Service Level Used for all cases except when Pool Contributor--> 
    <aggregation id="VNX-ServiceLevel-UsedCapacity" forward-input="true">
        <filter>(parttype=='LUN' &amp; name=='UsedCapacity' &amp; isused=='1' &amp; !svclevel=='Pool Contributor') | name=='RemoveMeZeroLun'</filter>

        <!--Indicate the properties to propagate up from the aggregated metrics-->
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>source</group-by>
        <group-by>devtype</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>svclevel</group-by>

    <!-- spatial aggregation : avg, sum, min, max, count -->
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>

        <!--Set the properties for the new metric-->
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="parttype">Service Level</add>
            <add name="name">UsedCapacity</add>
            <add name="unit">GB</add>
            <remove name="part" />
            <remove name="partsn" />
            <remove name="partdesc" />
            <remove name="disktype" />
            <remove name="disksize" />
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgtype" />
            <remove name="dgstype" />
            <remove name="ismapped" />
            <remove name="ismasked" />
            <remove name="isused" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partid" />
            <remove name="private" />
            <remove name="purpose" />
            <remove name="spindles" />
            <remove name="usedcap" />
            <remove name="tiername" />
            <remove name="hasinit" />
            <remove name="sgname" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="pooltype" />
            <remove name="poolname" />
            <remove name="ismetam" />
            <remove name="ismetah" />
            <remove name="metahead" />
            <remove name="metahid" />
        </properties>
    </aggregation>



    <!-- Compute Service Level Used when svclevel = Pool Contributor--> 
    <aggregation id="VNX-ServiceLevel-UsedCapacity" forward-input="true">
        <filter>(parttype=='LUN' &amp; name=='UsedCapacity' &amp; svclevel=='Pool Contributor') | name=='RemoveMeZeroLun'</filter>

        <!--Indicate the properties to propagate up from the aggregated metrics-->
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>source</group-by>
        <group-by>devtype</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>svclevel</group-by>

    <!-- spatial aggregation : avg, sum, min, max, count -->
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>

        <!--Set the properties for the new metric-->
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="parttype">Service Level</add>
            <add name="name">UsedCapacity</add>
            <add name="unit">GB</add>
            <remove name="part" />
            <remove name="partsn" />
            <remove name="partdesc" />
            <remove name="disktype" />
            <remove name="disksize" />
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgtype" />
            <remove name="dgstype" />
            <remove name="ismapped" />
            <remove name="ismasked" />
            <remove name="isused" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partid" />
            <remove name="private" />
            <remove name="purpose" />
            <remove name="spindles" />
            <remove name="usedcap" />
            <remove name="tiername" />
            <remove name="hasinit" />
            <remove name="sgname" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="pooltype" />
            <remove name="poolname" />
            <remove name="ismetam" />
            <remove name="ismetah" />
            <remove name="metahead" />
            <remove name="metahid" />
        </properties>
    </aggregation>



    <!-- Compute Service Level Free for all cases except when Pool Contributor --> 
    <aggregation id="VNX-ServiceLevel-FreeCapacity" forward-input="true">
        <filter>(parttype=='LUN' &amp; name=='UsedCapacity' &amp; svclevel &amp; isused=='0' &amp; !svclevel=='Pool Contributor') | name=='RemoveMeZeroLun'</filter>

        <!--Indicate the properties to propagate up from the aggregated metrics-->
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>source</group-by>
        <group-by>devtype</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>svclevel</group-by>

    <!-- spatial aggregation : avg, sum, min, max, count -->
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>

        <!--Set the properties for the new metric-->
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="parttype">Service Level</add>
            <add name="name">FreeCapacity</add>
            <add name="unit">GB</add>
            <remove name="part" />
            <remove name="partsn" />
            <remove name="partdesc" />
            <remove name="disktype" />
            <remove name="disksize" />
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgtype" />
            <remove name="dgstype" />
            <remove name="ismapped" />
            <remove name="ismasked" />
            <remove name="isused" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partid" />
            <remove name="private" />
            <remove name="purpose" />
            <remove name="spindles" />
            <remove name="usedcap" />
            <remove name="tiername" />
            <remove name="hasinit" />
            <remove name="sgname" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="pooltype" />
            <remove name="poolname" />
            <remove name="ismetam" />
            <remove name="ismetah" />
            <remove name="metahead" />
            <remove name="metahid" />
        </properties>
    </aggregation>



    <!-- Compute Service Level Free when svclevel = Pool Contributor --> 
    <aggregation id="VNX-ServiceLevel-FreeCapacity" forward-input="true">
        <filter>(parttype=='LUN' &amp; name=='UsedCapacity' &amp; svclevel=='Pool Contributor') | name=='RemoveMeZeroLun'</filter>

        <!--Indicate the properties to propagate up from the aggregated metrics-->
        <group-by>serialnb</group-by>
        <group-by>sstype</group-by>
        <group-by>device</group-by>
        <group-by>source</group-by>
        <group-by>devtype</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>svclevel</group-by>

    <!-- spatial aggregation : avg, sum, min, max, count -->
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>

        <!--Set the properties for the new metric-->
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="datagrp">VNX-SAF</add>
            <add name="parttype">Service Level</add>
            <add name="name">FreeCapacity</add>
            <add name="unit">GB</add>
            <remove name="part" />
            <remove name="partsn" />
            <remove name="partdesc" />
            <remove name="disktype" />
            <remove name="disksize" />
            <remove name="dgname" />
            <remove name="dgraid" />
            <remove name="dgroup" />
            <remove name="dgtype" />
            <remove name="dgstype" />
            <remove name="ismapped" />
            <remove name="ismasked" />
            <remove name="isused" />
            <remove name="memberof" />
            <remove name="module" />
            <remove name="partid" />
            <remove name="private" />
            <remove name="purpose" />
            <remove name="spindles" />
            <remove name="usedcap" />
            <remove name="tiername" />
            <remove name="hasinit" />
            <remove name="sgname" />
            <remove name="ispolctr" />
            <remove name="ispolcsu" />
            <remove name="pooltype" />
            <remove name="poolname" />
            <remove name="ismetam" />
            <remove name="ismetah" />
            <remove name="metahead" />
            <remove name="metahid" />
        </properties>
    </aggregation>

</config>