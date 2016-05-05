<#if use_advancedsettings>
	<#assign pollingperiod = perf.pollingperiod>
<#else>
	<#assign pollingperiod = 300>
</#if>
<?xml version="1.0" encoding="utf-8"?>
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
<configuration xmlns="http://www.watch4net.com/XMLCollector" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 	xsi:schemaLocation="http://www.watch4net.com/XMLCollector xmlcollector.xsd ">
	<simultaneous-collecting>2</simultaneous-collecting>
	<polling-interval>${pollingperiod}</polling-interval>
	<collecting-group>group</collecting-group>
	<source>VNXUnity-Collector</source>
	<refresh>3600</refresh>
	<collecting-configuration id="UNITY-STORAGEPROCESSOR-PERFORMANCE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype part name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/metricValue/instances?per_page=1&amp;compact=true&amp;orderby=timestamp%20desc&amp;filter=path%20eq%20sp.*.cpu.summary.utilization%20and%20interval%20eq%20300 [G]</input>
			<host>@host</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>120</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>120</value>
			</parameter>
			<parameter name="headers">
				<value>X-EMC-REST-CLIENT: true</value>
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="CurrentUtilization" type="counter" unit="%" value="/root/entries/entries/content/values/spa">
			<property name="part" type="hard-coded" value="SP A" />
			<property-set>Properties</property-set>
		</value>
		<value name="CurrentUtilization" type="counter" unit="%" value="/root/entries/entries/content/values/spb">
			<property name="part" type="hard-coded" value="SP B" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-STORAGEPROCESSOR-PERFORMANCE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Controller" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-DISK-PERFORMANCE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype sp crf name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/metricValue/instances?per_page=1&amp;compact=true&amp;orderby=timestamp%20desc&amp;filter=path%20eq%20sp.*.physical.disk%20and%20interval%20eq%20300 [G]</input>
			<host>@host</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>120</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>120</value>
			</parameter>
			<parameter name="headers">
				<value>X-EMC-REST-CLIENT: true</value>
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="WillBeReplaced" type="counter" unit="" value="/root/entries/entries/content/values/*/*">
			<property name="datagrp" type="hard-coded" value="UNITY-DISK-PERFORMANCE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Disk" />
			<property name="crf" type="data" value="concat('6', node-name(.))" />
			<property name="sp" type="data" value="node-name(..)" />
			<property name="name" type="data" value="../../../path">
				<replace value="sp.*.physical.disk.*.averageQueueLength" by="QueueLength" />
				<replace value="sp.*.physical.disk.*.readBytes" by="ReadThroughput" />
				<replace value="sp.*.physical.disk.*.reads" by="ReadRequests" />
				<replace value="sp.*.physical.disk.*.responseTime" by="ResponseTime" />
				<replace value="sp.*.physical.disk.*.serviceTime" by="ServiceTime" />
				<replace value="sp.*.physical.disk.*.totalCalls" by="TotalCalls" />
				<replace value="sp.*.physical.disk.*.writeBytes" by="WriteThroughput" />
				<replace value="sp.*.physical.disk.*.writes" by="WriteRequests" />
			</property>
		</value>
	</collecting-configuration>
	<collecting-configuration id="UNITY-LUN-PERFORMANCE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype crf name sp">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/metricValue/instances?per_page=1&amp;orderby=timestamp%20desc&amp;filter=path%20eq%20sp.*.storage.lun%20and%20interval%20eq%20300 [G]</input>
			<host>@host</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>120</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>120</value>
			</parameter>
			<parameter name="headers">
				<value>X-EMC-REST-CLIENT: true</value>
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="WillBeReplaced" type="counter" unit="" value="/root/entries/entries/content/values/*/*">
			<property name="datagrp" type="hard-coded" value="UNITY-LUN-PERFORMANCE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="LUN" />
			<property name="crf" type="data" value="concat('60', replace(string(node-name(.)), 'COLON', ''))" />
			<property name="sp" type="data" value="node-name(..)" />
			<property name="name" type="data" value="../../../path">
				<replace value="sp.*.storage.lun.*.avgReadSize" by="AvgReadSize" />
				<replace value="sp.*.storage.lun.*.avgWriteSize" by="AvgWriteSize" />
				<replace value="sp.*.storage.lun.*.queueLength" by="QueueLength" />
				<replace value="sp.*.storage.lun.*.readBytes" by="ReadThroughput" />
				<replace value="sp.*.storage.lun.*.reads" by="ReadRequests" />
				<replace value="sp.*.storage.lun.*.responseTime" by="ResponseTime" />
				<replace value="sp.*.storage.lun.*.totalCalls" by="TotalCalls" />
				<replace value="sp.*.storage.lun.*.writeBytes" by="WriteThroughput" />
				<replace value="sp.*.storage.lun.*.writes" by="WriteRequests" />
			</property>
		</value>
	</collecting-configuration>
	<collecting-configuration id="UNITY-NETDEVICE-PERFORMANCE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype sp name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/metricValue/instances?per_page=1&amp;compact=true&amp;orderby=timestamp%20desc&amp;filter=path%20eq%20sp.*.net.device%20and%20interval%20eq%20300 [G]</input>
			<host>@host</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>120</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>120</value>
			</parameter>
			<parameter name="headers">
				<value>X-EMC-REST-CLIENT: true</value>
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="WillBeReplaced" type="counter" unit="" value="/root/entries/entries/content/values/*/*">
			<property name="datagrp" type="hard-coded" value="UNITY-NETDEVICE-PERFORMANCE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Interface" />
			<property name="crf" type="data" value="node-name(.)" />
			<property name="sp" type="data" value="node-name(..)" />
			<property name="moverid" type="data" value="node-name(..)">
				<replace value="spa" by="SP A" />
				<replace value="spb" by="SP B" />
			</property>
			<property name="name" type="data" value="../../../path">
				<replace value="sp.*.net.device.*.bytesIn" by="ifInOctets" />
				<replace value="sp.*.net.device.*.bytesOut" by="ifOutOctets" />
				<replace value="sp.*.net.device.*.pktsIn" by="ifInPackets" />
				<replace value="sp.*.net.device.*.pktsOut" by="ifOutPackets" />
			</property>
		</value>
	</collecting-configuration>
	<!-- untested, since no simulator with fc ports... -->
	<collecting-configuration id="UNITY-FIBRECHANNELFEPORT-PERFORMANCE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype sp name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/metricValue/instances?per_page=1&amp;compact=true&amp;orderby=timestamp%20desc&amp;filter=path%20eq%20sp.*.fibreChannel.fePort%20and%20interval%20eq%20300 [G]</input>
			<host>@host</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>120</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>120</value>
			</parameter>
			<parameter name="headers">
				<value>X-EMC-REST-CLIENT: true</value>
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="WillBeReplaced" type="counter" unit="" value="/root/entries/entries/content/values/*/*">
			<property name="datagrp" type="hard-coded" value="UNITY-FIBRECHANNELFEPORT-PERFORMANCE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Port" />
			<property name="crf" type="data" value="node-name(.)" />
			<property name="sp" type="data" value="node-name(..)" />
			<property name="moverid" type="data" value="node-name(..)">
				<replace value="spa" by="SP A" />
				<replace value="spb" by="SP B" />
			</property>
			<property name="name" type="data" value="../../../path">
				<replace value="sp.*.fibreChannel.fePort.*.readBytes" by="ReadThroughput" />
				<replace value="sp.*.fibreChannel.fePort.*.writeBytes" by="WriteThroughput" />
				<replace value="sp.*.fibreChannel.fePort.*.reads" by="ReadRequests" />
				<replace value="sp.*.fibreChannel.fePort.*.writes" by="WriteRequests" />
			</property>
		</value>
	</collecting-configuration>
	<collecting-configuration id="UNITY-CIFSGLOBALNFS-PERFORMANCE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype part sp name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/metricValue/instances?per_page=1&amp;compact=true&amp;orderby=timestamp%20desc&amp;filter=path%20eq%20sp.*.cifs.global%20or%20path%20eq%20sp.*.nfs%20and%20interval%20eq%20300 [G]</input>
			<host>@host</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>120</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>120</value>
			</parameter>
			<parameter name="headers">
				<value>X-EMC-REST-CLIENT: true</value>
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="WillBeReplaced" type="counter" unit="" value="/root/entries/entries/content/values/*">
			<property name="datagrp" type="hard-coded" value="UNITY-CIFSGLOBALNFS-PERFORMANCE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Protocol" />
			<property name="part" type="data" value="substring(../../path, 1, 9)">
				<replace value="sp.*.cifs" by="CIFS" />
				<replace value="sp.*.nfs." by="NFS" />
			</property>
			<property name="sp" type="data" value="node-name(.)" />
			<property name="moverid" type="data" value="node-name(.)">
				<replace value="spa" by="SP A" />
				<replace value="spb" by="SP B" />
			</property>
			<property name="name" type="data" value="../../path">
				<replace value="sp.*.cifs.global.basic.readAvgSize" by="ReadAvgSize" />
				<replace value="sp.*.cifs.global.basic.readBytes" by="ReadThroughput" />
				<replace value="sp.*.cifs.global.basic.reads" by="ReadRequests" />
				<replace value="sp.*.cifs.global.basic.writeAvgSize" by="WriteAvgSize" />
				<replace value="sp.*.cifs.global.basic.writeBytes" by="WriteThroughput" />
				<replace value="sp.*.cifs.global.basic.writes" by="WriteRequests" />
				<replace value="sp.*.cifs.global.basic.totalCalls" by="TotalCalls" />
				<replace value="sp.*.cifs.global.usage.currentConnections" by="OpenConnections" />
				<replace value="sp.*.cifs.global.usage.currentOpenFiles" by="OpenFiles" />
				<replace value="sp.*.nfs.basic.readAvgSize" by="ReadAvgSize" />
				<replace value="sp.*.nfs.basic.readBytes" by="ReadThroughput" />
				<replace value="sp.*.nfs.basic.reads" by="ReadRequests" />
				<replace value="sp.*.nfs.basic.writeAvgSize" by="WriteAvgSize" />
				<replace value="sp.*.nfs.basic.writeBytes" by="WriteThroughput" />
				<replace value="sp.*.nfs.currentThreads" by="CurrentThreads" />
				<replace value="sp.*.nfs.totalCalls" by="TotalCalls" />
			</property>
		</value>
	</collecting-configuration>
	<collecting-configuration id="UNITY-FASTCACHE-PERFORMANCE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/metricValue/instances?per_page=1&amp;compact=true&amp;orderby=timestamp%20desc&amp;filter=path%20eq%20sp.*.fastCache.volume%20and%20interval%20eq%20300 [G]</input>
			<host>@host</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>120</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>120</value>
			</parameter>
			<parameter name="headers">
				<value>X-EMC-REST-CLIENT: true</value>
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="WillBeReplaced" type="counter" unit="" value="/root/entries/entries/content/values/*/*">
			<property name="datagrp" type="hard-coded" value="UNITY-FASTCACHE-PERFORMANCE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="FAST Cache" />
			<property name="part" type="hard-coded" value="FAST Cache" />
			<property name="sp" type="data" value="node-name(..)" />
			<property name="partid" type="data" value="node-name(..)" />
			<property name="moverid" type="data" value="node-name(..)">
				<replace value="spa" by="SP A" />
				<replace value="spb" by="SP B" />
			</property>
			<property name="name" type="data" value="../../../path">
				<replace value="sp.*.fastCache.volume.*.dirtyElements" by="DirtyElements" />
				<replace value="sp.*.fastCache.volume.*.validElements" by="ValidElements" />
			</property>
		</value>
	</collecting-configuration>
	<collecting-configuration id="UNITY-BLOCKCACHE-PERFORMANCE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/metricValue/instances?per_page=1&amp;compact=true&amp;orderby=timestamp%20desc&amp;filter=path%20eq%20sp.*.blockCache.global.summary%20and%20interval%20eq%20300 [G]</input>
			<host>@host</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>120</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>120</value>
			</parameter>
			<parameter name="headers">
				<value>X-EMC-REST-CLIENT: true</value>
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="WillBeReplaced" type="counter" unit="" value="/root/entries/entries/content/values/*">
			<property name="datagrp" type="hard-coded" value="UNITY-BLOCKCACHE-PERFORMANCE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="FAST Cache" />
			<property name="part" type="hard-coded" value="FAST Cache" />
			<property name="sp" type="data" value="node-name(.)" />
			<property name="partid" type="data" value="node-name(.)" />
			<property name="moverid" type="data" value="node-name(.)">
				<replace value="spa" by="SP A" />
				<replace value="spb" by="SP B" />
			</property>
			<property name="name" type="data" value="../../path">
				<replace value="sp.*.blockCache.global.summary.dirtyBytes" by="Dirty" />
				<replace value="sp.*.blockCache.global.summary.readHits" by="ReadHits" />
				<replace value="sp.*.blockCache.global.summary.readMisses" by="ReadMisses" />
				<replace value="sp.*.blockCache.global.summary.writeHits" by="WriteHits" />
				<replace value="sp.*.blockCache.global.summary.writeMisses" by="WriteMisses" />
			</property>
		</value>
	</collecting-configuration>
</configuration>