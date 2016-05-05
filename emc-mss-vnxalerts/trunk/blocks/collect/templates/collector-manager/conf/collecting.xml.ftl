[#ftl]
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
<config xmlns="http://www.watch4net.com/APG/Collecting" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.watch4net.com/APG/Collecting collecting.xsd ">
	<connectors>
		<connector enabled="true" name="Backend" type="Socket-Connector" config="conf/socketconnector.xml" />
[#if use_alert]
		<connector enabled="true" name="Alerting" type="Socket-Connector" config="conf/alertingconnector.xml" />
[#else]
		<connector enabled="false" name="Alerting" type="Socket-Connector" config="conf/alertingconnector.xml" />
[/#if]
		<connector enabled="false" name="Null" type="Null-Connector" config="conf/" />
	</connectors>
	<filters>
[#if storage.failover]
		<filter enabled="true" name="FailOver" next="Backend" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
[#else]
		<filter enabled="skip" name="FailOver" next="Backend" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
[/#if]

		<filter enabled="true" name="IgnoreErrors" next="Alerting" type="Ignore-Errors-Filter" config="Collector-Manager/${module['collector-manager'].instance}/" />
		<filter enabled="skip" name="DataEnrichment" next="FailOver IgnoreErrors" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter.xml" />
		<filter enabled="true" name="VNX-VHF5" next="DataEnrichment" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-set-SL-part.xml" />
		<filter enabled="true" name="VNX-CRFSERIALNB" next="VNX-VHF5" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/cross-referencing-filter-vnxblock-serialnb.xml" />

	</filters>
	<collectors>
[#assign blockenabled="false" /]
[#assign fileenabled="false" /]
[#assign unityenabled="false" /]
[#if vnx??]
	[#list vnx as vnx]
		[#if vnx.type == 'block' || vnx.type == 'unified']
			[#assign blockenabled="true" /]
		[/#if]
		[#if vnx.type == 'file' || vnx.type == 'unified']
			[#assign fileenabled="true" /]
		[/#if]
		[#if vnx.type == 'unity']
			[#assign unityenabled="true" /]
		[/#if]
	[/#list]
[/#if]
	<!-- Block -->
	<collector enabled="${blockenabled}" name="VNXBlock-MSOTS" next="VNX-CRFSERIALNB" config="Text-Collector/${module['text-collector'].instance}/conf/textoutputcollector-vnxblock-topology-msots.xml" />
	<!-- File -->
	<collector enabled="${fileenabled}" name="SSH-API-MSOTS" next="DataEnrichment" config="Text-Collector/${module['text-collector'].instance}/conf/textcollector-process-vnxfile-data-msots.xml" />
	</collectors>
</config>