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
<!-- https://alliance.emc.com/PCDPartners/VPNSearchkm.asp -->
<configuration xmlns="http://www.watch4net.com/TextOutputCollector"	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/TextOutputCollector textoutputcollector.xsd ">
	<simultaneous-collecting>5</simultaneous-collecting>
	<polling-interval>[#if use_advancedsettings]${perf.pollingperiod}[#else]300[/#if]</polling-interval>
	<collecting-group>group</collecting-group>
	<source>VNXBlock-Collector</source>
	<!-- Include the 2 SPs IP Address for this collecting configuration -->
	<collecting-configuration name="VNX-SPS-RESOURCES" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-sps.xml</parsing-configuration-file>
		<raw-value-group-list master-node="SP .*" delete-after-group="true" variable-id="host datagrp parttype part name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-SP</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="part">
				<position>./</position>
			</property-list>
			<property-list name="partvrs">
				<position>Revision Number For The SP</position>
			</property-list>
			<property-list name="devdesc">
				<position>Revision Number For The SP</position>
			</property-list>
			<property-list name="partsn">
				<position>Serial Number For The SP</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Controller</hardcoded>
			</property-list>
			<value-list name="TotalMemory" leaf="Memory Size For The SP" unit="MB"/>
		</raw-value-group-list>
	</collecting-configuration>
	<!-- Include the 2 SPs IP Address for this collecting configuration -->
	<collecting-configuration name="VNX-CACHE-SPS" timeout="[#if use_advancedsettings]${perf.pollingperiod}[#else]300[/#if]">
		<parsing-configuration-file>conf/parser-getall-sps.xml</parsing-configuration-file>
		<raw-value-group-list master-node="Server IP Address" delete-after-group="true" variable-id="host datagrp parttype part name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-SP-Cache</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Controller</hardcoded>
			</property-list>
			<property-list name="part">
				<position>Storage Processor</position>
			</property-list>
			<property-list name="partname">
				<position>Storage Processor Network Name</position>
			</property-list>
			<property-list name="ip">
				<position>Storage Processor IP Address</position>
			</property-list>
			<value-list name="ReadCount" leaf="Total Reads" type="rate" unit="Nb/s"/>
			<value-list name="WriteCount" leaf="Total Writes" type="rate" unit="Nb/s"/>
			<value-list name="Busy" leaf="Controller busy ticks" type="rate" unit=""/>
			<value-list name="Idle" leaf="Controller idle ticks" type="rate" unit=""/>
			<value-list name="ReadRequests" leaf="Read_requests" type="rate" unit="Nb/s"/>
			<value-list name="WriteRequests" leaf="Write_requests" type="rate" unit="Nb/s"/>
			<value-list name="ReadBlocks" leaf="Blocks_read" type="rate" unit="Nb/s"/>
			<value-list name="WriteBlocks" leaf="Blocks_written" type="rate" unit="Nb/s"/>
			<value-list name="QueueLength" leaf="Sum_queue_lengths_by_arrivals" type="rate" unit="Nb/s"/>
			<value-list name="NonZeroQueue" leaf="Arrivals_to_non_zero_queue" type="rate" unit="Nb/s"/>
			<value-list name="CacheHighWaterFlushOn" leaf="Hw_flush_on" type="rate" unit="Nb/s"/>
			<value-list name="CacheIdleFlushON" leaf="Idle_flush_on" type="rate" unit="Nb/s"/>
			<value-list name="CacheLowWaterFlushOff" leaf="Lw_flush_off" type="rate" unit="Nb/s"/>
			<value-list name="WriteCacheFlushes" leaf="Write_cache_flushes" type="rate" unit="Nb/s"/>
		</raw-value-group-list>
	</collecting-configuration>
	<!-- Use only for Storage Processor SPA -->
	<collecting-configuration name="VNX-CACHE-SPA" timeout="[#if use_advancedsettings]${perf.pollingperiod}[#else]300[/#if]">
		<parsing-configuration-file>conf/parser-cache-spa.xml</parsing-configuration-file>
		<raw-value-group-list master-node="Server IP Address" delete-after-group="true" variable-id="host datagrp parttype part name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-SP-Cache</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="partip">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Controller</hardcoded>
			</property-list>
			<property-list name="part">
				<hardcoded>SP A</hardcoded>
			</property-list>
			<value-list name="LowWatermark" leaf="Low Watermark" unit="%"/>
			<value-list name="HighWatermark" leaf="High Watermark" unit="%"/>
			<value-list name="CacheDirtyPages" leaf="Prct Dirty Cache Pages" unit="%"/>
			<value-list name="CachePagesOwned" leaf="Prct Cache Pages Owned" unit="%"/>
			<value-list name="CachePages" leaf="SPA Cache pages" type="rate" unit="Nb/s"/>
			<value-list name="ReadHit" leaf="Read Hit Ratio" unit="%">
				<replace value="N/A" by="0"/>
			</value-list>
			<value-list name="WriteHit" leaf="Write Hit Ratio" unit="%">
				<replace value="N/A" by="0"/>
			</value-list>
			<value-list name="ReadCacheEnabled" leaf="SPA Read Cache State" unit="">
				<replace value="Enabled" by="1"/>
				<replace value="Disabled" by="0"/>
			</value-list>
			<value-list name="WriteCacheEnabled" leaf="SPA Write Cache State" unit="">
				<replace value="Enabled" by="1"/>
				<replace value="Disabled" by="0"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<!-- Use only for Storage Processor SPB -->
	<collecting-configuration name="VNX-CACHE-SPB" timeout="[#if use_advancedsettings]${perf.pollingperiod}[#else]300[/#if]">
		<parsing-configuration-file>conf/parser-cache-spb.xml</parsing-configuration-file>
		<raw-value-group-list master-node="Server IP Address" delete-after-group="true" variable-id="host datagrp parttype part name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-SP-Cache</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="partip">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Controller</hardcoded>
			</property-list>
			<property-list name="part">
				<hardcoded>SP B</hardcoded>
			</property-list>
			<value-list name="LowWatermark" leaf="Low Watermark" unit="%"/>
			<value-list name="HighWatermark" leaf="High Watermark" unit="%"/>
			<value-list name="CacheDirtyPages" leaf="Prct Dirty Cache Pages" unit="%"/>
			<value-list name="CachePagesOwned" leaf="Prct Cache Pages Owned" unit="%"/>
			<value-list name="CachePages" leaf="SPB Cache pages" type="rate" unit="Nb/s"/>
			<value-list name="ReadHit" leaf="Read Hit Ratio" unit="%">
				<replace value="N/A" by="0"/>
			</value-list>
			<value-list name="WriteHit" leaf="Write Hit Ratio" unit="%">
				<replace value="N/A" by="0"/>
			</value-list>
			<value-list name="ReadCacheEnabled" leaf="SPB Read Cache State" unit="">
				<replace value="Enabled" by="1"/>
				<replace value="Disabled" by="0"/>
			</value-list>
			<value-list name="WriteCacheEnabled" leaf="SPB Write Cache State" unit="">
				<replace value="Enabled" by="1"/>
				<replace value="Disabled" by="0"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-DISKS" timeout="[#if use_advancedsettings]${perf.pollingperiod}[#else]300[/#if]">
		<parsing-configuration-file>conf/parser-disks.xml</parsing-configuration-file>
		<raw-value-group-list master-node="Bus .*" delete-after-group="true" variable-id="datagrp parttype part name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-Disk</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="flare">
				<hardcoded>R32</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Disk</hardcoded>
			</property-list>
			<property-list name="part">
				<position>./</position>
			</property-list>
			<property-list name="partdesc">
				<position>Vendor Id</position>
			</property-list>
			<property-list name="partvrs">
				<position>Product Revision</position>
			</property-list>
			<property-list name="disktype">
				<position>Drive Type</position>
				<replace value="SATA Flash" by="Enterprise Flash Drive"/>
			</property-list>
			<property-list name="partstat">
				<position>State</position>
			</property-list>
			<property-list name="partmdl">
				<position>Product Id</position>
			</property-list>
			<property-list name="partsn">
				<position>Serial Number</position>
			</property-list>
			<property-list name="maxspeed">
				<position>Maximum Speed</position>
			</property-list>
			<property-list name="disksize">
				<position>Capacity</position>
			</property-list>
			<value-list name="Capacity" leaf="Capacity" unit="GB"/>
			<!-- IOPS = ReadRequests + WriteRequests -->
			<value-list name="ReadRequests" leaf="Read Requests" type="rate" unit="Nb/s"/>
			<value-list name="WriteRequests" leaf="Write Requests" type="rate" unit="Nb/s"/>
			<!--
			Will be used for computing the QueueLength of the disk:
			QueueLength = (ReadRequests + WriteRequests) - (Number of Reads + Number of Writes)
			-->
			<!--
			<value-list name="WriteCount" leaf="Number of Writes" type="rate" unit="Nb/s"/>
			<value-list name="ReadCount" leaf="Number of Reads" type="rate" unit="Nb/s"/>
			-->
			<value-list name="ReadThroughput" leaf="Kbytes Read" type="rate" unit="KB/s"/>
			<value-list name="WriteThroughput" leaf="Kbytes Written" type="rate" unit="KB/s"/>
			<value-list name="HardReadErrors" leaf="Hard Read Errors" type="rate" unit="Nb/s"/>
			<value-list name="HardWriteErrors" leaf="Hard Write Errors" type="rate" unit="Nb/s"/>
			<value-list name="SoftReadErrors" leaf="Soft Read Errors" type="rate" unit="Nb/s"/>
			<value-list name="SoftWriteErrors" leaf="Soft Write Errors" type="rate" unit="Nb/s"/>
			<!-- Will be computed as the utilization of the disk:
			CurrentUtilization = 100 * Busy / ( Idle + Busy )
			-->
			<!-- Raw metrics to compute ABQL, QL, Util, RT and ST (the same way as Analyzer) on FLARE 32 only! -->
			<value-list name="BusySPA" leaf="Busy Ticks SPA" type="rate" unit="Nb/s"/>
			<value-list name="IdleSPA" leaf="Idle Ticks SPA" type="rate" unit="Nb/s"/>
			<value-list name="BusySPB" leaf="Busy Ticks SPB" type="rate" unit="Nb/s"/>
			<value-list name="IdleSPB" leaf="Idle Ticks SPB" type="rate" unit="Nb/s"/>
			<value-list name="NonZeroRequestCountArrivals" leaf="Arrivals with Nonzero Queue" type="rate" unit="Nb/s"/>
			<value-list name="SumOutstandingRequests" leaf="Queue Length" type="rate" unit="Nb/s"/>
			<!-- Will be replaced by UserCapcacity into MB -->
			<value-list name="UsedSpace" leaf="User Capacity" unit="GB"/>
			<value-list name="Availability" leaf="State" unit="%">
				<replace value="Failed" by="0"/>
				<replace value="Off" by="1"/>
				<replace value="Empty" by="2"/>
				<replace value="Hot Spare Ready" by="95"/>
				<replace value="Hot Spare Replacing" by="96"/>
				<replace value="Rebuilding" by="97"/>
				<replace value="Equalizing" by="98"/>
				<replace value="Enabled" by="99"/>
				<replace value="Unbound" by="100"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<!-- preR32 -->
	<collecting-configuration name="VNX-DISKS-PRE32" timeout="[#if use_advancedsettings]${perf.pollingperiod}[#else]300[/#if]">
		<parsing-configuration-file>conf/parser-disks-pre32.xml</parsing-configuration-file>
		<raw-value-group-list master-node="Bus .*" delete-after-group="true" variable-id="datagrp parttype part name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-Disk</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="flare">
				<hardcoded>preR32</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Disk</hardcoded>
			</property-list>
			<property-list name="part">
				<position>./</position>
			</property-list>
			<property-list name="partdesc">
				<position>Vendor Id</position>
			</property-list>
			<property-list name="partvrs">
				<position>Product Revision</position>
			</property-list>
			<property-list name="disktype">
				<position>Drive Type</position>
				<replace value="SATA Flash" by="Enterprise Flash Drive"/>
			</property-list>
			<property-list name="partstat">
				<position>State</position>
			</property-list>
			<property-list name="partmdl">
				<position>Product Id</position>
			</property-list>
			<property-list name="partsn">
				<position>Serial Number</position>
			</property-list>
			<property-list name="maxspeed">
				<position>Maximum Speed</position>
			</property-list>
			<property-list name="disksize">
				<position>Capacity</position>
			</property-list>
			<value-list name="Capacity" leaf="Capacity" unit="GB"/>
			<!-- IOPS = ReadRequests + WriteRequests -->
			<value-list name="ReadRequests" leaf="Read Requests" type="rate" unit="Nb/s"/>
			<value-list name="WriteRequests" leaf="Write Requests" type="rate" unit="Nb/s"/>
			<!-- 
			Will be used for computing the QueueLength of the disk:
			QueueLength = (ReadRequests + WriteRequests) - (Number of Reads + Number of Writes)
			-->
			<!--
			<value-list name="WriteCount" leaf="Number of Writes" type="rate" unit="Nb/s"/>
			<value-list name="ReadCount" leaf="Number of Reads" type="rate" unit="Nb/s"/>
			-->
			<value-list name="ReadThroughput" leaf="Kbytes Read" type="rate" unit="KB/s"/>
			<value-list name="WriteThroughput" leaf="Kbytes Written" type="rate" unit="KB/s"/>
			<value-list name="HardReadErrors" leaf="Hard Read Errors" type="rate" unit="Nb/s"/>
			<value-list name="HardWriteErrors" leaf="Hard Write Errors" type="rate" unit="Nb/s"/>
			<value-list name="SoftReadErrors" leaf="Soft Read Errors" type="rate" unit="Nb/s"/>
			<value-list name="SoftWriteErrors" leaf="Soft Write Errors" type="rate" unit="Nb/s"/>
			<!--
			Will be computed as the utilization of the disk:
			CurrentUtilization = 100 * Busy / ( Idle + Busy )
			-->
			<!-- Raw metrics to compute ABQL, QL, Util, RT and ST (the same way as WLA - different than Analyzer) on FLARE < 32 only! -->
			<value-list name="Busy" leaf="Busy Ticks" type="rate" unit="Nb/s"/>
			<value-list name="Idle" leaf="Idle Ticks" type="rate" unit="Nb/s"/>
			<!-- Will be replaced by UserCapcacity into MB -->
			<value-list name="UsedSpace" leaf="User Capacity" unit="GB"/>
			<value-list name="Availability" leaf="State" unit="%">
				<replace value="Failed" by="0"/>
				<replace value="Off" by="1"/>
				<replace value="Empty" by="2"/>
				<replace value="Hot Spare Ready" by="95"/>
				<replace value="Hot Spare Replacing" by="96"/>
				<replace value="Rebuilding" by="97"/>
				<replace value="Equalizing" by="98"/>
				<replace value="Enabled" by="99"/>
				<replace value="Unbound" by="100"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-DISKS-QUEUE" timeout="[#if use_advancedsettings]${perf.pollingperiod}[#else]300[/#if]">
		<parsing-configuration-file>conf/parser-luns-disks-queue.xml</parsing-configuration-file>
		<raw-value-group-list master-node="DISK_.*" delete-after-group="true" variable-id="datagrp parttype part name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-Disk</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="flare">
				<hardcoded>preR32</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Disk</hardcoded>
			</property-list>
			<property-list name="part">
				<position>DiskName</position>
			</property-list>
			<value-list name="SumOutstandingRequests" leaf="QueueLength" type="rate" unit="Nb/s"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-LUNS" timeout="[#if use_advancedsettings]${perf.pollingperiod}[#else]300[/#if]">
		<parsing-configuration-file>conf/parser-luns.xml</parsing-configuration-file>
		<raw-value-group-list master-node="LOGICAL UNIT NUMBER .*" delete-after-group="false" variable-id="host datagrp parttype part name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-LUN</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="part">
				<position>./</position>
			</property-list>
			<property-list name="partdesc">
				<position>Name</position>
			</property-list>
			<!--
			Not available when Pool LUN
			<property-list name="dgraid">
				<position>RAID Type</position>
			</property-list>
			<property-list name="dgroup">
				<position>RAIDGroup ID</position>
			</property-list>
			<property-list name="dgname">
				<position>RAIDGroup ID</position>
			</property-list>
			-->
			<property-list name="memberof">
				<position>Current owner</position>
			</property-list>
			<property-list name="private">
				<position>Is Private</position>
				<replace value="Yes"   by="YES"/>
				<replace value="No"    by="NO"/>
			</property-list>
			<property-list name="dgstype">
				<position>Is Thin LUN</position>
				<replace value="Yes"   by="Thin"/>
				<replace value="YES"   by="Thin"/>
				<replace value="No"    by="Thick"/>
				<replace value="NO"    by="Thick"/>
			</property-list>
			<property-list name="partsn">
				<position>UID</position>
			</property-list>
			<value-list name="HardErrors" leaf="Total Hard Errors" type="rate" unit="Nb"/>
			<value-list name="SoftErrors" leaf="Total Soft Errors" type="rate" unit="Nb"/>
			<value-list name="PrefetchedBlocks" leaf="Prefetched blocks" type="rate" unit="Nb/s"/>
			<value-list name="UnusedPrefetchedBlocks" leaf="Unused prefetched blocks" type="rate" unit="Nb/s"/>
			<value-list name="StripCrossing" leaf="Stripe Crossing" type="rate" unit="Nb/s"/>
			<value-list name="Capacity" leaf="LUN Capacity(Megabytes)" unit="GB"/>
			<value-list name="ReadCacheHits" leaf="Read cache hits" type="rate" unit="Nb/s"/>
			<value-list name="WriteCacheHits" leaf="Write cache hits" type="rate" unit="Nb/s"/>
			<value-list name="ForcedFlushes" leaf="Forced flushes" type="rate" unit="Nb/s"/>
			<value-list name="ReadCacheMisses" leaf="Read cache misses" type="rate" unit="nb">
				<replace value="N/A" by="0"/>
			</value-list>
			<value-list name="Availability" leaf="State" unit="%">
				<replace value="Bound" by="100"/>
				<replace value="Faulted" by="0"/>
			</value-list>
			<value-list name="WriteCacheEnabled" leaf="Write cache" unit="">
				<replace value="ENABLED" by="1"/>
				<replace value="DISABLED" by="0"/>
			</value-list>
			<value-list name="ReadCacheEnabled" leaf="Read cache" unit="">
				<replace value="ENABLED" by="1"/>
				<replace value="DISABLED" by="0"/>
			</value-list>
			<value-list name="ReadBlocksSPA" leaf="Blocks Read SPA" type="rate" unit="Nb/s"/>
			<value-list name="WriteBlocksSPA" leaf="Blocks Written SPA" type="rate" unit="Nb/s"/>
			<value-list name="ReadRequestsSPA" leaf="Read Requests SPA" type="rate" unit="Nb/s"/>
			<value-list name="WriteRequestsSPA" leaf="Write Requests SPA" type="rate" unit="Nb/s"/>
			<value-list name="BusySPA" leaf="LUN Busy Ticks SPA" type="rate" unit="Nb/s"/>
			<value-list name="IdleSPA" leaf="LUN Idle Ticks SPA" type="rate" unit="Nb/s"/>
			<value-list name="NonZeroRequestCountArrivalsSPA" leaf="Non-zero Request Count Arrivals SPA" type="rate" unit="Nb/s"/>
			<value-list name="SumOutstandingRequestsSPA" leaf="Sum of Oustanding Requests SPA" type="rate" unit="Nb/s"/>
			<value-list name="ReadBlocksSPB" leaf="Blocks Read SPB" type="rate" unit="Nb/s"/>
			<value-list name="WriteBlocksSPB" leaf="Blocks Written SPB" type="rate" unit="Nb/s"/>
			<value-list name="ReadRequestsSPB" leaf="Read Requests SPB" type="rate" unit="Nb/s"/>
			<value-list name="WriteRequestsSPB" leaf="Write Requests SPB" type="rate" unit="Nb/s"/>
			<value-list name="BusySPB" leaf="LUN Busy Ticks SPB" type="rate" unit="Nb/s"/>
			<value-list name="IdleSPB" leaf="LUN Idle Ticks SPB" type="rate" unit="Nb/s"/>
			<value-list name="NonZeroRequestCountArrivalsSPB" leaf="Non-zero Request Count Arrivals SPB" type="rate" unit="Nb/s"/>
			<value-list name="SumOutstandingRequestsSPB" leaf="Sum of Oustanding Requests SPB" type="rate" unit="Nb/s"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-LUNPOOLS" timeout="[#if use_advancedsettings]${perf.pollingperiod}[#else]300[/#if]">
		<parsing-configuration-file>conf/parser-lunpools.xml</parsing-configuration-file>
		<raw-value-group-list master-node="LOGICAL UNIT NUMBER .*" delete-after-group="false" variable-id="host datagrp parttype part name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-PoolLUN</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="part">
				<position>./</position>
			</property-list>
			<property-list name="partdesc">
				<position>Name</position>
			</property-list>
			<property-list name="dgraid">
				<position>Raid Type</position>
				<replace value="r_0"   by="RAID-0"/>
				<replace value="r0"    by="RAID-0"/>
				<replace value="r_1"   by="RAID-1"/>
				<replace value="r1"    by="RAID-1"/>
				<replace value="r_1_0" by="RAID-10"/>
				<replace value="r1_0"  by="RAID-10"/>
				<replace value="r_10"  by="RAID-10"/>
				<replace value="r_3"   by="RAID-3"/>
				<replace value="r3"    by="RAID-3"/>
				<replace value="r_5"   by="RAID-5"/>
				<replace value="r5"    by="RAID-5"/>
				<replace value="r_6"   by="RAID-6"/>
				<replace value="r6"    by="RAID-6"/>
				<replace value="hot_spare"    by="Hot Spare"/>
				<replace value="disk"  by="Disk"/>
			</property-list>
			<property-list name="module">
				<position>Disk Type</position>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<property-list name="dgroup">
				<position>Pool Name</position>
			</property-list>
			<property-list name="dgname">
				<position>Pool Name</position>
			</property-list>
			<property-list name="poolname">
				<position>Pool Name</position>
			</property-list>
			<property-list name="dgstype">
				<position>Is Thin LUN</position>
				<replace value="Yes"   by="Thin"/>
				<replace value="No"    by="Thick"/>
			</property-list>
			<property-list name="memberof">
				<position>Current owner</position>
			</property-list>
			<property-list name="private">
				<position>Is Private</position>
				<replace value="Yes"   by="YES"/>
				<replace value="No"    by="NO"/>
			</property-list>
			<property-list name="ispolcsu">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="partsn">
				<position>UID</position>
			</property-list>
			<value-list name="ConsumedCapacity" leaf="Consumed Capacity (GBs)" unit="GB"/>
			<value-list name="PresentedCapacity" leaf="User Capacity (GBs)" unit="GB"/>
			<value-list name="ExplicitTrespassesSPA" leaf="Explicit Trespasses SP A" type="rate" unit="Nb/s"/>
			<value-list name="ImplicitTrespassesSPA" leaf="Implicit Trespasses SP A" type="rate" unit="Nb/s"/>
			<value-list name="ReadRequestsSPA" leaf="Read Requests SP A" type="rate" unit="Nb/s"/>
			<value-list name="WriteRequestsSPA" leaf="Write Requests SP A" type="rate" unit="Nb/s"/>
			<value-list name="ReadBlocksSPA" leaf="Blocks Read SP A" type="rate" unit="Nb/s"/>
			<value-list name="WriteBlocksSPA" leaf="Blocks Written SP A" type="rate" unit="Nb/s"/>
			<value-list name="IdleSPA" leaf="Idle Ticks SP A" type="rate" unit="Nb/s"/>
			<value-list name="BusySPA" leaf="Busy Ticks SP A" type="rate" unit="Nb/s"/>
			<value-list name="NonZeroRequestCountArrivalsSPA" leaf="Non-Zero Request Count Arrivals SP A" type="rate" unit="Nb/s"/>
			<value-list name="SumOutstandingRequestsSPA" leaf="Sum of Outstanding Requests SP A" type="rate" unit="Nb/s"/>
			<value-list name="ExplicitTrespassesSPB" leaf="Explicit Trespasses SP B" type="rate" unit="Nb/s"/>
			<value-list name="ImplicitTrespassesSPB" leaf="Implicit Trespasses SP B" type="rate" unit="Nb/s"/>
			<value-list name="ReadRequestsSPB" leaf="Read Requests SP B" type="rate" unit="Nb/s"/>
			<value-list name="WriteRequestsSPB" leaf="Write Requests SP B" type="rate" unit="Nb/s"/>
			<value-list name="ReadBlocksSPB" leaf="Blocks Read SP B" type="rate" unit="Nb/s"/>
			<value-list name="WriteBlocksSPB" leaf="Blocks Written SP B" type="rate" unit="Nb/s"/>
			<value-list name="IdleSPB" leaf="Idle Ticks SP B" type="rate" unit="Nb/s"/>
			<value-list name="BusySPB" leaf="Busy Ticks SP B" type="rate" unit="Nb/s"/>
			<value-list name="NonZeroRequestCountArrivalsSPB" leaf="Non-Zero Request Count Arrivals SP B" type="rate" unit="Nb/s"/>
			<value-list name="SumOutstandingRequestsSPB" leaf="Sum of Outstanding Requests SP B" type="rate" unit="Nb/s"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-PORTS-PERFORMANCE" timeout="[#if use_advancedsettings]${perf.pollingperiod}[#else]300[/#if]">
		<parsing-configuration-file>conf/parser-ports-perf.xml</parsing-configuration-file>
		<raw-value-group-list master-node=".*SP ." delete-after-group="true" variable-id="host datagrp parttype part memberof name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-Port</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Port</hardcoded>
			</property-list>
			<property-list name="part">
				<position>SP Port ID</position>
			</property-list>
			<property-list name="portid">
				<position>SP Port ID</position>
			</property-list>
			<property-list name="partsn">
				<position>SP UID</position>
			</property-list>
			<property-list name="partdesc">
				<position>Usage</position>
			</property-list>
			<property-list name="memberof">
				<position>./</position>
			</property-list>
			<property-list name="porttype">
				<hardcoded>FA</hardcoded>
			</property-list>
			<value-list name="LinkStatus" leaf="Link Status" unit="%">
				<replace value="Down" by="0"/>
				<replace value="Up" by="100"/>
			</value-list>
			<value-list name="Availability" leaf="Port Status" unit="%">
				<replace value="DISABLED" by="0"/>
				<replace value="Online" by="100"/>
			</value-list>
			<value-list name="SFPState" leaf="SFP State" unit="%">
				<replace value="DISABLED" by="0"/>
				<replace value="Online" by="100"/>
			</value-list>
			<value-list name="ReadCount" type="rate" leaf="Reads" unit="Nb/s"/>
			<value-list name="WriteCount" type="rate" leaf="Writes" unit="Nb/s"/>
			<value-list name="Full" leaf="Queue Full.*" unit="%"/>
			<value-list name="ReadThroughput" type="rate" leaf="Blocks Read" unit="Block/s"/>
			<value-list name="WriteThroughput" type="rate" leaf="Blocks Written" unit="Block/s"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-LUNS-FASTCACHE" timeout="[#if use_advancedsettings]${perf.pollingperiod}[#else]300[/#if]">
		<parsing-configuration-file>conf/parser-luns-fc.xml</parsing-configuration-file>
		<raw-value-group-list master-node="LOGICAL UNIT NUMBER .*" delete-after-group="true" variable-id="host datagrp parttype part name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-LUN-FASTCache</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="part">
				<position>./</position>
			</property-list>
			<property-list name="fcstate">
				<position>FAST Cache</position>
			</property-list>
			<value-list name="FCEnabled" leaf="FAST Cache" unit="%">
				<replace value="Enabled" by="100" />
				<replace value="Disabled" by="0" />
				<replace value="N/A" by="0" />
			</value-list>
			<value-list name="FCReadHits" leaf="FAST Cache Read Hits" type="rate" unit="Hits/s" />
			<value-list name="FCWriteHits" leaf="FAST Cache Write Hits" type="rate" unit="Hits/s" />
			<value-list name="FCReadMisses" leaf="FAST Cache Read Misses" type="rate" unit="Misses/s" />
			<value-list name="FCWriteMisses" leaf="FAST Cache Write Misses" type="rate" unit="Misses/s" />
		</raw-value-group-list>
	</collecting-configuration>
</configuration>