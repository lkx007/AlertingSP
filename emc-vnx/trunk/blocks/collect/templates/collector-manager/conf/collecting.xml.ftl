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
		<connector enabled="true" name="AlertingEvents" type="Socket-Connector" config="conf/socketconnector-alerts.xml" />
[#if use_alert]
		<connector enabled="true" name="Alerting" type="Socket-Connector" config="conf/alertingconnector.xml" />
[#else]
		<connector enabled="false" name="Alerting" type="Socket-Connector" config="conf/alertingconnector.xml" />
[/#if]
[#if use_topo]
		<connector enabled="true" name="TOPO-Backend" type="Socket-Connector" config="conf/topoconnector.xml" />
[#else]
		<connector enabled="false" name="TOPO-Backend" type="Socket-Connector" config="conf/topoconnector.xml" />
[/#if]
		<connector enabled="true" name="CC-Storage-TS2Event" type="Socket-Connector" config="conf/storage-ts2event.xml" />
		<connector enabled="false" name="Null" type="Null-Connector" config="conf/" />
	</connectors>
	<filters>
[#if storage.failover]
		<filter enabled="true" name="FailOver" next="Backend" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
		<filter enabled="true" name="FailOverEvents" next="CC-Storage-TS2Event" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-event.xml" />
[#else]
		<filter enabled="skip" name="FailOver" next="Backend" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
		<filter enabled="skip" name="FailOverEvents" next="CC-Storage-TS2Event" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-event.xml" />
[/#if]
		<filter enabled="true" name="IgnoreErrors" next="Alerting" type="Ignore-Errors-Filter" config="Collector-Manager/${module['collector-manager'].instance}/" />

[#if use_topo]
		<filter enabled="true" name="VNX-TOPO2" next="TOPO-Backend" config="Cross-Referencing-Filter/${module['variable-handling-filter'].instance}/conf/cross-referencing-filter-vnxblock-topo.xml" />
		<filter enabled="true" name="TOPO-Filter" next="VNX-TOPO2" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/variable-handling-filter-topo.xml" />
[#else]
		<filter enabled="false" name="VNX-TOPO2" next="TOPO-Backend" config="Cross-Referencing-Filter/${module['variable-handling-filter'].instance}/conf/cross-referencing-filter-vnxblock-topo.xml" />
		<filter enabled="false" name="TOPO-Filter" next="VNX-TOPO2" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/variable-handling-filter-topo.xml" />
[/#if]

		<filter enabled="true" name="DataEnrichment" next="FailOver IgnoreErrors TOPO-Filter" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter.xml" />

		<filter enabled="true" name="VNX-VHF-ALERTS" next="AlertingEvents" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vnx-vhf-alerts.xml" />
		<filter enabled="true" name="VNX-CRF-ALERTS" next="VNX-VHF-ALERTS" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/cross-referencing-filter-vnxblock-serialnb.xml" />

		[#-- New Filters Added by VNX Night Fury team --]
		<filter enabled="true" name="VNX-PTF" next="DataEnrichment" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter-vnxblock.xml" />
		<filter enabled="true" name="VNX-ICF3" next="VNX-PTF" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/icf-block-rollups.xml" />
		<!-- vhf-set-SL-part sets 'part' to be equivalent to 'svclevel' for parttype Service Level; also drops RemoveMeZero metric -->
		<filter enabled="true" name="VNX-VHF5" next="VNX-ICF3" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-set-SL-part.xml" />
		<!-- vhf-rollup-metrics includes sah for aggregating array level block capacity metrics -->
		<filter enabled="true" name="VNX-VHF4" next="VNX-VHF5" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-rollup-metrics.xml" />
		<!-- crf and ptf for managing service levels and propagating svclevel property to all LUN metrics-->
		<filter enabled="true" name="VNX-CRF-SVCLEVELS" next="VNX-VHF4" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/cross-referencing-filter-vnx-svclevel.xml" />
		<filter enabled="true" name="ManageServiceLevels-VNX" next="VNX-CRF-SVCLEVELS" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/ptf-CustomizeServiceLevels.xml" />
		<!-- vhf3 includes sah for aggregating array level block capacity metrics -->
		<filter enabled="true" name="VNX-VHF3" next="ManageServiceLevels-VNX" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf3.xml" />
		<filter enabled="true" name="VNX-CRF3" next="VNX-VHF3" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/crf-vnxblock-sp.xml" />
		<filter enabled="true" name="VNX-ICF2" next="VNX-CRF3" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/inline-calculation-filter-vnxblock-srm.xml" />
		<!-- variable-handling-filter-srm includes various sah and pah for aggregating array level block capacity metrics, converting units, and setting ismasked, ismapped and isused properties. -->
		<filter enabled="true" name="VNX-VHF2" next="VNX-ICF2" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/variable-handling-filter-srm.xml" />

		<!-- group filter to set diskinfo for meta head LUNs from meta members -->
		<filter enabled="true" name="VNX-GPF2" next="VNX-VHF2" config="Group-Filter/${module['group-filter'].instance}/conf/group-filter-vnxblock-meta.xml" />

		<!-- group filter to set diskinfo for LUNs from fast managed pool via tier disks property -->
		<filter enabled="true" name="VNX-GPF1" next="VNX-GPF2" config="Group-Filter/${module['group-filter'].instance}/conf/group-filter-vnxblock-thick-FAST.xml" />

		<filter enabled="true" name="VNX-PTFL" next="VNX-GPF1" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter-isused.xml" />

		<filter enabled="true" name="VNX-CRFL" next="VNX-PTFL" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/cross-referencing-filter-vnxblock-srm-luntagid.xml" />
		<filter enabled="true" name="VNX-PTF2" next="VNX-CRFL" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter-srm.xml" />
		<filter enabled="true" name="VNX-CRF2" next="VNX-PTF2" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/cross-referencing-filter-vnxblock-srm.xml" />
		<filter enabled="true" name="VNX-BAH" next="VNX-CRF2" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/variable-handling-filter-blocker.xml" />
		
		<!-- group filter to set sgname and hasinit for LUNs -->
		<filter enabled="true" name="VNX-GPF0" next="VNX-BAH" config="Group-Filter/${module['group-filter'].instance}/conf/group-filter-vnxblock-sgname.xml" />
		
		<filter enabled="true" name="VNX-CRF" next="VNX-GPF0" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/cross-referencing-filter-vnxblock.xml" />
		<filter enabled="true" name="VNX-ICF" next="VNX-CRF" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/inline-calculation-filter-vnxblock.xml" />
		<filter enabled="true" name="VNX-PCF" next="VNX-ICF" config="Property-Concat-Filter/${module['property-concat-filter'].instance}/conf/property-concat-filter-vnxblock.xml" />
		<filter enabled="true" name="VNX-VHF" next="VNX-PCF" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/variable-handling-filter-vnxblock.xml" />
		<filter enabled="true" name="VNX-CRFSERIALNB" next="VNX-VHF VNX-CRF-ALERTS" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/cross-referencing-filter-vnxblock-serialnb.xml" />

[#-- VNX File --]
		<filter enabled="true" name="vnxfile-icf2" next="VNX-ICF3" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/inline-calculation-filter-vnxfile2.xml" />
		<filter enabled="true" name="vnxfile-icf1" next="vnxfile-icf2" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/inline-calculation-filter-vnxfile1.xml" />
		<filter enabled="true" name="vnxfile5" next="vnxfile-icf1" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vnxfile5.xml" />
		<filter enabled="true" name="vnxfile-icf" next="vnxfile5" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/inline-calculation-filter-vnxfile.xml" />
		<filter enabled="true" name="vnxfile-icf0" next="vnxfile-icf" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/inline-calculation-filter-vnxfile0.xml" />
		<filter enabled="true" name="vnxfile-icf00" next="vnxfile-icf0" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/inline-calculation-filter-vnxfile00.xml" />
		<filter enabled="true" name="vnxfile4" next="FailOverEvents" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vnxfile4.xml" />
		<filter enabled="true" name="vnxfile-crf" next="vnxfile4 vnxfile-icf00" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/vnxfile3.xml" />
		<filter enabled="true" name="vnxfile3" next="vnxfile-crf" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/vnxfile2.xml" />
		<filter enabled="true" name="vnxfile1" next="vnxfile3 VNX-CRF-ALERTS" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/vnxfile1.xml" />
		<filter enabled="true" name="vnxblock-ptf" next="VNX-CRF-ALERTS" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter-vnxblockalerts.xml" />
		<!-- Unity -->
		<filter enabled="true" name="VNXe2-PTF1" next="VNX-CRFSERIALNB" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter-vnxunity.xml" />
		<filter enabled="true" name="VNXe2-ICF1" next="VNXe2-PTF1" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/inline-calculation-filter-vnxe2.xml" />
		<filter enabled="true" name="VNXe2-VHF2" next="VNXe2-ICF1" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-vnxe2.xml" />
		<filter enabled="true" name="VNXe2-CRF2" next="VNXe2-VHF2" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/vnx2e2.xml" />
		<filter enabled="true" name="VNXe2-CRF1" next="VNXe2-CRF2" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/vnx2e1.xml" />
[#-- workaround. Current xml-collector 1.9u1 strips the leading numbers of the node. this vhf strips the leading number of the crf property in all cases --]
		<filter enabled="true" name="VNXe2-VHF1" next="VNXe2-CRF1" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-vnxe2-fixcrf.xml" />
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
		<collector enabled="${blockenabled}" name="VNXBlockPerformance" next="VNX-CRFSERIALNB" config="Text-Collector/${module['text-collector'].instance}/conf/textoutputcollector-vnxblock-performance.xml" />
		<collector enabled="${blockenabled}" name="VNXBlockTopology" next="VNX-CRFSERIALNB" config="Text-Collector/${module['text-collector'].instance}/conf/textoutputcollector-vnxblock-topology.xml" />
		<collector enabled="[#if use_advancedsettings && !alertcollect]false[#else]${blockenabled}[/#if]" name="XML-API-ECOM" next="vnxblock-ptf" config="XML-Collector/${module['xml-collector'].instance}/conf/vnxblockalerts.xml" />
		<collector enabled="[#if use_topo]${blockenabled}[#else]false[/#if]" name="XML-API-Block-Sparql" next="Backend" config="XML-Collector/${module['xml-collector'].instance}/conf/vnxblock-sparql-collector.xml" />
		<!-- File -->
		[#-- TODO and FIXME MAV FME api cant even respond in 60mins, this needs deeper work...
		<collector enabled="false" name="XML-API-60min" next="vnxfile1" config="XML-Collector/${module['xml-collector'].instance}/conf/vnxfile60.xml" />
		 --]
		<collector enabled="${fileenabled}" name="XML-API-Topology" next="vnxfile1" config="XML-Collector/${module['xml-collector'].instance}/conf/vnxfile-topology.xml" />
		<collector enabled="${fileenabled}" name="XML-API-Performance" next="vnxfile1" config="XML-Collector/${module['xml-collector'].instance}/conf/vnxfile-performance.xml" />
		<collector enabled="${fileenabled}" name="SSH-API-Topology" next="vnxfile1" config="Text-Collector/${module['text-collector'].instance}/conf/textcollector-process-vnxfile-data.xml" />
		[#-- MAV secmap, is related to Quota. VNX had issues for large quotas settings for large customers. Recent OE has patch, but not all VNX in the field are patched yet.
             We should make this an optional setting, in questions.txt, to enable quota reporting or not.
             Disabled for now... until we do it..
		<collector enabled="${fileenabled}" name="SSH-API-12h" next="vnxfile1" config="Text-Collector/${module['text-collector'].instance}/conf/textcollector-process-vnxfile-lowinterval.xml" />
		--]
		<collector enabled="${fileenabled}" name="SSH-API-Producer-60min" next="Null" config="Text-Collector/${module['text-collector'].instance}/conf/textcollector-run-vnxfile-collection-60min.xml" />
		<collector enabled="${fileenabled}" name="SSH-API-Producer-5min" next="Null" config="Text-Collector/${module['text-collector'].instance}/conf/textcollector-run-vnxfile-collection-5min.xml" />
		<collector enabled="[#if use_advancedsettings && !alertcollect]false[#else]${fileenabled}[/#if]" name="XML-API-CS" next="VNX-CRF-ALERTS" config="XML-Collector/${module['xml-collector'].instance}/conf/vnxfilealerts.xml" />

		<!-- Unity -->
		<collector enabled="${unityenabled}" name="Unity-Capacity" next="VNXe2-VHF1" config="XML-Collector/${module['xml-collector'].instance}/conf/vnxe2-capacity.xml" />
		<collector enabled="${unityenabled}" name="Unity-Performance" next="VNXe2-VHF1" config="XML-Collector/${module['xml-collector'].instance}/conf/vnxe2-performance.xml" />
	</collectors>
</config>