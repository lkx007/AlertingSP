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
	<polling-interval>[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]</polling-interval>
	<collecting-group>group</collecting-group>
	<source>VNXBlock-Collector</source>
	<collecting-configuration name="VNX-AGENTS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-agents.xml</parsing-configuration-file>
		<raw-value-group-list master-node="AGENT.*" delete-after-group="true" variable-id="serialnb datagrp parttype part name">
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
			<property-list name="serialnb">
				<position>Serial No</position>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-Array</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="model">
				<position>Model</position>
			</property-list>
			<property-list name="revision">
				<position>Revision</position>
			</property-list>
			<property-list name="part">
				<hardcoded>System</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Memory</hardcoded>
			</property-list>
			<property-list name="arraytyp">
				<hardcoded>CLARiiON</hardcoded>
			</property-list>
			<property-list name="vendor">
				<hardcoded>EMC Corporation</hardcoded>
			</property-list>
			<value-list name="TotalMemory" leaf="SP Memory" unit="MB"/>
			<value-list name="Availability" leaf="Availability" unit="%">
				<replace value="" by="100"/>
			</value-list>
			<!-- Used for zeroing NULL values. -->
			<value-list name="RemoveMeZero" leaf="RemoveMeZero" unit="">
				<replace value="" by="0"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-SPS-APPLICATIONS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-getall-hosts.xml</parsing-configuration-file>
		<raw-value-group-list master-node="HOST_.*" delete-after-group="true" variable-id="host datagrp parttype part name">
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
			<property-list name="parttype">
				<hardcoded>Application</hardcoded>
			</property-list>
			<property-list name="part">
				<position>SoftwareName</position>
			</property-list>
			<property-list name="partvrs">
				<position>SoftwareRevision</position>
			</property-list>
			<property-list name="apcommit">
				<position>CommitRequired</position>
			</property-list>
			<property-list name="aprevert">
				<position>RevertPossible</position>
			</property-list>
			<property-list name="apsetup">
				<position>IsInstallationCompleted</position>
			</property-list>
			<property-list name="apsystem">
				<position>IsThisSystemSoftware</position>
			</property-list>
			<value-list name="Availability" leaf="ActiveState" unit="%">
				<replace value="YES" by="100"/>
				<replace value="NO" by="0"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-LUNS-DISKS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-luns-disks.xml</parsing-configuration-file>
		<raw-value-group-list master-node="LUN_.*" delete-after-group="false" variable-id="host datagrp parttype part name">
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
			<property-list name="partid">
				<position>LunID</position>
			</property-list>
			<property-list name="spindles">
				<position>DiskName</position>
			</property-list>
			<value-list name="RemoveMe" leaf="RemoveMe" unit=""/>
			<!-- Used for zeroing NULL values for LUNs. -->
			<value-list name="RemoveMeZeroLun" leaf="RemoveMeZeroLun" unit="">
				<replace value="" by="0"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-METAHEAD-LUNS">
		<parsing-configuration-file>conf/parser-metahead-luns.xml</parsing-configuration-file>
		<raw-value-group-list master-node="METALUN_INFO_.*" delete-after-group="false" variable-id="host datagrp parttype partid name">
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
			<property-list name="partid">
				<position>metalunid</position>
			</property-list>
			<property-list name="partsn">
				<position>WWN</position>
			</property-list>
			<property-list name="ismetah">
				<hardcoded>1</hardcoded>
			</property-list>
			<value-list name="PresentedCapacity" leaf="PresentedCapacity (MB)" unit="GB"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-METALUNS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-metaluns.xml</parsing-configuration-file>
		<raw-value-group-list master-node="METALUN_INFO_.*" delete-after-group="false" variable-id="host datagrp parttype partid name">
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
				<hardcoded>VNXBlock-MetaLUN</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>MetaHead</hardcoded>
			</property-list>
			<property-list name="partid">
				<position>metalunid</position>
			</property-list>
			<property-list name="partdesc">
				<position>metalunname</position>
			</property-list>
			<property-list name="ismetah">
				<hardcoded>1</hardcoded>
			</property-list>
			<value-list name="Capacity" leaf="TotalCapacity (MB)" unit="GB"/>
		</raw-value-group-list>
		<raw-value-group-list master-node="METAMEMBER_INFO_.*" delete-after-group="false" variable-id="host datagrp parttype partid name">
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
				<hardcoded>VNXBlock-MetaLUN</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>MetaMember</hardcoded>
			</property-list>
			<property-list name="partid">
				<position>lunnumber</position>
			</property-list>
			<property-list name="partdesc">
				<position>lunname</position>
			</property-list>
			<property-list name="ismetam">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="metahid">
				<position>../metalunid</position>
			</property-list>
			<property-list name="metahead">
				<position>../metalunname</position>
			</property-list>
			<value-list name="RemoveMe" leaf="RemoveMe" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-PORTS-INITIATORS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-ports.xml</parsing-configuration-file>
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
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-Port</hardcoded>
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
			<property-list name="memberof">
				<position>./</position>
			</property-list>
			<property-list name="porttype">
				<hardcoded>FA</hardcoded>
			</property-list>
			<value-list name="LoggedInInitiators" leaf="Logged-In Initiators" unit=""/>
			<value-list name="NotLoggedInInitiators" leaf="Not Logged-In Initiators" unit=""/>
			<value-list name="RegisteredInitiators" leaf="Registered Initiators" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-STORAGEPOOLS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-storagepools.xml</parsing-configuration-file>
		<raw-value-group-list master-node="POOL_INFO_.*" delete-after-group="true" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-StoragePool</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<property-list name="part">
				<position>PoolName</position>
			</property-list>
			<property-list name="partdesc">
				<position>Description</position>
			</property-list>
			<property-list name="module">
				<position>raidtype</position>
			</property-list>
			<!-- fastvp -->
			<property-list name="vols">
				<position>LUNs</position>
			</property-list>
			<!-- fastvp -->
			<property-list name="dgtype">
				<position>Storage Pool</position>
			</property-list>
			<property-list name="dgraid">
				<position>RaidType</position>
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
				<replace value="Mixed" by="Mixed"/>
				<replace value="disk"  by="Disk"/>
			</property-list>
			<value-list name="Capacity" leaf="UserCapacityGbs" unit="GB"/>
			<value-list name="RawCapacity" leaf="RawCapacityGbs" unit="GB"/>
			<value-list name="SubscribedCapacity" leaf="TotalSubscribedCapacityGbs" unit="GB"/>
			<value-list name="UsedCapacity" leaf="ConsumedCapacityGbs" unit="GB"/>
			<value-list name="FreeCapacity" leaf="AvailableCapacityGbs" unit="GB"/>
			<value-list name="Full" leaf="PercentFull" unit="%"/>
			<value-list name="Subscribed" leaf="PercentSubscribed" unit="%"/>
			<value-list name="OversubscribedCapacity" leaf="OverSubscribedByGbs" unit="GB"/>
			<value-list name="Availability" leaf="State" unit="%">
				<replace value="Ready" by="100"/>
				<replace value="Offline" by="0"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-STORAGEPOOLS-FASTCACHE">
		<parsing-configuration-file>conf/parser-storagepools-fc.xml</parsing-configuration-file>
		<raw-value-group-list master-node="POOL_INFO_.*" delete-after-group="true" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-StoragePool</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<property-list name="part">
				<position>PoolName</position>
			</property-list>
			<property-list name="poolname">
				<position>PoolName</position>
			</property-list>
			<property-list name="hasfc">
				<position>FASTCache</position>
				<replace value="Enabled" by="1"/>
				<replace value="Disabled" by="0"/>
			</property-list>
			<value-list name="RemoveMe" leaf="RemoveMe" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-SNAPPOOLS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-snappools.xml</parsing-configuration-file>
		<raw-value-group-list master-node="SNAP_POOL_.*" delete-after-group="false" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-SnapPool</hardcoded>
			</property-list>			
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<property-list name="part">
				<position>Name of the SP</position>
			</property-list>
			<property-list name="poolname">
				<position>Name of the SP</position>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Snap Pool</hardcoded>
			</property-list>
			<property-list name="isfast">
				<hardcoded>0</hardcoded>
			</property-list>
			<value-list name="Capacity" leaf="Total size in GB" unit="GB"/>
			<value-list name="UsedCapacity" leaf="Used LUN Pool in GB" unit="GB"/>
			<value-list name="FreeCapacity" leaf="Unallocated size in GB" unit="GB"/>
		</raw-value-group-list>
		<raw-value-group-list master-node="UNALLOCATED_.*" delete-after-group="false" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-SnapPool</hardcoded>
			</property-list>
			<property-list name="dgroup">
				<position>../Name of the SP</position>
			</property-list>
			<property-list name="dgname">
				<position>../Name of the SP</position>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>Snap Pool</hardcoded>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Snap Pool</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="ispolctr">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="ispolcsu">
				<hardcoded>0</hardcoded>
			</property-list>
			<property-list name="svclevel">
				<hardcoded>Pool Contributor</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="part">
				<position>LUN Name</position>
			</property-list>
			<property-list name="poolname">
				<position>../Name of the SP</position>
			</property-list>
			<property-list name="purpose">
				<hardcoded>Pool Contributor</hardcoded>
			</property-list>
			<!-- Later on, will add this to RemoveMe metric and propagate via cross-referencing-filter-->
			<value-list name="PropertiesOnly" leaf="LUN Name" unit="" />
		</raw-value-group-list>
		<!-- Allocated LUN is the one that is used from the Reserved LUN Pool to provide the storage for the replicated data-->
		<raw-value-group-list master-node="ALLOCATED_.*" delete-after-group="false" variable-id="host datagrp parttype part name">
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
			<property-list name="srcarray">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-SnapPool</hardcoded>
			</property-list>
			<property-list name="dgroup">
				<position>../Name of the SP</position>
			</property-list>
			<property-list name="dgname">
				<position>../Name of the SP</position>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>Snap Pool</hardcoded>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Snap Pool</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="ispolctr">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="ispolcsu">
				<hardcoded>0</hardcoded>
			</property-list>
			<property-list name="svclevel">
				<hardcoded>Pool Contributor</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="arraytyp">
				<hardcoded>CLARiiON</hardcoded>
			</property-list>
			<property-list name="repltype">
				<hardcoded>Snapshot</hardcoded>
			</property-list>
			<property-list name="part">
				<position>Allocated LUNs</position>
			</property-list>
			<property-list name="partid">
				<position>Allocated LUNs</position>
			</property-list>
			<property-list name="srclun">
				<position>Primary LUN</position>
			</property-list>
			<property-list name="poolname">
				<position>../Name of the SP</position>
			</property-list>
			<property-list name="purpose">
				<hardcoded>Pool Contributor</hardcoded>
			</property-list>
			<value-list name="StateOfReplica" leaf="Allocated LUNs" unit="" />
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-LOCALMIRRORPOOLS-LUNS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-localmirrorpoolluns.xml</parsing-configuration-file>
		<raw-value-group-list master-node="SPA" delete-after-group="false" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-LocalMirrorPool</hardcoded>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>Local Replica Mirror Pool</hardcoded>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Local Replica Mirror Pool</hardcoded>
			</property-list>
			<property-list name="dgroup">
				<hardcoded>SP_A_LocalMirror</hardcoded>
			</property-list>
			<property-list name="dgname">
				<hardcoded>SP_A_LocalMirror</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="ispolctr">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="ispolcsu">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="partid">
				<position>../SPA</position>
			</property-list>
			<property-list name="poolname">
				<hardcoded>SP_A_LocalMirror</hardcoded>
			</property-list>
			<property-list name="purpose">
				<hardcoded>Local Replica</hardcoded>
			</property-list>
			<!-- creating fake raw data to collect "inventory" information with PropertyOnly.-->
			<value-list name="PropertiesOnly" leaf="../SPA" unit="" />
		</raw-value-group-list>
		<raw-value-group-list master-node="SPB" delete-after-group="false" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-LocalMirrorPool</hardcoded>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>Local Replica Mirror Pool</hardcoded>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Local Replica Mirror Pool</hardcoded>
			</property-list>
			<property-list name="dgroup">
				<hardcoded>SP_B_LocalMirror</hardcoded>
			</property-list>
			<property-list name="dgname">
				<hardcoded>SP_B_LocalMirror</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="ispolctr">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="ispolcsu">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="partid">
				<position>../SPB</position>
			</property-list>
			<property-list name="poolname">
				<hardcoded>SP_B_LocalMirror</hardcoded>
			</property-list>
			<property-list name="purpose">
				<hardcoded>Local Replica</hardcoded>
			</property-list>
			<!-- creating fake raw data to collect "inventory" information with PropertyOnly.-->
			<value-list name="PropertiesOnly" leaf="../SPB" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-LOCALMIRRORPOOLS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-localmirrorpools.xml</parsing-configuration-file>
		<raw-value-group-list master-node="SPA" delete-after-group="false" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-LocalMirrorPool</hardcoded>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Local Replica Mirror Pool</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<property-list name="part">
				<hardcoded>SP_A_LocalMirror</hardcoded>
			</property-list>
			<property-list name="poolname">
				<hardcoded>SP_A_LocalMirror</hardcoded>
			</property-list>
			<!-- creating fake raw data to collect "inventory" information with PropertyOnly.-->
			<value-list name="PropertiesOnly" leaf="./SPA" unit="" />
		</raw-value-group-list>
		<raw-value-group-list master-node="SPB" delete-after-group="false" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-LocalMirrorPool</hardcoded>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Local Replica Mirror Pool</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<property-list name="part">
				<hardcoded>SP_B_LocalMirror</hardcoded>
			</property-list>
			<property-list name="poolname">
				<hardcoded>SP_B_LocalMirror</hardcoded>
			</property-list>
			<!-- creating fake raw data to collect "inventory" information with PropertyOnly.-->
			<value-list name="PropertiesOnly" leaf="./SPB" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-REMOTEMIRRORPOOLS-LUNS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-remotemirrorpoolluns.xml</parsing-configuration-file>
		<raw-value-group-list master-node="LUNS_.*" delete-after-group="false" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-RemoteMirrorPool</hardcoded>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>Remote Replica Mirror Pool</hardcoded>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Remote Replica Mirror Pool</hardcoded>
			</property-list>
			<property-list name="dgroup">
				<position>SP</position>
				<replace value="SP A" by="SP_A_RemoteMirror"/>
				<replace value="SP B" by="SP_B_RemoteMirror"/>
			</property-list>
			<property-list name="dgname">
				<position>SP</position>
				<replace value="SP A" by="SP_A_RemoteMirror"/>
				<replace value="SP B" by="SP_B_RemoteMirror"/>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="ispolctr">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="ispolcsu">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="partid">
				<position>LUN Name</position>
			</property-list>
			<property-list name="poolname">
				<position>SP</position>
				<replace value="SP A" by="SP_A_RemoteMirror"/>
				<replace value="SP B" by="SP_B_RemoteMirror"/>
			</property-list>
			<property-list name="purpose">
				<hardcoded>Remote Replica</hardcoded>
			</property-list>
			<!-- creating fake raw data to collect "inventory" information with PropertyOnly.-->
			<value-list name="PropertiesOnly" leaf="LUN Name" unit="" />
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-REMOTEMIRRORPOOLS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-remotemirrorpools.xml</parsing-configuration-file>		
		<raw-value-group-list master-node="LUNS_.*" delete-after-group="false" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-RemoteMirrorPool</hardcoded>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Remote Replica Mirror Pool</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<property-list name="part">
				<position>SP</position>
				<replace value="SP A" by="SP_A_RemoteMirror"/>
				<replace value="SP B" by="SP_B_RemoteMirror"/>
			</property-list>
			<property-list name="poolname">
				<position>SP</position>
				<replace value="SP A" by="SP_A_RemoteMirror"/>
				<replace value="SP B" by="SP_B_RemoteMirror"/>
			</property-list>
			<!-- creating fake raw data to collect "inventory" information with PropertyOnly.-->
			<value-list name="PropertiesOnly" leaf="LUN Name" unit="" />
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-STORAGEPOOLS-DISKS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-storagepools-disks.xml</parsing-configuration-file>
		<raw-value-group-list master-node="DISK_.*" delete-after-group="true" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-StoragePool</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Disk</hardcoded>
			</property-list>
			<property-list name="part">
				<position>DiskName</position>
			</property-list>
			<property-list name="poolname">
				<position>../PoolName</position>
			</property-list>
			<property-list name="ispolctr">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<property-list name="dgroup">
				<position>../PoolName</position>
			</property-list>
			<property-list name="dgname">
				<position>../PoolName</position>
			</property-list>
			<property-list name="dgraid">
				<position>../RAIDType</position>
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
				<replace value="Mixed" by="Mixed"/>
				<replace value="disk"  by="Disk"/>
			</property-list>
			<value-list name="RemoveMe" leaf="RemoveMe" unit="">
				<replace value="" by="1"/>
				<replace value=" " by="1"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-RAIDGROUPS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-raidgroups.xml</parsing-configuration-file>
		<raw-value-group-list master-node="RAIDGROUP_INFO_.*" delete-after-group="true" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-RAIDGroup</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>RAID Group</hardcoded>
			</property-list>
			<property-list name="part">
				<position>RaidID</position>
			</property-list>
			<property-list name="dgname">
				<position>RaidID</position>
			</property-list>
			<property-list name="dgtype">
				<position>RAID Group</position>
			</property-list>
			<property-list name="module">
				<position>DriveType</position>
			</property-list>
			<property-list name="dgraid">
				<position>RaidType</position>
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
			<property-list name="vols">
				<position>LunList</position>
			</property-list>
			<value-list name="Capacity" leaf="LogicalCapacity" unit="Blocks"/>
			<value-list name="RawCapacity" leaf="RawCapacity" unit="Blocks"/>
			<value-list name="FreeCapacity" leaf="FreeCapacity" unit="Blocks"/>
			<value-list name="FreeContiguous" leaf="FreeContiguousGroup" unit="Blocks"/>
			<value-list name="Defragmentation" leaf="PercentDefragmented" unit="%">
				<replace value="N/A" by=""/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-RAIDGROUPS-DISKS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-raidgroups-disks.xml</parsing-configuration-file>
		<raw-value-group-list master-node="DISK_.*" delete-after-group="true" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-RAIDGroup</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Disk</hardcoded>
			</property-list>
			<property-list name="part">
				<position>DiskName</position>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>RAID Group</hardcoded>
			</property-list>
			<property-list name="ispolctr">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="dgroup">
				<position>../RAIDGroupName</position>
			</property-list>
			<property-list name="dgname">
				<position>../RAIDGroupName</position>
			</property-list>
			<property-list name="dgraid">
				<position>../RAIDType</position>
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
			<value-list name="RemoveMe" leaf="RemoveMe" unit="">
				<replace value="" by="1"/>
				<replace value=" " by="1"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-RAIDGROUPS-LUNS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-raidgroups-luns.xml</parsing-configuration-file>
		<raw-value-group-list master-node="LUN_.*" delete-after-group="true" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-RAIDGroup</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="part">
				<position>LUNName</position>
			</property-list>
			<property-list name="partid">
				<position>LUNName</position>
			</property-list>
			<property-list name="ispolcsu">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="ispolctr">
				<hardcoded>0</hardcoded>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>RAID Group</hardcoded>
			</property-list>
			<property-list name="dgroup">
				<position>../RAIDGroupName</position>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>RAID Group</hardcoded>
			</property-list>
			<property-list name="poolname">
				<position>../RAIDGroupName</position>
			</property-list>
			<property-list name="dgname">
				<position>../RAIDGroupName</position>
			</property-list>
			<property-list name="module">
				<position>../DriveType</position>
			</property-list>
			<property-list name="dgraid">
				<position>../RAIDType</position>
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
			<value-list name="RemoveMe" leaf="RemoveMe" unit="">
				<replace value="" by="1"/>
				<replace value=" " by="1"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-STORAGEGROUPS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-storagegroups.xml</parsing-configuration-file>
		<raw-value-group-list master-node="LUN_.*" delete-after-group="true" variable-id="host datagrp parttype partid name">
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
				<hardcoded>VNXBlock-StorageGroup</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="partid">
				<position>LUN_ID</position>
			</property-list>
			<property-list name="sgname">
				<position>../SG_NAME</position>
			</property-list>
			<value-list name="RemoveMe" leaf="LUN_ID" unit="%"/>
		</raw-value-group-list>
		<raw-value-group-list master-node="HBA_.*" delete-after-group="true" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-StorageGroup</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Initiator</hardcoded>
			</property-list>
			<property-list name="part">
				<position>HBA_ID</position>
			</property-list>
			<property-list name="sgname">
				<position>../SG_NAME</position>
			</property-list>
			<property-list name="hasinit">
				<hardcoded>1</hardcoded>
			</property-list>
			<property-list name="memberof">
				<position>SPName</position>
				<replace value="A"   by="SP A"/>
				<replace value="B"   by="SP B"/>
				<replace value="a"   by="SP A"/>
				<replace value="b"   by="SP B"/>
			</property-list>
			<property-list name="portid">
				<position>SPPort</position>
			</property-list>
			<value-list name="InitiatorID" leaf="SPPort" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-HOSTS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-hosts.xml</parsing-configuration-file>
		<raw-value-group-list master-node="HOST_.*" delete-after-group="true" variable-id="host datagrp parttype part partsn name">
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
				<hardcoded>VNXBlock-Host</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Host</hardcoded>
			</property-list>
			<property-list name="part">
				<position>ServerName</position>
			</property-list>
			<property-list name="partip">
				<position>ServerIp</position>
			</property-list>
			<property-list name="partdesc">
				<position>Description</position>
			</property-list>
			<property-list name="partsn">
				<position>HbaUid</position>
			</property-list>
			<value-list name="Availability" leaf="Availability" unit="%">
				<replace value="" by="100"/>
				<replace value=" " by="100"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-SNAPSHOTS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-snapshots.xml</parsing-configuration-file>
		<raw-value-group-list master-node="SNAPSHOT_.*" delete-after-group="true" variable-id="deviceid datagrp parttype part partsn name">
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
				<hardcoded>VNXBlock-Snapshot</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Snapshot</hardcoded>
			</property-list>
			<property-list name="part">
				<position>Name</position>
			</property-list>
			<property-list name="partdesc">
				<position>Description</position>
			</property-list>
			<property-list name="state">
				<position>State</position>
			</property-list>
			<property-list name="status">
				<position>Status</position>
			</property-list>
			<property-list name="modif">
				<position>Modified</position>
			</property-list>
			<property-list name="slun">
				<position>Source LUNs</position>
			</property-list>
			<property-list name="plun">
				<position>Primary LUNs</position>
			</property-list>
			<property-list name="alun">
				<position>Attached LUNs</position>
			</property-list>
			<property-list name="allowad">
				<position>Allow auto delete</position>
			</property-list>
			<property-list name="allowrw">
				<position>Allow ReadWrite</position>
			</property-list>
			<property-list name="expdate">
				<position>Expiration date</position>
			</property-list>
			<value-list name="State" leaf="State" unit="" >
				<replace value="Ready" by="100"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-SNAPVIEW-SNAPSHOTS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-snapview-snapshots.xml</parsing-configuration-file>
		<raw-value-group-list master-node="SNAPSHOT_.*" delete-after-group="true" variable-id="deviceid datagrp parttype part partsn name">
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
				<hardcoded>VNXBlock-Snapshot</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="part">
				<position>Name</position>
			</property-list>
			<property-list name="partdesc">
				<position>Name</position>
			</property-list>
			<property-list name="partid">
				<position>UID</position>
			</property-list>
			<property-list name="partsn">
				<position>UID</position>
			</property-list>
			<property-list name="state">
				<position>State</position>
			</property-list>
			<property-list name="srclun">
				<position>Target LUN</position>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>Snap Pool</hardcoded>
			</property-list>
			<property-list name="pooltype">
				<hardcoded>Snap Pool</hardcoded>
			</property-list>
			<property-list name="dgraid">
				<hardcoded>Snapshot Unknown RAID level</hardcoded>
			</property-list>
			<property-list name="purpose">
				<hardcoded>Local Replica</hardcoded>
			</property-list>
			<property-list name="ispolctr">
				<hardcoded>0</hardcoded>
			</property-list>
			<property-list name="ispolcsu">
				<position>State</position>
				<replace value="Active" by="1"/>
				<replace value="Inactive" by="0"/>
			</property-list>
			<property-list name="arraytyp">
				<hardcoded>CLARiiON</hardcoded>
			</property-list>
			<value-list name="PropertiesOnly" leaf="Target LUN" unit="" />
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-MIRRORSYNC">
		<parsing-configuration-file>conf/parser-mirrorsync.xml</parsing-configuration-file>
        <raw-value-group-list master-node="MirrorSync_.*" delete-after-group="true" variable-id="deviceid datagrp parttype part partsn name">
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
				<hardcoded>VNXBlock-MirrorSync</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="repltype">
				<hardcoded>MirrorSync</hardcoded>
			</property-list>
			<property-list name="part">
				<position>Mirror_NAME</position>
			</property-list>
			<property-list name="partsn">
				<position>Second_IMAGE</position>
			</property-list>
			<property-list name="plun">
				<position>Primary_IMAGE</position>
			</property-list>
			<value-list name="StateOfReplica" leaf="Image_Size" unit="Blocks"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-MIRRORASYNC">
		<parsing-configuration-file>conf/parser-mirrorAsync.xml</parsing-configuration-file>
		<raw-value-group-list master-node="MirrorASync_.*" delete-after-group="true" variable-id="deviceid datagrp parttype part partsn name">
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
				<hardcoded>VNXBlock-MirrorASync</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="repltype">
				<hardcoded>MirrorASync</hardcoded>
			</property-list>
			<property-list name="part">
				<position>MirrorASync_NAME</position>
			</property-list>
			<property-list name="partsn">
				<position>SecondASync_IMAGE</position>
			</property-list>
			<property-list name="plun">
				<position>PrimaryASync_IMAGE</position>
			</property-list>
			<value-list name="StateOfReplica" leaf="Image_Size" unit="Blocks"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-CLONEGROUPS">
		<parsing-configuration-file>conf/parser-clonegroups.xml</parsing-configuration-file>
		<raw-value-group-list master-node="CloneLun_.*" delete-after-group="true" variable-id="deviceid datagrp parttype partid name">
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
			<property-list name="srcarray">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-CLONEGROUPS</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="repltype">
				<hardcoded>Clone</hardcoded>
			</property-list>
			<property-list name="part">
				<position>CloneLUN_Name</position>
			</property-list>
			<property-list name="srclun">
				<position>../Primary_LUN</position>
			</property-list>
			<property-list name="partid">
				<position>CloneLUN_Name</position>
			</property-list>
			<value-list name="StateOfReplica" leaf="./CloneLUN_Name" unit=" "/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-COMPRESSION" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-compression.xml</parsing-configuration-file>
		<raw-value-group-list master-node="COMPLUN_.*" delete-after-group="true" variable-id="deviceid datagrp parttype part partsn name">
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
				<hardcoded>VNXBlock-Compression</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="part">
				<position>lun</position>
			</property-list>
			<property-list name="partid">
				<position>lun</position>
			</property-list>
			<property-list name="partdesc">
				<position>name</position>
			</property-list>
			<property-list name="cstate">
				<position>currentstate</position>
			</property-list>
			<property-list name="cstatus">
				<position>status</position>
			</property-list>
			<property-list name="crate">
				<position>rate</position>
			</property-list>
			<value-list name="cpcomp" leaf="perccomplete" unit="%"/>
			<value-list name="tcapb"  leaf="tcapb" unit="Blocks"/>
			<value-list name="tcapg"  leaf="tcapg" unit="GBytes"/>
			<value-list name="ccapb"  leaf="ccapb" unit="Blocks"/>
			<value-list name="ccapg"  leaf="ccapg" unit="GBytes"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-HBAUID" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-hbauid.xml</parsing-configuration-file>
		<raw-value-group-list master-node="HBA_.*" delete-after-group="true" variable-id="host datagrp parttype partsn name">
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
				<hardcoded>VNXBlock-Host</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Host</hardcoded>
			</property-list>
			<property-list name="partsn">
				<position>HBA_UID</position>
			</property-list>
			<property-list name="sgname">
				<position>../SG_NAME</position>
			</property-list>
			<value-list name="RemoveMe" leaf="REMOVE_ME" unit="%"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-UNUSEDLUNS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-unusedluns.xml</parsing-configuration-file>
		<raw-value-group-list master-node="LUN_.*" delete-after-group="true" variable-id="host datagrp parttype dgraid partid name">
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
				<hardcoded>VNXBlock-LUN</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="partid">
				<position>LunId</position>
			</property-list>
			<property-list name="dgraid">
				<position>../RaidgroupId</position>
			</property-list>
			<value-list name="Unused" leaf="Unused" unit="">
				<replace value="" by="1"/>
				<replace value=" " by="1"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-FASTCACHE" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-fastcache.xml</parsing-configuration-file>
		<raw-value-group-list master-node="SP.*" delete-after-group="true" variable-id="host datagrp part name">
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
				<hardcoded>VNXBlock-FASTCache</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>FAST Cache</hardcoded>
			</property-list>
			<property-list name="part">
				<hardcoded>FAST Cache</hardcoded>
			</property-list>
			<property-list name="memberof">
				<position>./</position>
				<replace value="(SP.)" by="$1" />
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="partstat">
				<position>../State</position>
			</property-list>
			<property-list name="partmdl">
				<position>../Mode</position>
			</property-list>
			<property-list name="dgraid">
				<position>../RaidType</position>
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
			<value-list name="Dirty" leaf="Percentage Dirty SP." unit="%" />
			<value-list name="Flushed" leaf="MBs Flushed SP." type="rate" unit="MB" />
			<value-list name="Size" leaf="../Size" unit="GB" />
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-FASTCACHE-DISKS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-fastcache-disks.xml</parsing-configuration-file>
		<raw-value-group-list master-node="DISK_.*" delete-after-group="true" variable-id="host datagrp parttype part name">
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
				<hardcoded>VNXBlock-FASTCache</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Disk</hardcoded>
			</property-list>
			<property-list name="part">
				<position>DiskName</position>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>FAST Cache</hardcoded>
			</property-list>
			<property-list name="dgroup">
				<hardcoded>FAST Cache</hardcoded>
			</property-list>
			<property-list name="dgname">
				<hardcoded>FAST Cache</hardcoded>
			</property-list>
			<property-list name="dgraid">
				<position>../RAIDType</position>
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
			<value-list name="RemoveMe" leaf="RemoveMe" unit="">
				<replace value="" by="1"/>
				<replace value=" " by="1"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-TIERS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-storagepool-list-tiers.xml</parsing-configuration-file>
		<raw-value-group-list master-node="TIER_.*" delete-after-group="true" variable-id="host datagrp part dgname name">
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
				<hardcoded>VNXBlock-StoragePool-Tier</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Storage Tier</hardcoded>
			</property-list>
			<property-list name="part">
				<position>TierName</position>
			</property-list>
			<property-list name="dgroup">
				<position>../PoolName</position>
			</property-list>
			<property-list name="dgname">
				<position>../PoolName</position>
			</property-list>
			<property-list name="dgraid">
				<position>RaidType</position>
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
			<property-list name="unit">
				<hardcoded>GB</hardcoded>
			</property-list>
			<value-list name="UserCapacity" leaf="UserCapacity" unit="GB" />
			<value-list name="ConsumedCapacity" leaf="ConsumedCapacity" unit="GB" />
			<value-list name="FreeCapacity" leaf="AvailableCapacity" unit="GB" />
			<value-list name="Subscribed" leaf="PercentSubscribed" unit="GB" />
			<value-list name="DataTargetedforHigherTier" leaf="DataTargetedforHigherTier" unit="GB">
				<replace value="null" by="0" />
			</value-list>
			<value-list name="DataTargetedforLowerTier" leaf="DataTargetedforLowerTier" unit="GB">
				<replace value="null" by="0" />
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-TIER-DISKS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-storagepool-list-tier-disks.xml</parsing-configuration-file>
		<raw-value-group-list master-node="DISK_.*" delete-after-group="false" variable-id="host datagrp part name">
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
				<hardcoded>VNXBlock-StoragePool-TierDisks</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Disk</hardcoded>
			</property-list>
			<property-list name="part">
				<position>DiskName</position>
			</property-list>
			<property-list name="tiername">
				<position>../TierName</position>
			</property-list>
			<property-list name="dgroup">
				<position>../../PoolName</position>
			</property-list>
			<property-list name="dgname">
				<position>../../PoolName</position>
			</property-list>
			<property-list name="poolname">
				<position>../../PoolName</position>
			</property-list>
			<property-list name="dgtype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<value-list name="RemoveMe" leaf="../../PoolID" unit="" />
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-TIERS-AUTOTIERING" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-storagepool-autotiering.xml</parsing-configuration-file>
		<raw-value-group-list master-node="POOL.*" delete-after-group="true" variable-id="host datagrp part dgname name">
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
				<hardcoded>VNXBlock-StoragePool-TierAutoTiering</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Storage Tier</hardcoded>
			</property-list>
			<property-list name="dgroup">
				<position>../PoolName</position>
			</property-list>
			<property-list name="dgname">
				<position>../PoolName</position>
			</property-list>
			<property-list name="unit">
				<hardcoded>GB</hardcoded>
			</property-list>
			<value-list name="DatatoMoveWithinTiers" leaf="within" unit="GB" />
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNX-LUNS-TIERS" timeout="[#if use_advancedsettings]${topology.pollingperiod}[#else]900[/#if]">
		<parsing-configuration-file>conf/parser-luns-tiers.xml</parsing-configuration-file>
		<raw-value-group-list master-node="TIER_.*" delete-after-group="true" variable-id="host datagrp partid tiername name">
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
				<hardcoded>VNXBlock-LUNs-Tier</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>LUN</hardcoded>
			</property-list>
			<property-list name="tiername">
				<position>./TierName</position>
				<replace value="Extreme Performance"    by="Extreme Performance"/>
				<replace value="Flash"    by="Extreme Performance"/>
				<replace value="Performance"   by="Performance"/>
				<replace value="FC"    by="Performance"/>
				<replace value="Capacity"   by="Capacity"/>
				<replace value="SATA"   by="Capacity"/>
			</property-list>
			<property-list name="partdesc">
				<position>../LUNName</position>
			</property-list>
			<property-list name="partid">
				<position>../LUNID</position>
			</property-list>
			<property-list name="tierdist">
				<position>../ConsumedCapacity</position>
			</property-list>
			<property-list name="polname">
				<position>../TierPolicy</position>
			</property-list>
			<property-list name="unit">
				<hardcoded>GB</hardcoded>
			</property-list>
			<value-list name="TierCapacity" leaf="./TierDist" unit="GB" />
		</raw-value-group-list>
	</collecting-configuration>
</configuration>