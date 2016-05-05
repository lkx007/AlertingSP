<#if emcisilon.use_advancedsettings>
	<#assign pollingperiod = emcisilon.topology.pollingperiod>
<#else>
	<#assign pollingperiod = 900>
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
	<simultaneous-collecting>1</simultaneous-collecting>
	<polling-interval>${pollingperiod}</polling-interval>
	<collecting-group>group</collecting-group>
	<source>Isilon-Collector</source>
	<refresh>7200</refresh>
	<collecting-configuration id="ISILON2-CLUSTER-NODES" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host serialnb node name">
		<data>
			<include-contexts>conf/context-isilon.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input>(host)/platform/1/cluster/config [G]</input>
			<host>@url</host>
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
			<parameter name="preemptive-authentication">
				<value>true</value>
			</parameter>
			<parameter name="headers">
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<#-- No real metrics on nodes, so let's fake a OperationalStatus -->
		<value name="OperationalStatus" type="counter" unit="" value="/root/devices/devices/lnn">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="ISILON2-CLUSTER-NODES" />
			<property name="sstype" type="hard-coded" value="File" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="Isilon"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="device" type="data" value="../../../name" />
			<property name="nodeid" type="data" value="../devid" />
			<property name="node" type="data" value="../lnn" />
			<property name="serialnb" type="data" value="../../../guid" />
			<property name="devdesc" type="data" value="concat(../../../onefs_version/type, ' version ', ../../../onefs_version/release, ' build ', ../../../onefs_version/build)" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ISILON2-CLUSTER-METRICS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype part name">
		<data>
			<include-contexts>conf/context-isilon.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input>(host)/platform/1/statistics/current?key=ifs.bytes.free&amp;key=ifs.bytes.used&amp;key=ifs.bytes.total&amp;key=ifs.ssd.bytes.free&amp;key=ifs.ssd.bytes.used&amp;key=ifs.ssd.bytes.total [G]</input>
			<host>@url</host>
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
			<parameter name="preemptive-authentication">
				<value>true</value>
			</parameter>
			<parameter name="headers">
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="SSDCapacity" type="counter" unit="GB" value="/root/stats/stats[key='ifs.ssd.bytes.total']/value">
			<property name="parttype" type="hard-coded" value="Disk" />
			<property-set>Properties</property-set>
		</value>
		<value name="SSDFreeCapacity" type="counter" unit="GB" value="/root/stats/stats[key='ifs.ssd.bytes.free']/value">
			<property name="parttype" type="hard-coded" value="Disk" />
			<property-set>Properties</property-set>
		</value>
		<value name="SSDUsedCapacity" type="counter" unit="GB" value="/root/stats/stats[key='ifs.ssd.bytes.used']/value">
			<property name="parttype" type="hard-coded" value="Disk" />
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/root/stats/stats[key='ifs.bytes.total']/value">
			<property name="part" type="hard-coded" value="/ifs" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="FreeCapacity" type="counter" unit="GB" value="/root/stats/stats[key='ifs.bytes.free']/value">
			<property name="part" type="hard-coded" value="/ifs" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/root/stats/stats[key='ifs.bytes.used']/value">
			<property name="part" type="hard-coded" value="/ifs" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="ISILON2-CLUSTER-METRICS" />
			<property name="sstype" type="hard-coded" value="File" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="Isilon"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="FileServer" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ISILON2-NODE-METRICS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host nodeid parttype part name">
		<data>
			<include-contexts>conf/context-isilon.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input>(host)/platform/1/statistics/current?key=node.ifs.bytes.free&amp;key=node.ifs.bytes.used&amp;key=node.ifs.bytes.total&amp;key=node.ifs.ssd.bytes.free&amp;key=node.ifs.ssd.bytes.used&amp;key=node.ifs.ssd.bytes.total&amp;key=node.uptime&amp;key=node.health&amp;key=node.ifs.bytes.in&amp;&amp;key=node.ifs.bytes.out&amp;key=node.cpu.user.avg&amp;key=node.cpu.sys.avg&amp;key=node.cpu.idle.avg&amp;key=node.sysfs.root.bytes.used&amp;key=node.sysfs.root.bytes.free&amp;key=node.sysfs.root.bytes.total&amp;key=node.sysfs.root.percent.used&amp;key=node.sysfs.var.bytes.used&amp;key=node.sysfs.var.bytes.free&amp;key=node.sysfs.var.bytes.total&amp;key=node.sysfs.var.percent.used&amp;key=node.sysfs.varcrash.bytes.used&amp;key=node.sysfs.varcrash.bytes.free&amp;key=node.sysfs.varcrash.bytes.total&amp;key=node.sysfs.varcrash.percent.used&amp;devid=all [G]</input>
			<host>@url</host>
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
			<parameter name="preemptive-authentication">
				<value>true</value>
			</parameter>
			<parameter name="headers">
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="Uptime" type="counter" unit="s" value="/root/stats/stats[key='node.uptime']/value">
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.health']/value">
			<replace value="0" by="100" />
			<replace value="1" by="50" />
			<replace value="2" by="0" />
			<property-set>Properties</property-set>
		</value>
		<value name="SSDCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.ifs.ssd.bytes.total']/value">
			<property name="parttype" type="hard-coded" value="Disk" />
			<property-set>Properties</property-set>
		</value>
		<value name="SSDFreeCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.ifs.ssd.bytes.free']/value">
			<property name="parttype" type="hard-coded" value="Disk" />
			<property-set>Properties</property-set>
		</value>
		<value name="SSDUsedCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.ifs.ssd.bytes.used']/value">
			<property name="parttype" type="hard-coded" value="Disk" />
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/root/stats/stats[key='node.ifs.bytes.total']/value">
			<property name="part" type="hard-coded" value="/ifs" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="FreeCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.ifs.bytes.free']/value">
			<property name="part" type="hard-coded" value="/ifs" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.ifs.bytes.used']/value">
			<property name="part" type="hard-coded" value="/ifs" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/root/stats/stats[key='node.sysfs.root.bytes.total']/value">
			<property name="part" type="hard-coded" value="/root" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="FreeCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.sysfs.root.bytes.free']/value">
			<property name="part" type="hard-coded" value="/root" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.sysfs.root.bytes.used']/value">
			<property name="part" type="hard-coded" value="/root" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="CurrentUtilization" type="counter" unit="%" value="/root/stats/stats[key='node.sysfs.root.percent.used']/value">
			<property name="part" type="hard-coded" value="/root" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/root/stats/stats[key='node.sysfs.var.bytes.total']/value">
			<property name="part" type="hard-coded" value="/var" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="FreeCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.sysfs.var.bytes.free']/value">
			<property name="part" type="hard-coded" value="/var" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.sysfs.var.bytes.used']/value">
			<property name="part" type="hard-coded" value="/var" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="CurrentUtilization" type="counter" unit="%" value="/root/stats/stats[key='node.sysfs.var.percent.used']/value">
			<property name="part" type="hard-coded" value="/var" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/root/stats/stats[key='node.sysfs.varcrash.bytes.total']/value">
			<property name="part" type="hard-coded" value="/var/crash" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="FreeCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.sysfs.varcrash.bytes.free']/value">
			<property name="part" type="hard-coded" value="/var/crash" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.sysfs.varcrash.bytes.used']/value">
			<property name="part" type="hard-coded" value="/var/crash" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="CurrentUtilization" type="counter" unit="%" value="/root/stats/stats[key='node.sysfs.varcrash.percent.used']/value">
			<property name="part" type="hard-coded" value="/var/crash" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="ISILON2-CLUSTER-METRICS" />
			<property name="sstype" type="hard-coded" value="File" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="Isilon"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="nodeid" type="data" value="../devid" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ISILON2-NODE-DISK-METRICS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host nodeid parttype part name">
		<data>
			<include-contexts>conf/context-isilon.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input>(host)/platform/1/statistics/current?key=node.disk.name.0&amp;key=node.disk.name.1&amp;key=node.disk.name.2&amp;key=node.disk.name.3&amp;key=node.disk.name.4&amp;key=node.disk.name.5&amp;key=node.disk.name.6&amp;key=node.disk.name.7&amp;key=node.disk.name.8&amp;key=node.disk.name.9&amp;key=node.disk.name.10&amp;key=node.disk.name.11&amp;key=node.disk.name.12&amp;key=node.disk.name.13&amp;key=node.disk.name.14&amp;key=node.disk.name.15&amp;key=node.disk.name.16&amp;key=node.disk.name.17&amp;key=node.disk.name.18&amp;key=node.disk.name.19&amp;key=node.disk.name.20&amp;key=node.disk.name.21&amp;key=node.disk.name.22&amp;key=node.disk.name.23&amp;key=node.disk.name.24&amp;key=node.disk.name.25&amp;key=node.disk.name.26&amp;key=node.disk.name.27&amp;key=node.disk.name.28&amp;key=node.disk.name.29&amp;key=node.disk.name.30&amp;key=node.disk.name.31&amp;key=node.disk.name.32&amp;key=node.disk.name.33&amp;key=node.disk.name.34&amp;key=node.disk.name.35&amp;key=node.disk.name.36&amp;key=node.disk.name.37&amp;key=node.disk.name.38&amp;key=node.disk.name.39&amp;key=node.disk.name.40&amp;key=node.disk.name.41&amp;key=node.disk.name.42&amp;key=node.disk.name.43&amp;key=node.disk.name.44&amp;key=node.disk.name.45&amp;key=node.disk.name.46&amp;key=node.disk.name.47&amp;key=node.disk.name.48&amp;key=node.disk.name.49&amp;key=node.disk.name.50&amp;key=node.disk.name.51&amp;key=node.disk.name.52&amp;key=node.disk.name.53&amp;key=node.disk.name.54&amp;key=node.disk.name.55&amp;key=node.disk.name.56&amp;key=node.disk.name.57&amp;key=node.disk.name.58&amp;key=node.disk.name.59&amp;key=node.disk.health.0&amp;key=node.disk.health.1&amp;key=node.disk.health.2&amp;key=node.disk.health.3&amp;key=node.disk.health.4&amp;key=node.disk.health.5&amp;key=node.disk.health.6&amp;key=node.disk.health.7&amp;key=node.disk.health.8&amp;key=node.disk.health.9&amp;key=node.disk.health.10&amp;key=node.disk.health.11&amp;key=node.disk.health.12&amp;key=node.disk.health.13&amp;key=node.disk.health.14&amp;key=node.disk.health.15&amp;key=node.disk.health.16&amp;key=node.disk.health.17&amp;key=node.disk.health.18&amp;key=node.disk.health.19&amp;key=node.disk.health.20&amp;key=node.disk.health.21&amp;key=node.disk.health.22&amp;key=node.disk.health.23&amp;key=node.disk.health.24&amp;key=node.disk.health.25&amp;key=node.disk.health.26&amp;key=node.disk.health.27&amp;key=node.disk.health.28&amp;key=node.disk.health.29&amp;key=node.disk.health.30&amp;key=node.disk.health.31&amp;key=node.disk.health.32&amp;key=node.disk.health.33&amp;key=node.disk.health.34&amp;key=node.disk.health.35&amp;key=node.disk.health.36&amp;key=node.disk.health.37&amp;key=node.disk.health.38&amp;key=node.disk.health.39&amp;key=node.disk.health.40&amp;key=node.disk.health.41&amp;key=node.disk.health.42&amp;key=node.disk.health.43&amp;key=node.disk.health.44&amp;key=node.disk.health.45&amp;key=node.disk.health.46&amp;key=node.disk.health.47&amp;key=node.disk.health.48&amp;key=node.disk.health.49&amp;key=node.disk.health.50&amp;key=node.disk.health.51&amp;key=node.disk.health.52&amp;key=node.disk.health.53&amp;key=node.disk.health.54&amp;key=node.disk.health.55&amp;key=node.disk.health.56&amp;key=node.disk.health.57&amp;key=node.disk.health.58&amp;key=node.disk.health.59&amp;key=node.disk.ifs.bytes.total.0&amp;key=node.disk.ifs.bytes.total.1&amp;key=node.disk.ifs.bytes.total.2&amp;key=node.disk.ifs.bytes.total.3&amp;key=node.disk.ifs.bytes.total.4&amp;key=node.disk.ifs.bytes.total.5&amp;key=node.disk.ifs.bytes.total.6&amp;key=node.disk.ifs.bytes.total.7&amp;key=node.disk.ifs.bytes.total.8&amp;key=node.disk.ifs.bytes.total.9&amp;key=node.disk.ifs.bytes.total.10&amp;key=node.disk.ifs.bytes.total.11&amp;key=node.disk.ifs.bytes.total.12&amp;key=node.disk.ifs.bytes.total.13&amp;key=node.disk.ifs.bytes.total.14&amp;key=node.disk.ifs.bytes.total.15&amp;key=node.disk.ifs.bytes.total.16&amp;key=node.disk.ifs.bytes.total.17&amp;key=node.disk.ifs.bytes.total.18&amp;key=node.disk.ifs.bytes.total.19&amp;key=node.disk.ifs.bytes.total.20&amp;key=node.disk.ifs.bytes.total.21&amp;key=node.disk.ifs.bytes.total.22&amp;key=node.disk.ifs.bytes.total.23&amp;key=node.disk.ifs.bytes.total.24&amp;key=node.disk.ifs.bytes.total.25&amp;key=node.disk.ifs.bytes.total.26&amp;key=node.disk.ifs.bytes.total.27&amp;key=node.disk.ifs.bytes.total.28&amp;key=node.disk.ifs.bytes.total.29&amp;key=node.disk.ifs.bytes.total.30&amp;key=node.disk.ifs.bytes.total.31&amp;key=node.disk.ifs.bytes.total.32&amp;key=node.disk.ifs.bytes.total.33&amp;key=node.disk.ifs.bytes.total.34&amp;key=node.disk.ifs.bytes.total.35&amp;key=node.disk.ifs.bytes.total.36&amp;key=node.disk.ifs.bytes.total.37&amp;key=node.disk.ifs.bytes.total.38&amp;key=node.disk.ifs.bytes.total.39&amp;key=node.disk.ifs.bytes.total.40&amp;key=node.disk.ifs.bytes.total.41&amp;key=node.disk.ifs.bytes.total.42&amp;key=node.disk.ifs.bytes.total.43&amp;key=node.disk.ifs.bytes.total.44&amp;key=node.disk.ifs.bytes.total.45&amp;key=node.disk.ifs.bytes.total.46&amp;key=node.disk.ifs.bytes.total.47&amp;key=node.disk.ifs.bytes.total.48&amp;key=node.disk.ifs.bytes.total.49&amp;key=node.disk.ifs.bytes.total.50&amp;key=node.disk.ifs.bytes.total.51&amp;key=node.disk.ifs.bytes.total.52&amp;key=node.disk.ifs.bytes.total.53&amp;key=node.disk.ifs.bytes.total.54&amp;key=node.disk.ifs.bytes.total.55&amp;key=node.disk.ifs.bytes.total.56&amp;key=node.disk.ifs.bytes.total.57&amp;key=node.disk.ifs.bytes.total.58&amp;key=node.disk.ifs.bytes.total.59&amp;key=node.disk.type.0&amp;key=node.disk.type.1&amp;key=node.disk.type.2&amp;key=node.disk.type.3&amp;key=node.disk.type.4&amp;key=node.disk.type.5&amp;key=node.disk.type.6&amp;key=node.disk.type.7&amp;key=node.disk.type.8&amp;key=node.disk.type.9&amp;key=node.disk.type.10&amp;key=node.disk.type.11&amp;key=node.disk.type.12&amp;key=node.disk.type.13&amp;key=node.disk.type.14&amp;key=node.disk.type.15&amp;key=node.disk.type.16&amp;key=node.disk.type.17&amp;key=node.disk.type.18&amp;key=node.disk.type.19&amp;key=node.disk.type.20&amp;key=node.disk.type.21&amp;key=node.disk.type.22&amp;key=node.disk.type.23&amp;key=node.disk.type.24&amp;key=node.disk.type.25&amp;key=node.disk.type.26&amp;key=node.disk.type.27&amp;key=node.disk.type.28&amp;key=node.disk.type.29&amp;key=node.disk.type.30&amp;key=node.disk.type.31&amp;key=node.disk.type.32&amp;key=node.disk.type.33&amp;key=node.disk.type.34&amp;key=node.disk.type.35&amp;key=node.disk.type.36&amp;key=node.disk.type.37&amp;key=node.disk.type.38&amp;key=node.disk.type.39&amp;key=node.disk.type.40&amp;key=node.disk.type.41&amp;key=node.disk.type.42&amp;key=node.disk.type.43&amp;key=node.disk.type.44&amp;key=node.disk.type.45&amp;key=node.disk.type.46&amp;key=node.disk.type.47&amp;key=node.disk.type.48&amp;key=node.disk.type.49&amp;key=node.disk.type.50&amp;key=node.disk.type.51&amp;key=node.disk.type.52&amp;key=node.disk.type.53&amp;key=node.disk.type.54&amp;key=node.disk.type.55&amp;key=node.disk.type.56&amp;key=node.disk.type.57&amp;key=node.disk.type.58&amp;key=node.disk.type.59&amp;devid=all [G]</input>
			<host>@url</host>
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
			<parameter name="preemptive-authentication">
				<value>true</value>
			</parameter>
			<parameter name="headers">
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.0'][error_code!='1']/../stats[key='node.disk.health.0']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.0']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.0']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.1'][error_code!='1']/../stats[key='node.disk.health.1']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.1']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.1']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.2'][error_code!='1']/../stats[key='node.disk.health.2']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.2']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.2']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.3'][error_code!='1']/../stats[key='node.disk.health.3']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.3']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.3']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.4'][error_code!='1']/../stats[key='node.disk.health.4']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.4']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.4']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.5'][error_code!='1']/../stats[key='node.disk.health.5']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.5']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.5']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.6'][error_code!='1']/../stats[key='node.disk.health.6']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.6']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.6']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.7'][error_code!='1']/../stats[key='node.disk.health.7']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.7']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.7']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.8'][error_code!='1']/../stats[key='node.disk.health.8']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.8']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.8']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.9'][error_code!='1']/../stats[key='node.disk.health.9']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.9']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.9']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.10'][error_code!='1']/../stats[key='node.disk.health.10']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.10']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.10']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.11'][error_code!='1']/../stats[key='node.disk.health.11']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.11']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.11']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.12'][error_code!='1']/../stats[key='node.disk.health.12']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.12']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.12']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.13'][error_code!='1']/../stats[key='node.disk.health.13']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.13']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.13']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.14'][error_code!='1']/../stats[key='node.disk.health.14']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.14']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.14']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.15'][error_code!='1']/../stats[key='node.disk.health.15']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.15']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.15']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.16'][error_code!='1']/../stats[key='node.disk.health.16']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.16']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.16']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.17'][error_code!='1']/../stats[key='node.disk.health.17']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.17']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.17']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.18'][error_code!='1']/../stats[key='node.disk.health.18']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.18']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.18']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.19'][error_code!='1']/../stats[key='node.disk.health.19']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.19']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.19']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.20'][error_code!='1']/../stats[key='node.disk.health.20']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.20']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.20']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.21'][error_code!='1']/../stats[key='node.disk.health.21']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.21']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.21']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.22'][error_code!='1']/../stats[key='node.disk.health.22']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.22']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.22']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.23'][error_code!='1']/../stats[key='node.disk.health.23']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.23']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.23']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.24'][error_code!='1']/../stats[key='node.disk.health.24']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.24']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.24']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.25'][error_code!='1']/../stats[key='node.disk.health.25']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.25']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.25']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.26'][error_code!='1']/../stats[key='node.disk.health.26']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.26']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.26']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.27'][error_code!='1']/../stats[key='node.disk.health.27']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.27']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.27']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.28'][error_code!='1']/../stats[key='node.disk.health.28']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.28']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.28']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.29'][error_code!='1']/../stats[key='node.disk.health.29']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.29']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.29']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.30'][error_code!='1']/../stats[key='node.disk.health.30']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.30']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.30']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.31'][error_code!='1']/../stats[key='node.disk.health.31']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.31']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.31']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.32'][error_code!='1']/../stats[key='node.disk.health.32']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.32']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.32']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.33'][error_code!='1']/../stats[key='node.disk.health.33']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.33']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.33']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.34'][error_code!='1']/../stats[key='node.disk.health.34']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.34']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.34']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.35'][error_code!='1']/../stats[key='node.disk.health.35']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.35']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.35']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.36'][error_code!='1']/../stats[key='node.disk.health.36']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.36']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.36']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.37'][error_code!='1']/../stats[key='node.disk.health.37']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.37']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.37']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.38'][error_code!='1']/../stats[key='node.disk.health.38']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.38']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.38']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.39'][error_code!='1']/../stats[key='node.disk.health.39']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.39']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.39']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.40'][error_code!='1']/../stats[key='node.disk.health.40']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.40']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.40']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.41'][error_code!='1']/../stats[key='node.disk.health.41']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.41']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.41']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.42'][error_code!='1']/../stats[key='node.disk.health.42']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.42']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.42']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.43'][error_code!='1']/../stats[key='node.disk.health.43']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.43']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.43']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.44'][error_code!='1']/../stats[key='node.disk.health.44']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.44']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.44']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.45'][error_code!='1']/../stats[key='node.disk.health.45']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.45']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.45']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.46'][error_code!='1']/../stats[key='node.disk.health.46']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.46']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.46']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.47'][error_code!='1']/../stats[key='node.disk.health.47']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.47']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.47']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.48'][error_code!='1']/../stats[key='node.disk.health.48']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.48']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.48']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.49'][error_code!='1']/../stats[key='node.disk.health.49']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.49']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.49']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.50'][error_code!='1']/../stats[key='node.disk.health.50']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.50']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.50']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.51'][error_code!='1']/../stats[key='node.disk.health.51']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.51']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.51']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.52'][error_code!='1']/../stats[key='node.disk.health.52']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.52']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.52']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.53'][error_code!='1']/../stats[key='node.disk.health.53']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.53']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.53']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.54'][error_code!='1']/../stats[key='node.disk.health.54']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.54']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.54']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.55'][error_code!='1']/../stats[key='node.disk.health.55']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.55']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.55']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.56'][error_code!='1']/../stats[key='node.disk.health.56']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.56']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.56']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.57'][error_code!='1']/../stats[key='node.disk.health.57']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.57']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.57']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.58'][error_code!='1']/../stats[key='node.disk.health.58']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.58']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.58']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.59'][error_code!='1']/../stats[key='node.disk.health.59']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.59']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.59']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.60'][error_code!='1']/../stats[key='node.disk.health.60']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.60']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.60']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.61'][error_code!='1']/../stats[key='node.disk.health.61']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.61']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.61']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.62'][error_code!='1']/../stats[key='node.disk.health.62']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.62']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.62']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.63'][error_code!='1']/../stats[key='node.disk.health.63']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.63']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.63']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.64'][error_code!='1']/../stats[key='node.disk.health.64']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.64']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.64']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.65'][error_code!='1']/../stats[key='node.disk.health.65']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.65']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.65']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.66'][error_code!='1']/../stats[key='node.disk.health.66']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.66']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.66']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.67'][error_code!='1']/../stats[key='node.disk.health.67']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.67']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.67']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.68'][error_code!='1']/../stats[key='node.disk.health.68']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.68']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.68']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.disk.name.69'][error_code!='1']/../stats[key='node.disk.health.69']/value">
			<replace value="0" by="100" />
			<replace value="1" by="0" />
			<replace value="2" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.69']/value" />
			<property name="disktype" type="data" value="../../stats[key='node.disk.type.69']/value">
				<replace value="ssd" by="Enterprise Flash Drive" />
				<replace value="sata" by="SATA" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.0'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.0'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.0']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.1'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.1'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.1']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.2'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.2'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.2']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.3'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.3'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.3']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.4'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.4'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.4']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.5'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.5'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.5']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.6'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.6'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.6']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.7'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.7'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.7']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.8'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.8'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.8']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.9'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.9'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.9']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.10'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.10'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.10']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.11'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.11'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.11']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.12'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.12'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.12']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.13'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.13'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.13']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.14'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.14'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.14']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.15'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.15'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.15']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.16'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.16'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.16']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.17'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.17'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.17']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.18'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.18'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.18']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.19'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.19'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.19']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.20'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.20'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.20']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.21'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.21'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.21']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.22'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.22'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.22']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.23'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.23'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.23']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.24'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.24'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.24']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.25'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.25'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.25']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.26'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.26'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.26']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.27'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.27'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.27']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.28'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.28'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.28']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.29'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.29'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.29']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.30'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.30'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.30']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.31'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.31'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.31']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.32'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.32'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.32']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.33'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.33'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.33']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.34'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.34'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.34']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.35'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.35'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.35']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.36'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.36'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.36']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.37'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.37'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.37']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.38'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.38'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.38']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.39'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.39'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.39']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.40'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.40'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.40']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.41'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.41'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.41']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.42'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.42'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.42']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.43'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.43'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.43']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.44'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.44'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.44']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.45'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.45'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.45']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.46'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.46'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.46']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.47'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.47'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.47']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.48'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.48'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.48']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.49'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.49'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.49']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.50'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.50'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.50']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.51'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.51'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.51']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.52'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.52'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.52']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.53'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.53'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.53']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.54'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.54'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.54']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.55'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.55'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.55']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.56'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.56'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.56']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.57'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.57'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.57']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.58'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.58'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.58']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.59'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.59'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.59']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.60'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.60'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.60']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.61'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.61'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.61']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.62'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.62'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.62']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.63'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.63'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.63']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.64'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.64'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.64']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.65'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.65'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.65']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.66'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.66'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.66']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.67'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.67'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.67']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.68'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.68'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.68']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="RawCapacity" type="counter" unit="GB" value="/root/stats/stats[key='node.disk.name.69'][error_code!='1']/../stats[key='node.disk.ifs.bytes.total.69'][error!='value not representable']/value">
			<property name="part" type="data" value="../../stats[key='node.disk.name.69']/value" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="ISILON2-NODE-DISK-METRICS" />
			<property name="sstype" type="hard-coded" value="File" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="Isilon"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="Disk" />
			<property name="nodeid" type="data" value="../devid" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ISILON2-SNAPSHOTS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-isilon.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input>(host)/platform/1/snapshot/snapshots [G]</input>
			<host>@url</host>
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
			<parameter name="preemptive-authentication">
				<value>true</value>
			</parameter>
			<parameter name="headers">
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="Capacity" type="counter" unit="GB" value="/root/snapshots/snapshots/size">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="ISILON2-SNAPSHOTS" />
			<property name="sstype" type="hard-coded" value="File" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="Isilon"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="Snapshot" />
			<property name="part" type="data" value="../name" />
			<property name="partid" type="data" value="../id" />
			<property name="partdesc" type="data" value="../path" />
			<property name="module" type="data" value="../created" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ISILON2-QUOTAS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-isilon.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input>(host)/platform/1/quota/quotas [G]</input>
			<host>@url</host>
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
			<parameter name="preemptive-authentication">
				<value>true</value>
			</parameter>
			<parameter name="headers">
				<value>Content-Type: application/json</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="LogicalCapacity" type="counter" unit="GB" value="/root/quotas/quotas/usage/logical">
			<property-set>Properties</property-set>
		</value>
		<value name="PhysicalCapacity" type="counter" unit="GB" value="/root/quotas/quotas/usage/physical">
			<property-set>Properties</property-set>
		</value>
		<#-- HardThresholdCapacity and SoftThresholdCapacity are fake metrics at this point.  PEH will substitute the real value.  This is because of potential null values, and useless warning in logs of the xml collector -->
		<value name="HardThresholdCapacity" type="counter" unit="GB" value="/root/quotas/quotas/usage/physical">
			<property name="module" type="data" value="../../thresholds/hard">
				<replace value="" by="-1" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<value name="SoftThresholdCapacity" type="counter" unit="GB" value="/root/quotas/quotas/usage/physical">
			<property name="module" type="data" value="../../thresholds/soft">
				<replace value="" by="-1" />
			</property>
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="ISILON2-QUOTAS" />
			<property name="sstype" type="hard-coded" value="File" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="Isilon"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="Quota" />
			<property name="part" type="data" value="../../path | ../path" />
			<property name="partid" type="data" value="../../id | ../id" />
			<property name="partdesc" type="data" value="../../type | ../type" />
			<property name="qtasnap" type="data" value="../../include_snapshots | ../include_snapshots">
				<replace value="false" by="False" />
				<replace value="true" by="True" />
			</property>
		</property-set>
	</collecting-configuration>
</configuration>