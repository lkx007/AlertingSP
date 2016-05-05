<#if emcisilon.use_advancedsettings>
	<#assign pollingperiod = emcisilon.perf.pollingperiod>
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
	<simultaneous-collecting>1</simultaneous-collecting>
	<polling-interval>${pollingperiod}</polling-interval>
	<collecting-group>group</collecting-group>
	<source>Isilon-Collector</source>
	<refresh>3600</refresh>
	<collecting-configuration id="ISILON2-CLUSTER-PERFORMANCE-METRICS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype name">
		<data>
			<include-contexts>conf/context-isilon.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input>(host)/platform/1/statistics/current?key=cluster.health&amp;key=ifs.bytes.in&amp;&amp;key=ifs.bytes.out&amp;key=ifs.ops.in&amp;key=ifs.ops.out [G]</input>
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
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='cluster.health']/value">
			<replace value="0" by="100" />
			<replace value="50" by="100" />
			<replace value="0" by="0" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="ratep" unit="MB/s" value="/root/stats/stats[key='ifs.bytes.out']/value">
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="ratep" unit="MB/s" value="/root/stats/stats[key='ifs.bytes.in']/value">
			<property-set>Properties</property-set>
		</value>
		<value name="ReadRequests" type="ratep" unit="IOPS" value="/root/stats/stats[key='ifs.ops.out']/value">
			<property-set>Properties</property-set>
		</value>
		<value name="WriteRequests" type="ratep" unit="IOPS" value="/root/stats/stats[key='ifs.ops.in']/value">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="ISILON2-CLUSTER-PERFORMANCE-METRICS" />
			<property name="sstype" type="hard-coded" value="File" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="Isilon"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="FileServer" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ISILON2-NODE-PERFORMANCE-METRICS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host nodeid parttype name">
		<data>
			<include-contexts>conf/context-isilon.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input>(host)/platform/1/statistics/current?key=node.ifs.bytes.in&amp;&amp;key=node.ifs.bytes.out&amp;key=node.cpu.user.avg&amp;key=node.cpu.sys.avg&amp;key=node.cpu.idle.avg&amp;devid=all [G]</input>
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
		<value name="ReadThroughput" type="ratep" unit="MB/s" value="/root/stats/stats[key='node.ifs.bytes.out']/value">
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="ratep" unit="MB/s" value="/root/stats/stats[key='node.ifs.bytes.in']/value">
			<property-set>Properties</property-set>
		</value>
		<value name="CurrentUtilization" type="counter" unit="%" value="/root/stats/stats[key='node.cpu.idle.avg']/value">
			<property name="part" type="hard-coded" value="Processor" />
			<property name="parttype" type="hard-coded" value="Processor" />
			<property-set>Properties</property-set>
		</value>
		<value name="User" type="counter" unit="%" value="/root/stats/stats[key='node.cpu.user.avg']/value">
			<property name="part" type="hard-coded" value="Processor" />
			<property name="parttype" type="hard-coded" value="Processor" />
			<property-set>Properties</property-set>
		</value>
		<value name="System" type="counter" unit="%" value="/root/stats/stats[key='node.cpu.sys.avg']/value">
			<property name="part" type="hard-coded" value="Processor" />
			<property name="parttype" type="hard-coded" value="Processor" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="ISILON2-NODE-PERFORMANCE-METRICS" />
			<property name="sstype" type="hard-coded" value="File" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="Isilon"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="nodeid" type="data" value="../devid" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ISILON2-NODE-NETWORK-PERFORMANCE-METRICS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host nodeid parttype part name">
		<data>
			<include-contexts>conf/context-isilon.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input>(host)/platform/1/statistics/current?key=node.net.iface.name.0&amp;key=node.net.iface.name.1&amp;key=node.net.iface.name.2&amp;key=node.net.iface.name.3&amp;key=node.net.iface.name.4&amp;key=node.net.iface.name.5&amp;key=node.net.iface.name.6&amp;key=node.net.iface.name.7&amp;key=node.net.iface.name.8&amp;key=node.net.iface.name.9&amp;key=node.net.iface.name.10&amp;key=node.net.iface.name.11&amp;key=node.net.iface.name.12&amp;key=node.net.iface.name.13&amp;key=node.net.iface.name.14&amp;key=node.net.iface.name.15&amp;key=node.net.iface.status.0&amp;key=node.net.iface.status.1&amp;key=node.net.iface.status.2&amp;key=node.net.iface.status.3&amp;key=node.net.iface.status.4&amp;key=node.net.iface.status.5&amp;key=node.net.iface.status.6&amp;key=node.net.iface.status.7&amp;key=node.net.iface.status.8&amp;key=node.net.iface.status.9&amp;key=node.net.iface.status.10&amp;key=node.net.iface.status.11&amp;key=node.net.iface.status.12&amp;key=node.net.iface.status.13&amp;key=node.net.iface.status.14&amp;key=node.net.iface.status.15&amp;key=node.net.iface.bytes.in.rate.0&amp;key=node.net.iface.bytes.in.rate.1&amp;key=node.net.iface.bytes.in.rate.2&amp;key=node.net.iface.bytes.in.rate.3&amp;key=node.net.iface.bytes.in.rate.4&amp;key=node.net.iface.bytes.in.rate.5&amp;key=node.net.iface.bytes.in.rate.6&amp;key=node.net.iface.bytes.in.rate.7&amp;key=node.net.iface.bytes.in.rate.8&amp;key=node.net.iface.bytes.in.rate.9&amp;key=node.net.iface.bytes.in.rate.10&amp;key=node.net.iface.bytes.in.rate.11&amp;key=node.net.iface.bytes.in.rate.12&amp;key=node.net.iface.bytes.in.rate.13&amp;key=node.net.iface.bytes.in.rate.14&amp;key=node.net.iface.bytes.in.rate.15&amp;key=node.net.iface.bytes.out.rate.0&amp;key=node.net.iface.bytes.out.rate.1&amp;key=node.net.iface.bytes.out.rate.2&amp;key=node.net.iface.bytes.out.rate.3&amp;key=node.net.iface.bytes.out.rate.4&amp;key=node.net.iface.bytes.out.rate.5&amp;key=node.net.iface.bytes.out.rate.6&amp;key=node.net.iface.bytes.out.rate.7&amp;key=node.net.iface.bytes.out.rate.8&amp;key=node.net.iface.bytes.out.rate.9&amp;key=node.net.iface.bytes.out.rate.10&amp;key=node.net.iface.bytes.out.rate.11&amp;key=node.net.iface.bytes.out.rate.12&amp;key=node.net.iface.bytes.out.rate.13&amp;key=node.net.iface.bytes.out.rate.14&amp;key=node.net.iface.bytes.out.rate.15&amp;key=node.net.iface.packets.in.rate.0&amp;key=node.net.iface.packets.in.rate.1&amp;key=node.net.iface.packets.in.rate.2&amp;key=node.net.iface.packets.in.rate.3&amp;key=node.net.iface.packets.in.rate.4&amp;key=node.net.iface.packets.in.rate.5&amp;key=node.net.iface.packets.in.rate.6&amp;key=node.net.iface.packets.in.rate.7&amp;key=node.net.iface.packets.in.rate.8&amp;key=node.net.iface.packets.in.rate.9&amp;key=node.net.iface.packets.in.rate.10&amp;key=node.net.iface.packets.in.rate.11&amp;key=node.net.iface.packets.in.rate.12&amp;key=node.net.iface.packets.in.rate.13&amp;key=node.net.iface.packets.in.rate.14&amp;key=node.net.iface.packets.in.rate.15&amp;key=node.net.iface.packets.out.rate.0&amp;key=node.net.iface.packets.out.rate.1&amp;key=node.net.iface.packets.out.rate.2&amp;key=node.net.iface.packets.out.rate.3&amp;key=node.net.iface.packets.out.rate.4&amp;key=node.net.iface.packets.out.rate.5&amp;key=node.net.iface.packets.out.rate.6&amp;key=node.net.iface.packets.out.rate.7&amp;key=node.net.iface.packets.out.rate.8&amp;key=node.net.iface.packets.out.rate.9&amp;key=node.net.iface.packets.out.rate.10&amp;key=node.net.iface.packets.out.rate.11&amp;key=node.net.iface.packets.out.rate.12&amp;key=node.net.iface.packets.out.rate.13&amp;key=node.net.iface.packets.out.rate.14&amp;key=node.net.iface.packets.out.rate.15&amp;key=node.net.iface.errors.in.rate.0&amp;key=node.net.iface.errors.in.rate.1&amp;key=node.net.iface.errors.in.rate.2&amp;key=node.net.iface.errors.in.rate.3&amp;key=node.net.iface.errors.in.rate.4&amp;key=node.net.iface.errors.in.rate.5&amp;key=node.net.iface.errors.in.rate.6&amp;key=node.net.iface.errors.in.rate.7&amp;key=node.net.iface.errors.in.rate.8&amp;key=node.net.iface.errors.in.rate.9&amp;key=node.net.iface.errors.in.rate.10&amp;key=node.net.iface.errors.in.rate.11&amp;key=node.net.iface.errors.in.rate.12&amp;key=node.net.iface.errors.in.rate.13&amp;key=node.net.iface.errors.in.rate.14&amp;key=node.net.iface.errors.in.rate.15&amp;key=node.net.iface.errors.out.rate.0&amp;key=node.net.iface.errors.out.rate.1&amp;key=node.net.iface.errors.out.rate.2&amp;key=node.net.iface.errors.out.rate.3&amp;key=node.net.iface.errors.out.rate.4&amp;key=node.net.iface.errors.out.rate.5&amp;key=node.net.iface.errors.out.rate.6&amp;key=node.net.iface.errors.out.rate.7&amp;key=node.net.iface.errors.out.rate.8&amp;key=node.net.iface.errors.out.rate.9&amp;key=node.net.iface.errors.out.rate.10&amp;key=node.net.iface.errors.out.rate.11&amp;key=node.net.iface.errors.out.rate.12&amp;key=node.net.iface.errors.out.rate.13&amp;key=node.net.iface.errors.out.rate.14&amp;key=node.net.iface.errors.out.rate.15&amp;devid=all [G]</input>
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
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.0'][error_code!='1']/../stats[key='node.net.iface.status.0']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.0']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.1'][error_code!='1']/../stats[key='node.net.iface.status.1']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.1']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.2'][error_code!='1']/../stats[key='node.net.iface.status.2']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.2']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.3'][error_code!='1']/../stats[key='node.net.iface.status.3']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.3']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.4'][error_code!='1']/../stats[key='node.net.iface.status.4']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.4']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.5'][error_code!='1']/../stats[key='node.net.iface.status.5']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.5']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.6'][error_code!='1']/../stats[key='node.net.iface.status.6']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.6']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.7'][error_code!='1']/../stats[key='node.net.iface.status.7']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.7']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.8'][error_code!='1']/../stats[key='node.net.iface.status.8']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.8']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.9'][error_code!='1']/../stats[key='node.net.iface.status.9']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.9']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.10'][error_code!='1']/../stats[key='node.net.iface.status.10']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.10']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.11'][error_code!='1']/../stats[key='node.net.iface.status.11']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.11']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.12'][error_code!='1']/../stats[key='node.net.iface.status.12']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.12']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.13'][error_code!='1']/../stats[key='node.net.iface.status.13']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.13']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.14'][error_code!='1']/../stats[key='node.net.iface.status.14']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.14']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="Availability" type="counter" unit="%" value="/root/stats/stats[key='node.net.iface.name.15'][error_code!='1']/../stats[key='node.net.iface.status.15']/value">
			<replace value="3" by="100" />
			<replace value="2" by="50" />
			<replace value="1" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.15']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.0'][value='3']/../stats[key='node.net.iface.bytes.in.rate.0']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.0']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.1'][value='3']/../stats[key='node.net.iface.bytes.in.rate.1']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.1']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.2'][value='3']/../stats[key='node.net.iface.bytes.in.rate.2']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.2']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.3'][value='3']/../stats[key='node.net.iface.bytes.in.rate.3']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.3']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.4'][value='3']/../stats[key='node.net.iface.bytes.in.rate.4']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.4']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.5'][value='3']/../stats[key='node.net.iface.bytes.in.rate.5']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.5']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.6'][value='3']/../stats[key='node.net.iface.bytes.in.rate.6']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.6']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.7'][value='3']/../stats[key='node.net.iface.bytes.in.rate.7']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.7']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.8'][value='3']/../stats[key='node.net.iface.bytes.in.rate.8']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.8']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.9'][value='3']/../stats[key='node.net.iface.bytes.in.rate.9']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.9']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.10'][value='3']/../stats[key='node.net.iface.bytes.in.rate.10']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.10']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.11'][value='3']/../stats[key='node.net.iface.bytes.in.rate.11']/value">
			<replace value="" by="0" />
			<property name="parttype" type="hard-coded" value="Interface" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.12'][value='3']/../stats[key='node.net.iface.bytes.in.rate.12']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.12']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.13'][value='3']/../stats[key='node.net.iface.bytes.in.rate.13']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.13']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.14'][value='3']/../stats[key='node.net.iface.bytes.in.rate.14']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.status.14']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.15'][value='3']/../stats[key='node.net.iface.bytes.in.rate.15']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.15']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.0'][value='3']/../stats[key='node.net.iface.bytes.out.rate.0']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.0']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.1'][value='3']/../stats[key='node.net.iface.bytes.out.rate.1']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.1']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.2'][value='3']/../stats[key='node.net.iface.bytes.out.rate.2']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.2']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.3'][value='3']/../stats[key='node.net.iface.bytes.out.rate.3']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.3']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.4'][value='3']/../stats[key='node.net.iface.bytes.out.rate.4']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.4']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.5'][value='3']/../stats[key='node.net.iface.bytes.out.rate.5']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.5']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.6'][value='3']/../stats[key='node.net.iface.bytes.out.rate.6']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.6']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.7'][value='3']/../stats[key='node.net.iface.bytes.out.rate.7']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.7']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.8'][value='3']/../stats[key='node.net.iface.bytes.out.rate.8']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.8']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.9'][value='3']/../stats[key='node.net.iface.bytes.out.rate.9']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.9']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.10'][value='3']/../stats[key='node.net.iface.bytes.out.rate.10']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.10']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.11'][value='3']/../stats[key='node.net.iface.bytes.out.rate.11']/value">
			<replace value="" by="0" />
			<property name="parttype" type="hard-coded" value="Interface" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.12'][value='3']/../stats[key='node.net.iface.bytes.out.rate.12']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.12']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.13'][value='3']/../stats[key='node.net.iface.bytes.out.rate.13']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.13']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.14'][value='3']/../stats[key='node.net.iface.bytes.out.rate.14']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.14']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutOctets" type="counter" unit="Octets/s" value="/root/stats/stats[key='node.net.iface.status.15'][value='3']/../stats[key='node.net.iface.bytes.out.rate.15']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.15']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.0'][value='3']/../stats[key='node.net.iface.packets.in.rate.0']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.0']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.1'][value='3']/../stats[key='node.net.iface.packets.in.rate.1']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.1']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.2'][value='3']/../stats[key='node.net.iface.packets.in.rate.2']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.2']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.3'][value='3']/../stats[key='node.net.iface.packets.in.rate.3']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.3']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.4'][value='3']/../stats[key='node.net.iface.packets.in.rate.4']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.4']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.5'][value='3']/../stats[key='node.net.iface.packets.in.rate.5']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.5']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.6'][value='3']/../stats[key='node.net.iface.packets.in.rate.6']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.6']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.7'][value='3']/../stats[key='node.net.iface.packets.in.rate.7']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.7']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.8'][value='3']/../stats[key='node.net.iface.packets.in.rate.8']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.8']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.9'][value='3']/../stats[key='node.net.iface.packets.in.rate.9']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.9']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.10'][value='3']/../stats[key='node.net.iface.packets.in.rate.10']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.10']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.11'][value='3']/../stats[key='node.net.iface.packets.in.rate.11']/value">
			<replace value="" by="0" />
			<property name="parttype" type="hard-coded" value="Interface" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.12'][value='3']/../stats[key='node.net.iface.packets.in.rate.12']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.12']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.13'][value='3']/../stats[key='node.net.iface.packets.in.rate.13']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.13']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.14'][value='3']/../stats[key='node.net.iface.packets.in.rate.14']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.14']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.15'][value='3']/../stats[key='node.net.iface.packets.in.rate.15']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.15']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.0'][value='3']/../stats[key='node.net.iface.packets.out.rate.0']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.0']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.1'][value='3']/../stats[key='node.net.iface.packets.out.rate.1']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.1']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.2'][value='3']/../stats[key='node.net.iface.packets.out.rate.2']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.2']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.3'][value='3']/../stats[key='node.net.iface.packets.out.rate.3']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.3']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.4'][value='3']/../stats[key='node.net.iface.packets.out.rate.4']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.4']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.5'][value='3']/../stats[key='node.net.iface.packets.out.rate.5']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.5']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.6'][value='3']/../stats[key='node.net.iface.packets.out.rate.6']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.6']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.7'][value='3']/../stats[key='node.net.iface.packets.out.rate.7']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.7']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.8'][value='3']/../stats[key='node.net.iface.packets.out.rate.8']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.8']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.9'][value='3']/../stats[key='node.net.iface.packets.out.rate.9']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.9']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.10'][value='3']/../stats[key='node.net.iface.packets.out.rate.10']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.10']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.11'][value='3']/../stats[key='node.net.iface.packets.out.rate.11']/value">
			<replace value="" by="0" />
			<property name="parttype" type="hard-coded" value="Interface" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.12'][value='3']/../stats[key='node.net.iface.packets.out.rate.12']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.12']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.13'][value='3']/../stats[key='node.net.iface.packets.out.rate.13']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.13']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.14'][value='3']/../stats[key='node.net.iface.packets.out.rate.14']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.14']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutPkts" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.15'][value='3']/../stats[key='node.net.iface.packets.out.rate.15']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.15']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.0'][value='3']/../stats[key='node.net.iface.errors.in.rate.0']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.0']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.1'][value='3']/../stats[key='node.net.iface.errors.in.rate.1']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.1']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.2'][value='3']/../stats[key='node.net.iface.errors.in.rate.2']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.2']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.3'][value='3']/../stats[key='node.net.iface.errors.in.rate.3']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.3']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.4'][value='3']/../stats[key='node.net.iface.errors.in.rate.4']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.4']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.5'][value='3']/../stats[key='node.net.iface.errors.in.rate.5']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.5']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.6'][value='3']/../stats[key='node.net.iface.errors.in.rate.6']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.6']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.7'][value='3']/../stats[key='node.net.iface.errors.in.rate.7']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.7']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.8'][value='3']/../stats[key='node.net.iface.errors.in.rate.8']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.8']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.9'][value='3']/../stats[key='node.net.iface.errors.in.rate.9']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.9']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.10'][value='3']/../stats[key='node.net.iface.errors.in.rate.10']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.10']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.11'][value='3']/../stats[key='node.net.iface.errors.in.rate.11']/value">
			<replace value="" by="0" />
			<property name="parttype" type="hard-coded" value="Interface" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.12'][value='3']/../stats[key='node.net.iface.errors.in.rate.12']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.12']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.13'][value='3']/../stats[key='node.net.iface.errors.in.rate.13']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.13']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.14'][value='3']/../stats[key='node.net.iface.errors.in.rate.14']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.14']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifInErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.15'][value='3']/../stats[key='node.net.iface.errors.in.rate.15']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.15']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.0'][value='3']/../stats[key='node.net.iface.errors.out.rate.0']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.0']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.1'][value='3']/../stats[key='node.net.iface.errors.out.rate.1']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.1']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.2'][value='3']/../stats[key='node.net.iface.errors.out.rate.2']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.2']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.3'][value='3']/../stats[key='node.net.iface.errors.out.rate.3']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.3']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.4'][value='3']/../stats[key='node.net.iface.errors.out.rate.4']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.4']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.5'][value='3']/../stats[key='node.net.iface.errors.out.rate.5']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.5']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.6'][value='3']/../stats[key='node.net.iface.errors.out.rate.6']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.6']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.7'][value='3']/../stats[key='node.net.iface.errors.out.rate.7']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.7']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.8'][value='3']/../stats[key='node.net.iface.errors.out.rate.8']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.8']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.9'][value='3']/../stats[key='node.net.iface.errors.out.rate.9']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.9']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.10'][value='3']/../stats[key='node.net.iface.errors.out.rate.10']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.10']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.11'][value='3']/../stats[key='node.net.iface.errors.out.rate.11']/value">
			<replace value="" by="0" />
			<property name="parttype" type="hard-coded" value="Interface" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.12'][value='3']/../stats[key='node.net.iface.errors.out.rate.12']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.12']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.13'][value='3']/../stats[key='node.net.iface.errors.out.rate.13']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.13']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.14'][value='3']/../stats[key='node.net.iface.errors.out.rate.14']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.14']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ifOutErrors" type="counter" unit="Pkts/s" value="/root/stats/stats[key='node.net.iface.status.15'][value='3']/../stats[key='node.net.iface.errors.out.rate.15']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.net.iface.name.15']/value" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="ISILON2-NODE-NETWORK-PERFORMANCE-METRICS" />
			<property name="sstype" type="hard-coded" value="File" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="Isilon"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="Interface" />
			<property name="nodeid" type="data" value="../devid" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ISILON2-NODE-DISK-PERFORMANCE-METRICS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host nodeid parttype part name">
		<data>
			<include-contexts>conf/context-isilon.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input>(host)/platform/1/statistics/current?key=node.disk.name.0&amp;key=node.disk.name.1&amp;key=node.disk.name.2&amp;key=node.disk.name.3&amp;key=node.disk.name.4&amp;key=node.disk.name.5&amp;key=node.disk.name.6&amp;key=node.disk.name.7&amp;key=node.disk.name.8&amp;key=node.disk.name.9&amp;key=node.disk.name.10&amp;key=node.disk.name.11&amp;key=node.disk.name.12&amp;key=node.disk.name.13&amp;key=node.disk.name.14&amp;key=node.disk.name.15&amp;key=node.disk.name.16&amp;key=node.disk.name.17&amp;key=node.disk.name.18&amp;key=node.disk.name.19&amp;key=node.disk.name.20&amp;key=node.disk.name.21&amp;key=node.disk.name.22&amp;key=node.disk.name.23&amp;key=node.disk.name.24&amp;key=node.disk.name.25&amp;key=node.disk.name.26&amp;key=node.disk.name.27&amp;key=node.disk.name.28&amp;key=node.disk.name.29&amp;key=node.disk.name.30&amp;key=node.disk.name.31&amp;key=node.disk.name.32&amp;key=node.disk.name.33&amp;key=node.disk.name.34&amp;key=node.disk.name.35&amp;key=node.disk.name.36&amp;key=node.disk.name.37&amp;key=node.disk.name.38&amp;key=node.disk.name.39&amp;key=node.disk.name.40&amp;key=node.disk.name.41&amp;key=node.disk.name.42&amp;key=node.disk.name.43&amp;key=node.disk.name.44&amp;key=node.disk.name.45&amp;key=node.disk.name.46&amp;key=node.disk.name.47&amp;key=node.disk.name.48&amp;key=node.disk.name.49&amp;key=node.disk.name.50&amp;key=node.disk.name.51&amp;key=node.disk.name.52&amp;key=node.disk.name.53&amp;key=node.disk.name.54&amp;key=node.disk.name.55&amp;key=node.disk.name.56&amp;key=node.disk.name.57&amp;key=node.disk.name.58&amp;key=node.disk.name.59&amp;key=node.disk.bytes.in.rate.0&amp;key=node.disk.bytes.in.rate.1&amp;key=node.disk.bytes.in.rate.2&amp;key=node.disk.bytes.in.rate.3&amp;key=node.disk.bytes.in.rate.4&amp;key=node.disk.bytes.in.rate.5&amp;key=node.disk.bytes.in.rate.6&amp;key=node.disk.bytes.in.rate.7&amp;key=node.disk.bytes.in.rate.8&amp;key=node.disk.bytes.in.rate.9&amp;key=node.disk.bytes.in.rate.10&amp;key=node.disk.bytes.in.rate.11&amp;key=node.disk.bytes.in.rate.12&amp;key=node.disk.bytes.in.rate.13&amp;key=node.disk.bytes.in.rate.14&amp;key=node.disk.bytes.in.rate.15&amp;key=node.disk.bytes.in.rate.16&amp;key=node.disk.bytes.in.rate.17&amp;key=node.disk.bytes.in.rate.18&amp;key=node.disk.bytes.in.rate.19&amp;key=node.disk.bytes.in.rate.20&amp;key=node.disk.bytes.in.rate.21&amp;key=node.disk.bytes.in.rate.22&amp;key=node.disk.bytes.in.rate.23&amp;key=node.disk.bytes.in.rate.24&amp;key=node.disk.bytes.in.rate.25&amp;key=node.disk.bytes.in.rate.26&amp;key=node.disk.bytes.in.rate.27&amp;key=node.disk.bytes.in.rate.28&amp;key=node.disk.bytes.in.rate.29&amp;key=node.disk.bytes.in.rate.30&amp;key=node.disk.bytes.in.rate.31&amp;key=node.disk.bytes.in.rate.32&amp;key=node.disk.bytes.in.rate.33&amp;key=node.disk.bytes.in.rate.34&amp;key=node.disk.bytes.in.rate.35&amp;key=node.disk.bytes.in.rate.36&amp;key=node.disk.bytes.in.rate.37&amp;key=node.disk.bytes.in.rate.38&amp;key=node.disk.bytes.in.rate.39&amp;key=node.disk.bytes.in.rate.40&amp;key=node.disk.bytes.in.rate.41&amp;key=node.disk.bytes.in.rate.42&amp;key=node.disk.bytes.in.rate.43&amp;key=node.disk.bytes.in.rate.44&amp;key=node.disk.bytes.in.rate.45&amp;key=node.disk.bytes.in.rate.46&amp;key=node.disk.bytes.in.rate.47&amp;key=node.disk.bytes.in.rate.48&amp;key=node.disk.bytes.in.rate.49&amp;key=node.disk.bytes.in.rate.50&amp;key=node.disk.bytes.in.rate.51&amp;key=node.disk.bytes.in.rate.52&amp;key=node.disk.bytes.in.rate.53&amp;key=node.disk.bytes.in.rate.54&amp;key=node.disk.bytes.in.rate.55&amp;key=node.disk.bytes.in.rate.56&amp;key=node.disk.bytes.in.rate.57&amp;key=node.disk.bytes.in.rate.58&amp;key=node.disk.bytes.in.rate.59&amp;key=node.disk.bytes.out.rate.0&amp;key=node.disk.bytes.out.rate.1&amp;key=node.disk.bytes.out.rate.2&amp;key=node.disk.bytes.out.rate.3&amp;key=node.disk.bytes.out.rate.4&amp;key=node.disk.bytes.out.rate.5&amp;key=node.disk.bytes.out.rate.6&amp;key=node.disk.bytes.out.rate.7&amp;key=node.disk.bytes.out.rate.8&amp;key=node.disk.bytes.out.rate.9&amp;key=node.disk.bytes.out.rate.10&amp;key=node.disk.bytes.out.rate.11&amp;key=node.disk.bytes.out.rate.12&amp;key=node.disk.bytes.out.rate.13&amp;key=node.disk.bytes.out.rate.14&amp;key=node.disk.bytes.out.rate.15&amp;key=node.disk.bytes.out.rate.16&amp;key=node.disk.bytes.out.rate.17&amp;key=node.disk.bytes.out.rate.18&amp;key=node.disk.bytes.out.rate.19&amp;key=node.disk.bytes.out.rate.20&amp;key=node.disk.bytes.out.rate.21&amp;key=node.disk.bytes.out.rate.22&amp;key=node.disk.bytes.out.rate.23&amp;key=node.disk.bytes.out.rate.24&amp;key=node.disk.bytes.out.rate.25&amp;key=node.disk.bytes.out.rate.26&amp;key=node.disk.bytes.out.rate.27&amp;key=node.disk.bytes.out.rate.28&amp;key=node.disk.bytes.out.rate.29&amp;key=node.disk.bytes.out.rate.30&amp;key=node.disk.bytes.out.rate.31&amp;key=node.disk.bytes.out.rate.32&amp;key=node.disk.bytes.out.rate.33&amp;key=node.disk.bytes.out.rate.34&amp;key=node.disk.bytes.out.rate.35&amp;key=node.disk.bytes.out.rate.36&amp;key=node.disk.bytes.out.rate.37&amp;key=node.disk.bytes.out.rate.38&amp;key=node.disk.bytes.out.rate.39&amp;key=node.disk.bytes.out.rate.40&amp;key=node.disk.bytes.out.rate.41&amp;key=node.disk.bytes.out.rate.42&amp;key=node.disk.bytes.out.rate.43&amp;key=node.disk.bytes.out.rate.44&amp;key=node.disk.bytes.out.rate.45&amp;key=node.disk.bytes.out.rate.46&amp;key=node.disk.bytes.out.rate.47&amp;key=node.disk.bytes.out.rate.48&amp;key=node.disk.bytes.out.rate.49&amp;key=node.disk.bytes.out.rate.50&amp;key=node.disk.bytes.out.rate.51&amp;key=node.disk.bytes.out.rate.52&amp;key=node.disk.bytes.out.rate.53&amp;key=node.disk.bytes.out.rate.54&amp;key=node.disk.bytes.out.rate.55&amp;key=node.disk.bytes.out.rate.56&amp;key=node.disk.bytes.out.rate.57&amp;key=node.disk.bytes.out.rate.58&amp;key=node.disk.bytes.out.rate.59&amp;devid=all [G]</input>
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
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.0'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.0']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.0']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.1'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.1']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.1']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.2'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.2']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.2']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.3'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.3']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.3']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.4'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.4']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.4']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.5'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.5']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.5']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.6'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.6']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.6']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.7'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.7']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.7']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.8'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.8']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.8']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.9'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.9']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.9']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.10'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.10']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.10']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.11'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.11']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.11']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.12'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.12']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.12']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.13'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.13']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.13']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.14'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.14']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.14']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.15'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.15']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.15']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.16'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.16']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.16']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.17'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.17']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.17']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.18'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.18']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.18']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.19'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.19']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.19']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.20'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.20']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.20']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.21'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.21']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.21']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.22'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.22']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.22']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.23'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.23']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.23']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.24'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.24']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.24']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.25'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.25']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.25']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.26'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.26']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.26']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.27'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.27']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.27']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.28'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.28']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.28']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.29'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.29']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.29']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.30'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.30']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.30']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.31'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.31']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.31']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.32'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.32']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.32']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.33'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.33']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.33']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.34'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.34']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.34']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.35'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.35']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.35']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.36'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.36']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.36']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.37'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.37']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.37']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.38'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.38']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.38']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.39'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.39']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.39']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.40'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.40']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.40']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.41'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.41']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.41']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.42'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.42']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.42']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.43'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.43']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.43']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.44'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.44']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.44']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.45'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.45']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.45']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.46'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.46']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.46']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.47'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.47']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.47']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.48'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.48']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.48']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.49'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.49']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.49']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.50'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.50']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.50']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.51'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.51']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.51']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.52'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.52']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.52']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.53'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.53']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.53']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.54'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.54']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.54']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.55'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.55']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.55']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.56'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.56']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.56']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.57'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.57']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.57']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.58'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.58']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.58']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.59'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.59']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.59']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.60'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.60']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.60']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.61'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.61']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.61']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.62'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.62']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.62']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.63'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.63']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.63']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.64'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.64']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.64']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.65'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.65']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.65']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.66'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.66']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.66']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.67'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.67']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.67']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.68'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.68']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.68']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="ReadThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.69'][error_code!='1']/../stats[key='node.disk.bytes.out.rate.69']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.69']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.0'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.0']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.0']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.1'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.1']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.1']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.2'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.2']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.2']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.3'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.3']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.3']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.4'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.4']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.4']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.5'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.5']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.5']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.6'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.6']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.6']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.7'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.7']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.7']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.8'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.8']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.8']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.9'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.9']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.9']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.10'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.10']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.10']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.11'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.11']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.11']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.12'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.12']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.12']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.13'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.13']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.13']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.14'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.14']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.14']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.15'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.15']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.15']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.16'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.16']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.16']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.17'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.17']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.17']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.18'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.18']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.18']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.19'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.19']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.19']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.20'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.20']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.20']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.21'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.21']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.21']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.22'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.22']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.22']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.23'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.23']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.23']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.24'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.24']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.24']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.25'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.25']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.25']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.26'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.26']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.26']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.27'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.27']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.27']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.28'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.28']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.28']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.29'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.29']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.29']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.30'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.30']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.30']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.31'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.31']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.31']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.32'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.32']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.32']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.33'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.33']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.33']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.34'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.34']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.34']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.35'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.35']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.35']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.36'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.36']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.36']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.37'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.37']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.37']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.38'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.38']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.38']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.39'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.39']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.39']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.40'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.40']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.40']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.41'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.41']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.41']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.42'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.42']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.42']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.43'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.43']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.43']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.44'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.44']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.44']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.45'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.45']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.45']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.46'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.46']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.46']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.47'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.47']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.47']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.48'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.48']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.48']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.49'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.49']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.49']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.50'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.50']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.50']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.51'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.51']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.51']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.52'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.52']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.52']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.53'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.53']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.53']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.54'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.54']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.54']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.55'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.55']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.55']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.56'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.56']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.56']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.57'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.57']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.57']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.58'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.58']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.58']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.59'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.59']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.59']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.60'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.60']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.60']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.61'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.61']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.61']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.62'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.62']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.62']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.63'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.63']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.63']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.64'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.64']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.64']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.65'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.65']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.65']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.66'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.66']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.66']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.67'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.67']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.67']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.68'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.68']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.68']/value" />
			<property-set>Properties</property-set>
		</value>
		<value name="WriteThroughput" type="counter" unit="MB/s" value="/root/stats/stats[key='node.disk.name.69'][error_code!='1']/../stats[key='node.disk.bytes.in.rate.69']/value">
			<replace value="" by="0" />
			<property name="part" type="data" value="../../stats[key='node.disk.name.69']/value" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="ISILON2-NODE-DISK-PERFORMANCE-METRICS" />
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
	<collecting-configuration id="ISILON2-NODE-PROTOCOLS-SUMMARY-METRICS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host nodeid parttype part name">
		<data>
			<include-contexts>conf/context-isilon.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input>(host)/platform/1/statistics/current?key=node.clientstats.active.nfs&amp;key=node.clientstats.active.nlm&amp;key=node.clientstats.active.cifs&amp;key=node.clientstats.active.ftp&amp;key=node.clientstats.active.http&amp;key=node.clientstats.active.siq&amp;key=node.clientstats.active.iscsi&amp;key=node.clientstats.active.jobd&amp;key=node.clientstats.active.smb2&amp;key=node.clientstats.active.nfs4&amp;key=node.clientstats.active.irp&amp;key=node.clientstats.active.lsass_out&amp;key=node.clientstats.active.papi&amp;key=node.clientstats.active.hdfs&amp;key=node.clientstats.active.nfs3&amp;key=node.clientstats.active.smb1&amp;devid=all [G]</input>
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
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.nfs']/value">
			<property name="part" type="hard-coded" value="NFS" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.nlm']/value">
			<property name="part" type="hard-coded" value="NLM" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.cifs']/value">
			<property name="part" type="hard-coded" value="CIFS" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.ftp']/value">
			<property name="part" type="hard-coded" value="FTP" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.http']/value">
			<property name="part" type="hard-coded" value="HTTP" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.siq']/value">
			<property name="part" type="hard-coded" value="SIQ" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.iscsi']/value">
			<property name="part" type="hard-coded" value="iSCSI" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.jobd']/value">
			<property name="part" type="hard-coded" value="JOBD" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.smb2']/value">
			<property name="part" type="hard-coded" value="SMB2" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.nfs4']/value">
			<property name="part" type="hard-coded" value="NFS4" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.irp']/value">
			<property name="part" type="hard-coded" value="IRP" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.lsass_out']/value">
			<property name="part" type="hard-coded" value="LSASS-Out" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.papi']/value">
			<property name="part" type="hard-coded" value="PAPI" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.hdfs']/value">
			<property name="part" type="hard-coded" value="HDFS" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.nfs3']/value">
			<property name="part" type="hard-coded" value="NFS3" />
			<property-set>Properties</property-set>
		</value>
		<value name="ActiveConnection" type="counter" unit="Nb" value="/root/stats/stats[key='node.clientstats.active.smb1']/value">
			<property name="part" type="hard-coded" value="SMB1" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="ISILON2-NODE-PROTOCOLS-SUMMARY-METRICS" />
			<property name="sstype" type="hard-coded" value="File" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="Isilon"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="Protocol" />
			<property name="nodeid" type="data" value="../devid" />
		</property-set>
	</collecting-configuration>
</configuration>