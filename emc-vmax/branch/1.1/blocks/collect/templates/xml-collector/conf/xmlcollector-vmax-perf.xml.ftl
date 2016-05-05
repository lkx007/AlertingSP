[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<configuration xmlns="http://www.watch4net.com/XMLCollector" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/XMLCollector xmlcollector.xsd ">
	<simultaneous-collecting>3</simultaneous-collecting>
	<polling-interval>900</polling-interval>
	<collecting-group>group</collecting-group>
	<source>VMAX-Collector</source>
	<refresh>0</refresh>
	<collecting-configuration id="VMAX-DISKS-STATS" variable="source device parttype part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>Disk</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symstat -c 1 -i 300 -type disk -output XML -sid (host)</input>
[#else]
			<input>conf/vmax.sh symstat -c 1 -i 300 -type disk -output XML -sid (host)</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>300</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>300</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="ReadRequests" value="/Disk/r_per_second" unit="IOPS">
			<property-set>symProperties</property-set>
		</value>
		<value name="WriteRequests" value="/Disk/w_per_second" unit="IOPS">
			<property-set>symProperties</property-set>
		</value>
		<value name="ReadThroughput" value="/Disk/kb_r_per_second" unit="KB/s">
			<property-set>symProperties</property-set>
		</value>
		<value name="WriteThroughput" value="/Disk/kb_w_per_second" unit="KB/s">
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-DISKS-STATS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Disk"/>
			<!-- symstat disk name is not the same as other, so, yeah, that is life :) -->
			<property name="part" type="data" value="concat('DF-', translate(substring(../disk_name,1,1), '0',''), substring(../disk_name,2,4), ' ', upper-case(substring(../disk_name,6,1)))"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-PORTS-STATS" variable="source device parttype director part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>Port_Stats</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symstat -output XML -sid (host) -dir ALL -type port -c 1 -i 300</input>
[#else]
			<input>conf/vmax.sh symstat -output XML -sid (host) -dir ALL -type port -c 1 -i 300</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>300</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>300</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="IOPS" value="/Port_Stats/Director/io_per_sec" unit="">
			<property-set>symProperties</property-set>
		</value>
		<value name="TotalThroughput" value="/Port_Stats/Director/kb_per_sec" unit="KB/s">
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-PORTS-STATS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="parttype" type="hard-coded" value="Port"/>
			<property name="director" type="data" value="../id"/>
			<property name="part" type="data" value="../port"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-DEVICES-STATS" variable="source device parttype part name" timeout="900" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
		<for-each>Request</for-each>
		<data>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
			<input>conf/vmax.cmd symstat -type requests -c 1 -i 300 -output XML -sid (host)</input>
[#else]
			<input>conf/vmax.sh symstat -type requests -c 1 -i 300 -output XML -sid (host)</input>
[/#if]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
			<host>${serialnb?left_pad(12, "0")}</host>
[/#list]
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>300</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>300</value>
			</parameter>
		</data>
		<timestamp type="use-system-time"/>
		<value name="ReadRequests" value="/Request/r_per_second" unit="IOPS">
			<property-set>symProperties</property-set>
		</value>
		<value name="WriteRequests" value="/Request/w_per_second" unit="IOPS">
			<property-set>symProperties</property-set>
		</value>
		<value name="ReadThroughput" value="/Request/kb_r_per_second" unit="KB/s">
			<property-set>symProperties</property-set>
		</value>
		<value name="WriteThroughput" value="/Request/kb_w_per_second" unit="KB/s">
			<property-set>symProperties</property-set>
		</value>
		<value name="ReadCacheHits" value="/Request/r_cache_hit_pct" unit="%">
			<replace value="N/A" by="0"/>
			<property-set>symProperties</property-set>
		</value>
		<value name="WriteCacheHits" value="/Request/w_cache_hit_pct" unit="%">
			<replace value="N/A" by="0"/>
			<property-set>symProperties</property-set>
		</value>
		<value name="SequentialRead" value="/Request/sequential_r_pct" unit="%">
			<replace value="N/A" by="0"/>
			<property-set>symProperties</property-set>
		</value>
		<value name="Tracks" value="/Request/wp_tracks">
			<property-set>symProperties</property-set>
		</value>
		<property-set name="symProperties">
			<property name="device" type="host" value=""/>
			<property name="datagrp" type="hard-coded" value="VMAX-DEVICES-STATS"/>
			<property name="devtype" type="hard-coded" value="Array"/>
			<property name="part" type="data" value="../dev_name"/>
			<property name="parttype" type="hard-coded" value="LUN"/>
			<property name="pdname" value="../pd_name"/>
		</property-set>
	</collecting-configuration>
</configuration>