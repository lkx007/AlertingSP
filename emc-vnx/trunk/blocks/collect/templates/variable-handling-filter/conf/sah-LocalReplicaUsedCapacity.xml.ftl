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
<config xmlns="http://www.watch4net.com/spatial-aggregation-handler" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/spatial-aggregation-handler spatial-aggregation-handler.xsd">
	<aggregation id="VNX-LOCAL-REPLICA-USED-CAPACITY" forward-input="true">
		<filter>(name=='UsedCapacity' &amp; purpose=='Local Replica' &amp; isused=='1') | name=='RemoveMeZero'</filter>
		<group-by>source</group-by>
		<group-by>devtype</group-by>
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
			<inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
		</compute>
		<properties>
			<add name="w4ncert">1.0</add>
			<add name="datatype">Block</add>
			<add name="datagrp">VNX-SAF</add>
			<add name="name">LocalReplicaUsedCapacity</add>
			<add name="unit">GB</add>
			<remove name="part" />
			<remove name="parttype" />
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
			<remove name="spindles" />
			<remove name="partdesc" />
			<remove name="svclevel" />
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
			<remove name="mhid" />
			<remove name="mhname" />
		</properties>
	</aggregation>
</config>