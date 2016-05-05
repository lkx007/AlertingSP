<#if use_advancedsettings>
	<#assign pollingperiod = perf.pollingperiod>
<#else>
	<#assign pollingperiod = 300>
</#if>
<?xml version="1.0" encoding="utf-8"?>
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
<configuration xmlns="http://www.watch4net.com/XMLCollector" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/XMLCollector xmlcollector.xsd ">
	<simultaneous-collecting>3</simultaneous-collecting>
	<polling-interval>${pollingperiod}</polling-interval>
	<collecting-group>group</collecting-group>
	<source>VNXFile-Collector</source>
	<refresh>3600</refresh>
	<collecting-configuration id="ResourceUsage-VolumeStats" max-threads="1" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" variable="datagrp deviceid parttype partid moverid name">
		<data>
			<include-contexts>conf/context-file.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input type="string">https://(host)/servlets/CelerraManagementServices [P,FC]</input>
			<input type="string">https://(host)/Login?user=@fileurlusername&amp;password=@filepassword&amp;Login=Login [G,SC,CC]</input>
			<input type="string">https://(host)/servlets/CelerraManagementServices</input>
			<host>@csprimary</host>
			<host>@cssecondary</host>
			<parameter name="input-file">
				<value>conf/requests/ResourceUsage-VolumeStats.xml</value>
			</parameter>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="data-timeout">
				<value>120</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>120</value>
			</parameter>
			<parameter name="data-retry">
				<value>0</value>
			</parameter>
			<parameter name="connect-type">
				<value>any</value>
			</parameter>
			<parameter name="headers">
				<value>CelerraConnector-Ctl: ONE-TIME-REQUEST</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="CurrentUtilization" type="counter" unit="%" value="/ResponsePacket/Response/MoverResourceUsage/Sample/@mem">
			<property name="parttype" type="hard-coded" value="Memory" />
			<property name="part" type="hard-coded" value="RealMemory" />
			<property-set>Properties</property-set>
		</value>
		<value name="CurrentUtilization" type="counter" unit="%" value="/ResponsePacket/Response/MoverResourceUsage/Sample/@cpu">
			<property name="parttype" type="hard-coded" value="Processor" />
			<property name="part" type="hard-coded" value="Processor" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="ratep" unit="MB/s" value="/ResponsePacket/Response/VolumeSetStats/Sample/Totals/@bytesRead">
			<property-set>PropertiesVolumeStats</property-set>
		</value>
		<value name="WriteThroughput" type="ratep" unit="MB/s" value="/ResponsePacket/Response/VolumeSetStats/Sample/Totals/@bytesWritten">
			<property-set>PropertiesVolumeStats</property-set>
		</value>
		<value name="ReadRequests" type="ratep" unit="IOPS" value="/ResponsePacket/Response/VolumeSetStats/Sample/Totals/@reqsRead">
			<property-set>PropertiesVolumeStats</property-set>
		</value>
		<value name="WriteRequests" type="ratep" unit="IOPS" value="/ResponsePacket/Response/VolumeSetStats/Sample/Totals/@reqsWritten">
			<property-set>PropertiesVolumeStats</property-set>
		</value>
		<value name="ReadThroughput" type="ratep" unit="MB/s" value="/ResponsePacket/Response/VolumeSetStats/Sample/Item/@bytesRead">
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../@volume" />
			<property-set>PropertiesVolumeStats</property-set>
		</value>
		<value name="WriteThroughput" type="ratep" unit="MB/s" value="/ResponsePacket/Response/VolumeSetStats/Sample/Item/@bytesWritten">
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../@volume" />
			<property-set>PropertiesVolumeStats</property-set>
		</value>
		<value name="ReadRequests" type="ratep" unit="IOPS" value="/ResponsePacket/Response/VolumeSetStats/Sample/Item/@reqsRead">
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../@volume" />
			<property-set>PropertiesVolumeStats</property-set>
		</value>
		<value name="WriteRequests" type="ratep" unit="IOPS" value="/ResponsePacket/Response/VolumeSetStats/Sample/Item/@reqsWritten">
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../@volume" />
			<property-set>PropertiesVolumeStats</property-set>
		</value>
		<property-set name="Properties">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-ResourceUsage" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="moverid" type="data" value="../../@mover" />
		</property-set>
		<property-set name="PropertiesVolumeStats">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-VolumeStats" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="moverid" type="data" value="../../../@mover" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="Network-All-CIFS-State-NFS-All" max-threads="1" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" variable="datagrp deviceid parttype moverid ifname name">
		<data>
			<include-contexts>conf/context-file.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input type="string">https://(host)/servlets/CelerraManagementServices [P,FC]</input>
			<input type="string">https://(host)/Login?user=@fileurlusername&amp;password=@filepassword&amp;Login=Login [G,SC,CC]</input>
			<input type="string">https://(host)/servlets/CelerraManagementServices</input>
			<host>@csprimary</host>
			<host>@cssecondary</host>
			<parameter name="input-file">
				<value>conf/requests/Network-All-CIFS-State-NFS-All.xml</value>
			</parameter>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="data-timeout">
				<value>120</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>120</value>
			</parameter>
			<parameter name="data-retry">
				<value>0</value>
			</parameter>
			<parameter name="connect-type">
				<value>any</value>
			</parameter>
			<parameter name="headers">
				<value>CelerraConnector-Ctl: ONE-TIME-REQUEST</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="ifInOctets" type="ratep" unit="Octets/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/DeviceTraffic/@in">
			<property name="parttype" type="hard-coded" value="Interface" />
			<property name="part" type="data" value="../@device" />
			<property name="ifname" type="data" value="../@device" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="ratep" unit="Octets/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/DeviceTraffic/@out">
			<property name="parttype" type="hard-coded" value="Interface" />
			<property name="part" type="data" value="../@device" />
			<property name="ifname" type="data" value="../@device" />
			<property-set>Properties</property-set>
		</value>
		<value name="Sent" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Ip/@sent">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="IP" />
			<property-set>Properties</property-set>
		</value>
		<value name="Received" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Ip/@received">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="IP" />
			<property-set>Properties</property-set>
		</value>
		<value name="NotForwarded" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Ip/@notForw">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="IP" />
			<property-set>Properties</property-set>
		</value>
		<value name="Delivered" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Ip/@deliv">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="IP" />
			<property-set>Properties</property-set>
		</value>
		<value name="Sent" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Tcp/@sent">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="TCP" />
			<property-set>Properties</property-set>
		</value>
		<value name="Retransmit" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Tcp/@retransm">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="TCP" />
			<property-set>Properties</property-set>
		</value>
		<value name="Resets" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Tcp/@resets">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="TCP" />
			<property-set>Properties</property-set>
		</value>
		<value name="Received" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Tcp/@received">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="TCP" />
			<property-set>Properties</property-set>
		</value>
		<value name="ConnReq" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Tcp/@connReq">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="TCP" />
			<property-set>Properties</property-set>
		</value>
		<value name="ConnLing" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Tcp/@connLing">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="TCP" />
			<property-set>Properties</property-set>
		</value>
		<value name="Sent" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Udp/@sent">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="UDP" />
			<property-set>Properties</property-set>
		</value>
		<value name="IncompleteHdrs" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Udp/@incomplHdrs">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="UDP" />
			<property-set>Properties</property-set>
		</value>
		<value name="BadPorts" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Udp/@badPorts">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="UDP" />
			<property-set>Properties</property-set>
		</value>
		<value name="Delivered" type="ratep" unit="Pkts/s" value="/ResponsePacket/Response[@clientHandle='Network-All']/MoverNetStats/Sample/Udp/@deliv">
			<property name="parttype" type="hard-coded" value="TCP/IP" />
			<property name="part" type="hard-coded" value="UDP" />
			<property-set>Properties</property-set>
		</value>
		<value name="openConnections" type="counter" unit="Nb" value="/ResponsePacket/Response[@clientHandle='CIFS-State']/MoverCifsStats/Sample/State/@openConnections">
			<property name="parttype" type="hard-coded" value="DataMover" />
			<property name="part" type="hard-coded" value="CIFS" />
			<property-set>Properties</property-set>
		</value>
		<value name="openFiles" type="counter" unit="Nb" value="/ResponsePacket/Response[@clientHandle='CIFS-State']/MoverCifsStats/Sample/State/@openFiles">
			<property name="parttype" type="hard-coded" value="DataMover" />
			<property name="part" type="hard-coded" value="CIFS" />
			<property-set>Properties</property-set>
		</value>
		<value name="Write" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@write">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Wrcache" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@wrcache">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Symlink" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@symlink">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Setattr" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@setattr">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Root" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@root">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Rmdir" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@rmdir">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Remove" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@remove">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Readlink" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@readlink">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Readdir" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@readdir">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Read" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@read">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Null" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@null">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Mkdir" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@mkdir">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Lookup" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@lookup">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Link" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@link">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Getattr" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@getattr">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Fsstat" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@fsstat">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Create" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@create">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Write" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3write">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Symlink" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3symlink">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Setattr" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3setattr">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Rmdir" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3rmdir">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Rename" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3rename">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Remove" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3remove">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Readlink" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3readlink">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Readdirplus" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3readdirplus">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Readdir" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3readdir">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Read" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3read">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Pathconf" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3pathconf">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Null" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3null">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Mknod" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3mknod">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Mkdir" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3mkdir">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Lookup" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3lookup">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Link" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3link">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Getattr" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3getattr">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Fsstat" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3fsstat">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Fsinfo" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3fsinfo">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Create" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3create">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Commit" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3commit">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Access" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@v3access">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="NonExistent" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@nonExistent">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Misses" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@misses">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Hits" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@hits">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Adds" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@adds">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Resends" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@resends">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Dupl" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@dupl">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="Calls" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@calls">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="BadData" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@badData">
			<property-set>PropertiesNFS</property-set>
		</value>
		<value name="BadAuth" type="ratep" unit="" value="/ResponsePacket/Response[@clientHandle='NFS-All']/MoverNfsStats/Sample/*/@badAuth">
			<property-set>PropertiesNFS</property-set>
		</value>
		<property-set name="Properties">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Network-All-CIFS-State-NFS-All" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="moverid" type="data" value="../../../@mover" />
		</property-set>
		<property-set name="PropertiesNFS">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Network-All-CIFS-State-NFS-All" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="moverid" type="data" value="../../../@mover" />
			<property name="parttype" type="hard-coded" value="DataMover" />
			<property name="part" type="data" value="node-name(..)" />
		</property-set>
	</collecting-configuration>
</configuration>