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
	<aggregation id="VNX-POOL-CAPACITY" forward-input="true">
		<filter> device &amp; serialnb &amp; sstype &amp; (parttype=='Storage Pool' &amp; name=='Capacity') | name=='RemoveMeZero' </filter>
		<group-by>source</group-by>
		<group-by>devtype</group-by>
		<group-by>device</group-by>
		<group-by>serialnb</group-by>
		<group-by>sstype</group-by>
		<compute spatial="sum">
			<output-timestamp use="first" rounding="ceiling" rounding-base="1" />
			<output-group>group</output-group>
			<inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
		</compute>
		<properties>
			<add name="w4ncert">1.0</add>
			<add name="datatype">File</add>
			<add name="datagrp">VNXFile-SAF</add>
			<add name="name">NASPoolCapacity</add>
			<add name="unit">GB</add>
			<remove name="parttype" />
		</properties>
	</aggregation>
	<aggregation id="VNX-POOLUSED-CAPACITY" forward-input="true">
		<filter> device &amp; serialnb &amp; sstype &amp; (parttype=='Storage Pool' &amp; name=='UsedCapacity') | name=='RemoveMeZero' </filter>
		<group-by>source</group-by>
		<group-by>devtype</group-by>
		<group-by>device</group-by>
		<group-by>serialnb</group-by>
		<group-by>sstype</group-by>
		<compute spatial="sum">
			<output-timestamp use="first" rounding="ceiling" rounding-base="1" />
			<output-group>group</output-group>
			<inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
		</compute>
		<properties>
			<add name="w4ncert">1.0</add>
			<add name="datatype">File</add>
			<add name="datagrp">VNXFile-SAF</add>
			<add name="name">NASPoolUsedCapacity</add>
			<add name="unit">GB</add>
			<remove name="parttype" />
		</properties>
	</aggregation>
</config>