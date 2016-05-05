[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<configuration xmlns="http://www.watch4net.com/XMLCollector" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/XMLCollector xmlcollector.xsd ">
	<simultaneous-collecting>1</simultaneous-collecting>
	<polling-interval>900</polling-interval>
	<collecting-group>group</collecting-group>
	<source>VMAX-Collector</source>
	<refresh>0</refresh>
	<collecting-configuration id="VMAX-ARRAYS" variable="source device name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symcfg -output XML -sid (host) list -v</input>
[#else]
			<input>conf/vmax.sh symcfg -output XML -sid (host) list -v</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="TotalMemory" value="/SymCLI_ML/Symmetrix/Cache/megabytes" unit="MB">
			<property-set>symProperties</property-set>
		</value>
		<value name="TotalDisk" value="/SymCLI_ML/Symmetrix/Symm_Info/disks" unit="">
			<property-set>symProperties</property-set>
		</value>
		<value name="TotalHotSpare" value="/SymCLI_ML/Symmetrix/Symm_Info/hot_spares" unit="">
			<property-set>symProperties</property-set>
		</value>
		<value name="TotalLun" value="/SymCLI_ML/Symmetrix/Symm_Info/devices" unit="">
			<property-set>symProperties</property-set>
		</value>
		<value name="TotalUnconfiguredDisk" value="/SymCLI_ML/Symmetrix/Symm_Info/unconfigured_disks" unit="">
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-ARRAYS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="model" type="data" value="/SymCLI_ML/Symmetrix/Symm_Info/product_model"/>
			<property name="devdesc" type="data" value="concat(/SymCLI_ML/Symmetrix/Microcode/version, '.', /SymCLI_ML/Symmetrix/Microcode/patch_level)"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-BE-DIRECTORS" variable="source device partgrp parttype partid name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>Director</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symcfg -output XML -sid (host) list -da all</input>
[#else]
			<input>conf/vmax.sh symcfg -output XML -sid (host) list -da all</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="Availability" value="/Director/Dir_Info/status" unit="%">
			<replace value="Online" by="100"/>
			<replace value="Offline" by="0"/>
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-DIRECTORS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Controller"/>
			<property name="partgrp" type="hard-coded" value="Back-End"/>
			<property name="partid" type="data" value="../symbolic"/>
			<property name="part" type="data" value="../id"/>
			<property name="director" type="data" value="../id"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-FE-DIRECTORS" variable="source device partgrp parttype part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>Director</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symcfg -output XML -sid (host) list -sa all</input>
[#else]
			<input>conf/vmax.sh symcfg -output XML -sid (host) list -sa all</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="Availability" value="/Director/Dir_Info/status" unit="%">
			<replace value="Online" by="100"/>
			<replace value="Offline" by="0"/>
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="ip" type="host" value=""/>
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-DIRECTORS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Controller"/>
			<property name="partgrp" type="hard-coded" value="Front-End"/>
			<property name="partid" type="data" value="../symbolic"/>
			<property name="part" type="data" value="../id"/>
			<property name="director" type="data" value="../id"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-DISKS" variable="source device parttype part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>Disk</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symdisk -output XML -sid (host) list -da ALL -v</input>
[#else]
			<input>conf/vmax.sh symdisk -output XML -sid (host) list -da ALL -v</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="Capacity" value="/Disk/Disk_Info/actual_megabytes" unit="MB">
			<property-set>symProperties</property-set>
		</value>
		<value name="FreeCapacity" value="/Disk/Disk_Info/avail_megabytes" unit="MB">
			<property-set>symProperties</property-set>
		</value>
		<value name="Availability" value="/Disk/Disk_Info/failed_disk" unit="%">
			<replace value="False" by="100"/>
			<replace value="True" by="0"/>
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="datagrp" type="hard-coded" value="VMAX-DISKS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Disk"/>
			<property name="device" type="host" value=""/>
			<property name="part" type="data" value="concat(../ident, ':', ../interface, ' ', ../tid)"/>
			<property name="director" type="data" value="../ident"/>
			<property name="partvend" type="data" value="../vendor"/>
			<property name="partver" type="data" value="../revision"/>
			<property name="raidgrp" type="data" value="../hypers"/>
			<property name="dgname" type="data" value="../disk_group_name"/>
			<property name="diskgrp" type="data" value="../disk_group"/>
			<property name="diskrpm" type="data" value="../speed"/>
			<property name="partmode" type="data" value="../hot_spare">
				<replace value="True" by="Hot spare"/>
				<replace value="False" by="Assigned"/>
			</property>
			<property name="disktype" type="data" value="../technology">
				<replace value="FC" by="Fibre Channel"/>
				<replace value="SATA" by="SATA"/>
				<replace value="EFD" by="Flash Drive"/>
			</property>
			<property name="hypers" type="data" value="string-join(../../Hyper/number, ',')"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-DEVICES-THIN" variable="source device parttype part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symcfg -output XML -sid (host) list -tdev</input>
[#else]
			<input>conf/vmax.sh symcfg -output XML -sid (host) list -tdev</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="SubscribedCapacity" value="/SymCLI_ML/Symmetrix/total_enabled_mb" unit="MB">
			<property-set>systemProperties</property-set>
		</value>
		<value name="UserCapacity" value="/SymCLI_ML/Symmetrix/total_bound_mb" unit="MB">
			<property-set>systemProperties</property-set>
		</value>
		<value name="SubscribedCapacity" value="/SymCLI_ML/Symmetrix/ThinDevs/Device/total_tracks_mb" unit="MB">
			<property-set>thinProperties</property-set>
		</value>
		<value name="UserCapacity" value="/SymCLI_ML/Symmetrix/ThinDevs/Device/alloc_tracks_mb" unit="MB">
			<property-set>thinProperties</property-set>
		</value>
		<value name="ConsumedCapacity" value="/SymCLI_ML/Symmetrix/ThinDevs/Device/written_tracks_mb" unit="MB">
			<replace value="N/A" by="0"/>
			<property-set>thinProperties</property-set>
		</value>
		<property-set name="thinProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-DEVICES-THIN"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="LUN"/>
			<property name="part" value="../dev_name"/>
			<property name="poolname" value="../pool_name"/>
			<property name="poolemul" value="../dev_emul"/>
			<property name="dgstype" type="hard-coded" value="Thin"/>
		</property-set>
		<property-set name="systemProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-DEVICES-THIN"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="LUN"/>
			<property name="part" type="hard-coded" value="System"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-DEVICES-HYPER" variable="source device parttype part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>Device</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symdev -output XML -sid (host) list -v</input>
[#else]
			<input>conf/vmax.sh symdev -output XML -sid (host) list -v</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="Capacity" value="/Device/Flags[meta != 'Member']/../Capacity/megabytes" unit="MB">
			<property-set>Properties</property-set>
		</value>
		<value name="RAIDOverHead" value="/Device/Flags[meta != 'Member']/../Capacity/megabytes" unit="MB">
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" value="/Device/Dev_Info/service_state" unit="%">
			<replace value="Normal" by="100"/>
			<replace value="Degraded" by="0"/>
			<replace value="Failed" by="0"/>
			<replace value="N/A" by="0" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-DEVICES"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="LUN"/>
			<property name="part" value="../../Dev_Info/dev_name"/>
			<property name="pdname" value="../../Dev_Info/pd_name"/>
			<!-- example: /dev/sdv -->
			<property name="poolname" value="../../Dev_Info/thin_pool_name"/>
			<property name="partsn" value="../../Product/wwn"/>
			<property name="partconf" value="../../Flags/meta"/>
			<property name="config" value="../../RAID_Group_Information/Mirror_Info/raid_type"/>
			<property name="devconf" value="../../Dev_Info/configuration"/>
			<property name="hypercnt" value="count(../../RAID_Group_Information/Mirror_Info/Hyper_Devices/Hyper)"/>
			<property name="director" value="string-join(../../Front_End/Port/director,',')"/>
			<!-- to calculate RAID overhead -->
			<property name="roc1" value="substring(../../RAID_Group_Information/Mirror_Info/protection_level,1,1)"><!-- data disk count -->
				<replace value="" by="0"/>
			</property>
			<property name="roc2" value="substring-after(../../RAID_Group_Information/Mirror_Info/protection_level,'+')"><!-- parity disk count -->
				<replace value="" by="0"/>
			</property>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-PORTS" variable="source device parttype director part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>Director</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symcfg -output XML -sid (host) list -fa all -port</input>
[#else]
			<input>conf/vmax.sh symcfg -output XML -sid (host) list -fa all -port</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="Availability" value="/Director/Dir_Info/port0_conn_status" unit="%">
			<replace value="Yes" by="100"/>
			<replace value="No" by="0"/>
			<replace value="N/A" by="0"/>
			<property-set>port0Properties</property-set>
		</value>
		<value name="Availability" value="/Director/Dir_Info/port1_conn_status" unit="%">
			<replace value="Yes" by="100"/>
			<replace value="No" by="0"/>
			<replace value="N/A" by="0"/>
			<property-set>port1Properties</property-set>
		</value>
		<value name="Availability" value="/Director/Dir_Info/port2_conn_status" unit="%">
			<replace value="Yes" by="100"/>
			<replace value="No" by="0"/>
			<replace value="N/A" by="0"/>
			<property-set>port2Properties</property-set>
		</value>
		<value name="Availability" value="/Director/Dir_Info/port3_conn_status" unit="%">
			<replace value="Yes" by="100"/>
			<replace value="No" by="0"/>
			<replace value="N/A" by="0"/>
			<property-set>port3Properties</property-set>
		</value>
		<property-set name="port0Properties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-PORTS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Port"/>
			<property name="director" type="data" value="../id"/>
			<property name="part" type="hard-coded" value="0"/>
			<property name="partstat" type="data" value="../port0_status"/>
			<property name="nodewwn" type="data" value="../../Port/Port_Info[port='0']/node_wwn"/>
			<property name="portwwn" type="data" value="../../Port/Port_Info[port='0']/port_wwn"/>
			<property name="partgrp" type="hard-coded" value="Front-End"/>
		</property-set>
		<property-set name="port1Properties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-PORTS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Port"/>
			<property name="director" type="data" value="../id"/>
			<property name="part" type="hard-coded" value="1"/>
			<property name="partstat" type="data" value="../port1_status"/>
			<property name="nodewwn" type="data" value="../../Port/Port_Info[port='1']/node_wwn"/>
			<property name="portwwn" type="data" value="../../Port/Port_Info[port='1']/port_wwn"/>
			<property name="partgrp" type="hard-coded" value="Front-End"/>
		</property-set>
		<property-set name="port2Properties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-PORTS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Port"/>
			<property name="director" type="data" value="../id"/>
			<property name="part" type="hard-coded" value="2"/>
			<property name="partstat" type="data" value="../port2_status"/>
			<property name="nodewwn" type="data" value="../../Port/Port_Info[port='2']/node_wwn"/>
			<property name="portwwn" type="data" value="../../Port/Port_Info[port='2']/port_wwn"/>
			<property name="partgrp" type="hard-coded" value="Front-End"/>
		</property-set>
		<property-set name="port3Properties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-PORTS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Port"/>
			<property name="director" type="data" value="../id"/>
			<property name="part" type="hard-coded" value="3"/>
			<property name="partstat" type="data" value="../port3_status"/>
			<property name="nodewwn" type="data" value="../../Port/Port_Info[port='3']/node_wwn"/>
			<property name="portwwn" type="data" value="../../Port/Port_Info[port='3']/port_wwn"/>
			<property name="partgrp" type="hard-coded" value="Front-End"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-POOLS" variable="source device parttype dgname part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>Tier_Info</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symtier -output XML -sid (host) list -v</input>
[#else]
			<input>conf/vmax.sh symtier -output XML -sid (host) list -v</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="RemoveMe" value="/Tier_Info/Thin_Pool_Info/enabled_gb" unit="GB">
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-POOLS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Storage Pool"/>
			<property name="part" type="data" value="../pool_name"/>
			<property name="tiertype" type="data" value="../../tier_type"/>
			<!-- VP -->
			<property name="dgname" type="data" value="../../tier_name"/>
			<!-- Arch -->
			<property name="tiername" type="data" value="../../technology"/>
			<!-- SATA -->
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-POOLS-CAPACITY" variable="source device parttype part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>DevicePool</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symcfg -output XML -sid (host) list -pool</input>
[#else]
			<input>conf/vmax.sh symcfg -output XML -sid (host) list -pool</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="Capacity" value="/DevicePool/total_tracks_mb" unit="MB">
			<property-set>symProperties</property-set>
		</value>
		<value name="UsedCapacity" value="/DevicePool/total_used_tracks_mb" unit="MB">
			<property-set>symProperties</property-set>
		</value>
		<value name="FreeCapacity" value="/DevicePool/total_free_tracks_mb" unit="MB">
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-POOLS-CAPACITY"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Storage Pool"/>
			<property name="part" type="data" value="../pool_name"/>
			<property name="partstat" type="data" value="../pool_state"/>
			<property name="dgstype" type="data" value="../pool_type"/>
			<property name="poolemul" type="data" value="../dev_emulation"/>
			<property name="raidtype" type="data" value="../dev_config"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-POOLS-AVAILABILITY" variable="source device parttype part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>DevicePool</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symcfg -output XML -sid (host) list -pool -detail -v -thin</input>
[#else]
			<input>conf/vmax.sh symcfg -output XML -sid (host) list -pool -detail -v -thin</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="Availability" value="/DevicePool/pool_state" unit="%">
			<replace value="Enabled" by="100"/>
			<replace value="Disabled" by="0"/>
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-POOLS-AVAILABILITY"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Storage Pool"/>
			<property name="part" type="data" value="../pool_name"/>
			<property name="partstat" type="data" value="../pool_state"/>
			<property name="dgstype" type="data" value="../pool_type"/>
			<property name="poolemul" type="data" value="../dev_emulation"/>
			<property name="raidtype" type="data" value="../dev_config"/>
			<property name="devices" type="data" value="string-join(../SaveDev/dev_name, ',')"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-POOLS-SUBSCRIPTION" variable="source device parttype part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>DevicePool</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symcfg -output XML -sid (host) list -pool -detail -thin</input>
[#else]
			<input>conf/vmax.sh symcfg -output XML -sid (host) list -pool -detail -thin</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="Subscription" value="/DevicePool/subs_percent" unit="%">
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-POOLS-SUBSCRIPTION"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Storage Pool"/>
			<property name="part" type="data" value="../pool_name"/>
			<property name="partstat" type="data" value="../pool_state"/>
			<property name="dgstype" type="data" value="../pool_type"/>
			<property name="poolemul" type="data" value="../dev_emulation"/>
			<property name="raidtype" type="data" value="../dev_config"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-STORAGE-GROUPS" variable="source device parttype sgname part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>SG</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symsg -output XML -sid (host) list -v</input>
[#else]
			<input>conf/vmax.sh symsg -output XML -sid (host) list -v</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="RemoveMe" value="/SG/DEVS_List/Device/megabytes" unit="MB">
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-STORAGE-GROUPS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="LUN"/>
			<property name="part" type="data" value="../dev_name"/>
			<property name="sgname" type="data" value="../../../SG_Info/name"/>
			<!-- for enrichment -->
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-TIERS" variable="source device parttype part polname name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>Fast_Policy</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symfast -output XML -sid (host) list -association -demand</input>
[#else]
			<input>conf/vmax.sh symfast -output XML -sid (host) list -association -demand</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="TierCapacity" value="/Fast_Policy/Tier/tier_sg_limit" unit="GB">
			<property-set>symProperties</property-set>
		</value>
		<value name="TierUsedCapacity" value="/Fast_Policy/Tier/tier_sg_used" unit="GB">
			<property-set>symProperties</property-set>
		</value>
		<value name="TierGrowth" value="/Fast_Policy/Tier/tier_growth" unit="GB">
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-TIERS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Tier"/>
			<property name="part" type="data" value="../tier_name"/>
			<property name="tiername" type="data" value="../tier_name"/>
			<property name="tiertype" type="data" value="../tier_type"/>
			<property name="sgname" type="data" value="../../Policy_Info/storage_group_name"/>
			<property name="sgprio" type="data" value="../../Policy_Info/storage_group_priority">
				<replace value="1" by="Highest"/>
				<replace value="2" by="Medium"/>
				<replace value="3" by="Lowest"/>
			</property>
			<property name="polname" type="data" value="../../Policy_Info/policy_name"/>
			<property name="tiermax" type="data" value="../tier_max_sg_per"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-ACCESS" variable="source device parttype part initgrp name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>Masking_View</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symaccess -output XML -sid (host) list view -detail</input>
[#else]
			<input>conf/vmax.sh symaccess -output XML -sid (host) list view -detail</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="Capacity" value="/Masking_View/View_Info/Totals/total_dev_cap_mb" unit="MB">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-ACCESS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Access"/>
			<property name="part" type="data" value="../../view_name"/>
			<property name="initgrp" type="data" value="../../init_grpname"/>
			<property name="portgrp" type="data" value="../../port_grpname"/>
			<property name="director" type="data" value="../../port_info/Director_Identification/dir"/>
			<property name="dirnport" type="data" value="string-join(../../port_info/Director_Identification/concat(dir,':',port),'|')"/>
			<property name="port" type="data" value="../../port_info/Director_Identification/port"/>
			<property name="sgname" type="data" value="../../stor_grpname"/>
			<property name="devices" type="data" value="string-join(../../Device/dev_name,',')"/>
			<property name="partsn" type="data" value="string-join(../../Initiators/wwn,',')"/>
			<property name="partsngr" type="data" value="string-join(../../Initiators/group_name,',')"/>
		</property-set>
	</collecting-configuration>
</configuration>