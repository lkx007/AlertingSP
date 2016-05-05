[#ftl]
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
<config xmlns="http://www.watch4net.com/spatial-aggregation-handler" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.watch4net.com/spatial-aggregation-handler spatial-aggregation-handler.xsd">
	<aggregation id="ReadRequestsbyArray" forward-input="true">
		<filter>(name=='ReadRequests' &amp; parttype=='LUN')</filter>
		<group-by>serialnb</group-by>
		<group-by>device</group-by>
		<compute spatial="sum">
			<output-timestamp use="first" rounding="ceiling" rounding-base="1" />
			<output-group>group</output-group>
[#if use_advancedsettings]
			<inventory period="${perf.pollingperiod}" removal-timeout="${perf.pollingperiod * 2}" />
[#else]
			<inventory period="300" removal-timeout="600" />
[/#if]
		</compute>
		<properties>
			<add name="source">VNXUnity-Collector</add>
			<add name="datagrp">UNITY-SAF</add>
			<add name="devtype">UnifiedArray</add>
			<add name="sstype">Unified</add>
			<add name="datatype">Block</add>
			<add name="arraytyp">VNXe</add>
			<add name="parttype">LUN</add>
			<add name="name">ReadRequests</add>
			<remove name="part" />
			<remove name="partid" />
		</properties>
	</aggregation>
	<aggregation id="WriteRequestsbyArray" forward-input="true">
		<filter>(name=='WriteRequests' &amp; parttype=='LUN')</filter>
		<group-by>serialnb</group-by>
		<group-by>device</group-by>
		<compute spatial="sum">
			<output-timestamp use="first" rounding="ceiling" rounding-base="1" />
			<output-group>group</output-group>
[#if use_advancedsettings]
			<inventory period="${perf.pollingperiod}" removal-timeout="${perf.pollingperiod * 2}" />
[#else]
			<inventory period="300" removal-timeout="600" />
[/#if]
		</compute>
		<properties>
			<add name="source">VNXUnity-Collector</add>
			<add name="datagrp">UNITY-SAF</add>
			<add name="devtype">UnifiedArray</add>
			<add name="sstype">Unified</add>
			<add name="datatype">Block</add>
			<add name="arraytyp">VNXe</add>
			<add name="parttype">LUN</add>
			<add name="name">WriteRequests</add>
			<remove name="part" />
			<remove name="partid" />
		</properties>
	</aggregation>
</config>