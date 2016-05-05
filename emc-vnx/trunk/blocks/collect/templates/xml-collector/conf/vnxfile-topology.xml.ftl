<#if use_advancedsettings>
	<#assign pollingperiod = topology.pollingperiod>
<#else>
	<#assign pollingperiod = 900>
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
	<simultaneous-collecting>2</simultaneous-collecting>
	<polling-interval>${pollingperiod}</polling-interval>
	<collecting-group>group</collecting-group>
	<source>VNXFile-Collector</source>
	<refresh>3600</refresh>
	<collecting-configuration id="CelerraSystem-ControlStation" max-threads="1" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" variable="datagrp serialnb name">
		<data>
			<include-contexts>conf/context-file.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input type="string">https://(host)/servlets/CelerraManagementServices [P,FC]</input>
			<input type="string">https://(host)/Login?user=@fileurlusername&amp;password=@filepassword&amp;Login=Login [G,SC,CC]</input>
			<input type="string">https://(host)/servlets/CelerraManagementServices</input>
			<host>@csprimary</host>
			<host>@cssecondary</host>
			<parameter name="input-file">
				<value>conf/requests/CelerraSystem-ControlStation.xml</value>
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
		<value name="OperationalStatus" type="counter" unit="%" value="/ResponsePacket/Response/CelerraSystem/Status/@maxSeverity">
			<replace value="warning" by="50"/>
			<replace value="ok" by="100"/>
			<replace value="info" by="99"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="5"/>
			<replace value="emergency" by="10"/>
			<property-set>Properties</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="%" value="/ResponsePacket/Response/StorageSystem/Status/@maxSeverity">
			<replace value="warning" by="50"/>
			<replace value="ok" by="100"/>
			<replace value="info" by="99"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="5"/>
			<replace value="emergency" by="10"/>
			<property-set>PropertiesStorageSystem</property-set>
		</value>
		<property-set name="Properties">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-CelerraSystem" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="serialnb" type="data" value="../../@serial" />
			<property name="model" type="data" value="../../@productName" />
			<property name="devdesc" type="data" value="../../@version" />
			<property name="vendor" type="hard-coded" value="EMC Corporation" />
			<property name="ip" type="data" value="string-join(/ResponsePacket/Response/ControlStation/@address, ', ')" />
		</property-set>
		<property-set name="PropertiesStorageSystem">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-CelerraSystem" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="StorageSystem" />
			<property name="part" type="data" value="../../@name" />
			<property name="partid" type="data" value="../../@serial" />
			<property name="partsn" type="data" value="../../@serial" />
			<property name="partmodl" type="data" value="../../ClariionSystemData/@model" />
			<property name="partdesc" type="data" value="../../ClariionSystemData/@softwareVersion" />
			<property name="partcnt" type="data" value="../../@diskCount" />
			<property name="partsize" type="data" value="../../@cacheSize" />
			<property name="storid" type="data" value="../../@storage" />
			<property name="storsn" type="data" value="../../@serial" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="Mover" max-threads="1" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" variable="datagrp deviceid  parttype moverid name">
		<data>
			<include-contexts>conf/context-file.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input type="string">https://(host)/servlets/CelerraManagementServices [P,FC]</input>
			<input type="string">https://(host)/Login?user=@fileurlusername&amp;password=@filepassword&amp;Login=Login [G,SC,CC]</input>
			<input type="string">https://(host)/servlets/CelerraManagementServices</input>
			<host>@csprimary</host>
			<host>@cssecondary</host>
			<parameter name="input-file">
				<value>conf/requests/Mover.xml</value>
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
		<value name="OperationalStatus" type="counter" unit="%" value="/ResponsePacket/Response/MoverStatus[@mover='1']/Status/@maxSeverity">
			<replace value="warning" by="50"/>
			<replace value="ok" by="100"/>
			<replace value="info" by="99"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="5"/>
			<replace value="emergency" by="10"/>
			<property-set>Properties1</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="%" value="/ResponsePacket/Response/MoverStatus[@mover='2']/Status/@maxSeverity">
			<replace value="warning" by="50"/>
			<replace value="ok" by="100"/>
			<replace value="info" by="99"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="5"/>
			<replace value="emergency" by="10"/>
			<property-set>Properties2</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="%" value="/ResponsePacket/Response/MoverStatus[@mover='3']/Status/@maxSeverity">
			<replace value="warning" by="50"/>
			<replace value="ok" by="100"/>
			<replace value="info" by="99"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="5"/>
			<replace value="emergency" by="10"/>
			<property-set>Properties3</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="%" value="/ResponsePacket/Response/MoverStatus[@mover='4']/Status/@maxSeverity">
			<replace value="warning" by="50"/>
			<replace value="ok" by="100"/>
			<replace value="info" by="99"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="5"/>
			<replace value="emergency" by="10"/>
			<property-set>Properties4</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="%" value="/ResponsePacket/Response/MoverStatus[@mover='5']/Status/@maxSeverity">
			<replace value="warning" by="50"/>
			<replace value="ok" by="100"/>
			<replace value="info" by="99"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="5"/>
			<replace value="emergency" by="10"/>
			<property-set>Properties5</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="%" value="/ResponsePacket/Response/MoverStatus[@mover='6']/Status/@maxSeverity">
			<replace value="warning" by="50"/>
			<replace value="ok" by="100"/>
			<replace value="info" by="99"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="5"/>
			<replace value="emergency" by="10"/>
			<property-set>Properties6</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="%" value="/ResponsePacket/Response/MoverStatus[@mover='7']/Status/@maxSeverity">
			<replace value="warning" by="50"/>
			<replace value="ok" by="100"/>
			<replace value="info" by="99"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="5"/>
			<replace value="emergency" by="10"/>
			<property-set>Properties7</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="%" value="/ResponsePacket/Response/MoverStatus[@mover='8']/Status/@maxSeverity">
			<replace value="warning" by="50"/>
			<replace value="ok" by="100"/>
			<replace value="info" by="99"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="5"/>
			<replace value="emergency" by="10"/>
			<property-set>Properties8</property-set>
		</value>
		<value name="Uptime" type="counter" unit="s" value="/ResponsePacket/Response/MoverStatus[@mover='1']/@uptime">
			<property-set>Properties1</property-set>
		</value>
		<value name="Uptime" type="counter" unit="s" value="/ResponsePacket/Response/MoverStatus[@mover='2']/@uptime">
			<property-set>Properties2</property-set>
		</value>
		<value name="Uptime" type="counter" unit="s" value="/ResponsePacket/Response/MoverStatus[@mover='3']/@uptime">
			<property-set>Properties3</property-set>
		</value>
		<value name="Uptime" type="counter" unit="s" value="/ResponsePacket/Response/MoverStatus[@mover='4']/@uptime">
			<property-set>Properties4</property-set>
		</value>
		<value name="Uptime" type="counter" unit="s" value="/ResponsePacket/Response/MoverStatus[@mover='5']/@uptime">
			<property-set>Properties5</property-set>
		</value>
		<value name="Uptime" type="counter" unit="s" value="/ResponsePacket/Response/MoverStatus[@mover='6']/@uptime">
			<property-set>Properties6</property-set>
		</value>
		<value name="Uptime" type="counter" unit="s" value="/ResponsePacket/Response/MoverStatus[@mover='7']/@uptime">
			<property-set>Properties7</property-set>
		</value>
		<value name="Uptime" type="counter" unit="s" value="/ResponsePacket/Response/MoverStatus[@mover='8']/@uptime">
			<property-set>Properties8</property-set>
		</value>
		<property-set name="Properties1">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Mover" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="DataMover" />
			<property name="part" type="data" value="/ResponsePacket/Response/Mover[@mover='1']/@name" />
			<property name="movernam" type="data" value="/ResponsePacket/Response/Mover[@mover='1']/@name" />
			<property name="moverid" type="data" value="/ResponsePacket/Response/Mover[@mover='1']/@mover" />
			<property name="partdesc" type="data" value="/ResponsePacket/Response/Mover[@mover='1']/@role" />
			<property name="moversvd" type="hard-coded" value="false" />
			<property name="ifaceip" type="data" value="string-join(/ResponsePacket/Response[@clientHandle='Mover']/MoverInterface[@mover='1']/@ipAddress, ',')" />
		</property-set>
		<property-set name="Properties2">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Mover" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="DataMover" />
			<property name="part" type="data" value="/ResponsePacket/Response/Mover[@mover='2']/@name" />
			<property name="movernam" type="data" value="/ResponsePacket/Response/Mover[@mover='2']/@name" />
			<property name="moverid" type="data" value="/ResponsePacket/Response/Mover[@mover='2']/@mover" />
			<property name="partdesc" type="data" value="/ResponsePacket/Response/Mover[@mover='2']/@role" />
			<property name="moversvd" type="hard-coded" value="false" />
			<property name="ifaceip" type="data" value="string-join(/ResponsePacket/Response[@clientHandle='Mover']/MoverInterface[@mover='2']/@ipAddress, ',')" />
		</property-set>
		<property-set name="Properties3">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Mover" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="DataMover" />
			<property name="part" type="data" value="/ResponsePacket/Response/Mover[@mover='3']/@name" />
			<property name="movernam" type="data" value="/ResponsePacket/Response/Mover[@mover='3']/@name" />
			<property name="moverid" type="data" value="/ResponsePacket/Response/Mover[@mover='3']/@mover" />
			<property name="partdesc" type="data" value="/ResponsePacket/Response/Mover[@mover='3']/@role" />
			<property name="moversvd" type="hard-coded" value="false" />
			<property name="ifaceip" type="data" value="string-join(/ResponsePacket/Response[@clientHandle='Mover']/MoverInterface[@mover='3']/@ipAddress, ',')" />
		</property-set>
		<property-set name="Properties4">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Mover" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="DataMover" />
			<property name="part" type="data" value="/ResponsePacket/Response/Mover[@mover='4']/@name" />
			<property name="movernam" type="data" value="/ResponsePacket/Response/Mover[@mover='4']/@name" />
			<property name="moverid" type="data" value="/ResponsePacket/Response/Mover[@mover='4']/@mover" />
			<property name="partdesc" type="data" value="/ResponsePacket/Response/Mover[@mover='4']/@role" />
			<property name="moversvd" type="hard-coded" value="false" />
			<property name="ifaceip" type="data" value="string-join(/ResponsePacket/Response[@clientHandle='Mover']/MoverInterface[@mover='4']/@ipAddress, ',')" />
		</property-set>
		<property-set name="Properties5">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Mover" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="DataMover" />
			<property name="part" type="data" value="/ResponsePacket/Response/Mover[@mover='5']/@name" />
			<property name="movernam" type="data" value="/ResponsePacket/Response/Mover[@mover='5']/@name" />
			<property name="moverid" type="data" value="/ResponsePacket/Response/Mover[@mover='5']/@mover" />
			<property name="partdesc" type="data" value="/ResponsePacket/Response/Mover[@mover='5']/@role" />
			<property name="moversvd" type="hard-coded" value="false" />
			<property name="ifaceip" type="data" value="string-join(/ResponsePacket/Response[@clientHandle='Mover']/MoverInterface[@mover='5']/@ipAddress, ',')" />
		</property-set>
		<property-set name="Properties6">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Mover" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="DataMover" />
			<property name="part" type="data" value="/ResponsePacket/Response/Mover[@mover='6']/@name" />
			<property name="movernam" type="data" value="/ResponsePacket/Response/Mover[@mover='6']/@name" />
			<property name="moverid" type="data" value="/ResponsePacket/Response/Mover[@mover='6']/@mover" />
			<property name="partdesc" type="data" value="/ResponsePacket/Response/Mover[@mover='6']/@role" />
			<property name="moversvd" type="hard-coded" value="false" />
			<property name="ifaceip" type="data" value="string-join(/ResponsePacket/Response[@clientHandle='Mover']/MoverInterface[@mover='6']/@ipAddress, ',')" />
		</property-set>
		<property-set name="Properties7">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Mover" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="DataMover" />
			<property name="part" type="data" value="/ResponsePacket/Response/Mover[@mover='7']/@name" />
			<property name="movernam" type="data" value="/ResponsePacket/Response/Mover[@mover='7']/@name" />
			<property name="moverid" type="data" value="/ResponsePacket/Response/Mover[@mover='7']/@mover" />
			<property name="partdesc" type="data" value="/ResponsePacket/Response/Mover[@mover='7']/@role" />
			<property name="moversvd" type="hard-coded" value="false" />
			<property name="ifaceip" type="data" value="string-join(/ResponsePacket/Response[@clientHandle='Mover']/MoverInterface[@mover='7']/@ipAddress, ',')" />
		</property-set>
		<property-set name="Properties8">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Mover" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="DataMover" />
			<property name="part" type="data" value="/ResponsePacket/Response/Mover[@mover='8']/@name" />
			<property name="movernam" type="data" value="/ResponsePacket/Response/Mover[@mover='8']/@name" />
			<property name="moverid" type="data" value="/ResponsePacket/Response/Mover[@mover='8']/@mover" />
			<property name="partdesc" type="data" value="/ResponsePacket/Response/Mover[@mover='8']/@role" />
			<property name="moversvd" type="hard-coded" value="false" />
			<property name="ifaceip" type="data" value="string-join(/ResponsePacket/Response[@clientHandle='Mover']/MoverInterface[@mover='8']/@ipAddress, ',')" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="CifsShare-NfsExport" max-threads="1" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" variable="datagrp deviceid parttype partid name">
		<data>
			<include-contexts>conf/context-file.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input type="string">https://(host)/servlets/CelerraManagementServices [P,FC]</input>
			<input type="string">https://(host)/Login?user=@fileurlusername&amp;password=@filepassword&amp;Login=Login [G,SC,CC]</input>
			<input type="string">https://(host)/servlets/CelerraManagementServices</input>
			<host>@csprimary</host>
			<host>@cssecondary</host>
			<parameter name="input-file">
				<value>conf/requests/CifsShare-NfsExport.xml</value>
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
		<value name="Identifier" type="counter" unit="" value="/ResponsePacket/Response[@clientHandle='CifsShare']/CifsShare/@fileSystem">
			<property name="parttype" type="hard-coded" value="CifsShare" />
			<property-set>Properties</property-set>
		</value>
		<value name="Identifier" type="counter" unit="" value="/ResponsePacket/Response[@clientHandle='NfsExport']/NfsExport/@fileSystem">
			<property name="parttype" type="hard-coded" value="NfsExport" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-CifsShare-NfsExport" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="part" type="data" value="(../@name | ../@path)" />
			<property name="movers" type="data" value="../@mover" />
			<property name="partid" type="data" value="." />
			<property name="partdesc" type="data" value="../@path" />
			<property name="maxusers" type="data" value="../@maxUsers" />
			<property name="clientfs" type="data" value="../*/li" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="FileSystem-Volume" max-threads="1" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" variable="datagrp deviceid parttype partid name">
		<data>
			<include-contexts>conf/context-file.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input type="string">https://(host)/servlets/CelerraManagementServices [P,FC]</input>
			<input type="string">https://(host)/Login?user=@fileurlusername&amp;password=@filepassword&amp;Login=Login [G,SC,CC]</input>
			<input type="string">https://(host)/servlets/CelerraManagementServices</input>
			<host>@csprimary</host>
			<host>@cssecondary</host>
			<parameter name="input-file">
				<value>conf/requests/FileSystem-Volume.xml</value>
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
		<value name="RemoveMe" type="counter" unit="" value="/ResponsePacket/Response[@clientHandle='FileSystem']/FileSystem/@fileSystem">
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../@fileSystem" />
			<property name="fsname" type="data" value="../@name" />
			<property-set>Properties</property-set>
		</value>
		<value name="PresentedCapacity" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='FileSystem']/FileSystem/FileSystemAutoExtInfo/@autoExtensionMaxSize">
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../../@fileSystem" />
			<property name="fsname" type="data" value="../../@name" />
			<property-set>Properties2levelFS</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='Volume']/Volume[@type='disk']/@size">
			<property name="parttype" type="hard-coded" value="Disk" />
			<property name="partid" type="data" value="../@name" />
			<property name="disktype" type="data" value="../DiskVolumeData/@diskType">
				<replace value="clstd" by="SystemResource"/>
			</property>
			<property name="storid" type="data" value="../DiskVolumeData/@storageSystem" />
			<property name="storlun" type="data" value="../DiskVolumeData/@lun" />
			<property-set>Properties</property-set>
		</value>
		<value name="FreeCapacity" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='Volume']/Volume[@type='disk']/FreeSpace/@size">
			<property name="parttype" type="hard-coded" value="Disk" />
			<property name="partid" type="data" value="../../@name" />
			<property name="disktype" type="data" value="../../DiskVolumeData/@diskType">
				<replace value="clstd" by="SystemResource"/>
			</property>
			<property name="storid" type="data" value="../../DiskVolumeData/@storageSystem" />
			<property name="storlun" type="data" value="../../DiskVolumeData/@lun" />
			<property-set>Properties2level</property-set>
		</value>
		<property-set name="Properties">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-FileSystem-Volume" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="dgstype" type="data" value="../@virtualProvisioning">
				<replace value="true" by="1"/>
				<replace value="false" by="0"/>
			</property>
			<property name="internal" type="data" value="../@internalUse" />
			<property name="type" type="data" value="../@type">
				<replace value="mgfs" by="MGFS"/>
				<replace value="disk" by="Disk"/>
				<replace value="uxfs" by="UXFS"/>
			</property>
			<property name="part" type="data" value="../@name" />
			<property name="movers" type="data" value="../DiskVolumeData/@movers" />
			<property name="moversvd" type="data" value="../*/@moverIdIsVdm" />
			<property name="storpool" type="data" value="../@storagePools" />
			<property name="vols" type="data" value="../@volume" />
			<property name="partdesc" type="data" value="../@internalUse | ../@clientVolumes" />
		</property-set>
		<property-set name="Properties2level">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-FileSystem-Volume" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="dgstype" type="data" value="../@virtualProvisioning">
				<replace value="true" by="1"/>
				<replace value="false" by="0"/>
			</property>
			<property name="internal" type="data" value="../../@internalUse" />
			<property name="type" type="data" value="../../@type">
				<replace value="mgfs" by="MGFS"/>
				<replace value="disk" by="Disk"/>
				<replace value="uxfs" by="UXFS"/>
			</property>
			<property name="part" type="data" value="../../@name" />
			<property name="movers" type="data" value="../../DiskVolumeData/@movers" />
			<property name="moversvd" type="data" value="../../*/@moverIdIsVdm" />
			<property name="storpool" type="data" value="../../@storagePools" />
			<property name="vols" type="data" value="../../@volume" />
			<property name="partdesc" type="data" value="../../@internalUse | ../../@clientVolumes" />
		</property-set>
		<property-set name="Properties2levelFS">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-FileSystemUsage-CapacityInfo-CheckpointInfo" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="dgstype" type="data" value="../../@virtualProvisioning">
				<replace value="true" by="1"/>
				<replace value="false" by="0"/>
			</property>
			<property name="internal" type="data" value="../../@internalUse" />
			<property name="type" type="data" value="../../@type">
				<replace value="mgfs" by="MGFS"/>
				<replace value="uxfs" by="UXFS"/>
			</property>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="Checkpoint" max-threads="1" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" variable="datagrp deviceid parttype partid name">
		<data>
			<include-contexts>conf/context-file.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input type="string">https://(host)/servlets/CelerraManagementServices [P,FC]</input>
			<input type="string">https://(host)/Login?user=@fileurlusername&amp;password=@filepassword&amp;Login=Login [G,SC,CC]</input>
			<input type="string">https://(host)/servlets/CelerraManagementServices</input>
			<host>@csprimary</host>
			<host>@cssecondary</host>
			<parameter name="input-file">
				<value>conf/requests/Checkpoint.xml</value>
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
		<value name="CheckPointSize" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='Checkpoint']/Checkpoint/@fileSystemSize">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Checkpoint" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="Checkpoint" />
			<property name="part" type="data" value="../@name" />
			<property name="moverid" type="data" value="../*/@mover" />
			<property name="partid" type="data" value="../@checkpoint" />
			<property name="vols" type="data" value="../@checkpointOf" />
			<property name="cptime" type="data" value="../@time" />
			<property name="state" type="data" value="../@state" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="StoragePoolQueryParams-PhysicalDevice-Vdm" max-threads="1" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" variable="datagrp deviceid parttype partid name">
		<data>
			<include-contexts>conf/context-file.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input type="string">https://(host)/servlets/CelerraManagementServices [P,FC]</input>
			<input type="string">https://(host)/Login?user=@fileurlusername&amp;password=@filepassword&amp;Login=Login [G,SC,CC]</input>
			<input type="string">https://(host)/servlets/CelerraManagementServices</input>
			<host>@csprimary</host>
			<host>@cssecondary</host>
			<parameter name="input-file">
				<value>conf/requests/StoragePoolQueryParams-PhysicalDevice-Vdm.xml</value>
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
		<value name="UsedCapacity" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='StoragePoolQueryParams']/StoragePool/@usedSize">
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='StoragePoolQueryParams']/StoragePool/@size">
			<property-set>Properties</property-set>
		</value>
		<value name="RemoveMe" type="counter" unit="" value="/ResponsePacket/Response[@clientHandle='PhysicalDevice']/FcDescriptor/FcConnectionSet/ScsiRange/@scsiChainStart">
			<property name="partid" type="data" value="upper-case(../../@portWWN)" />
			<property name="moverid" type="data" value="../../../@moverHost" />
			<property name="storid" type="data" value="string-join(../../StorageEndpoint/@storage, ',')" />
			<property name="storpwwn" type="data" value="upper-case(string-join(../../StorageEndpoint/@portWWN, ','))" />
			<property-set>PropertiesPhysicalDevice</property-set>
		</value>
		<value name="StorageEndpoint" type="counter" unit="" value="/ResponsePacket/Response[@clientHandle='PhysicalDevice']/PhysicalDevice[@type='fc']/@irq">
			<property name="part" type="data" value="../@name" />
			<property name="partid" type="data" value="upper-case(../FibreChannelDeviceData/@portWWN)" />
			<property name="moverid" type="data" value="../@moverHost" />
			<property-set>PropertiesPhysicalDevice</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="%" value="/ResponsePacket/Response[@clientHandle='Vdm']/Vdm/Status/@maxSeverity">
			<replace value="warning" by="50"/>
			<replace value="ok" by="100"/>
			<replace value="info" by="99"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="5"/>
			<replace value="emergency" by="10"/>
			<property-set>PropertiesVdm</property-set>
		</value>
		<property-set name="Properties">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-StoragePoolQueryParams" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="Storage Pool" />
			<property name="part" type="data" value="../@name" />
			<property name="moverid" type="data" value="../@movers" />
			<property name="partid" type="data" value="../@pool" />
			<property name="vols" type="data" value="../@memberVolumes" />
			<property name="partdesc" type="data" value="../@description" />
			<property name="virt" type="data" value="../@virtualProvisioning">
				<replace value="true" by="1"/>
				<replace value="false" by="0"/>
			</property>
		</property-set>
		<property-set name="PropertiesPhysicalDevice">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-PhysicalDevice" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="Port" />
			<property name="iftype" type="hard-coded" value="fibreChannel" />
			<property name="moversvd" type="hard-coded" value="false" />
		</property-set>
		<property-set name="PropertiesVdm">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-Vdm" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
			<property name="parttype" type="hard-coded" value="VirtualDataMover" />
			<property name="part" type="data" value="../../@name" />
			<property name="partid" type="data" value="../../@vdm" />
			<property name="moverid" type="data" value="../../@mover" />
			<property name="ifaceip" type="data" value="../../Interfaces/li" />
			<property name="moversvd" type="hard-coded" value="true" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="FileSystemUsage-CapacityInfo-CheckpointInfo" max-threads="1" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" variable="datagrp deviceid parttype partid volumeid name">
		<data>
			<include-contexts>conf/context-file.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.SOAPXmlRequestExecutor</data-accessor>
			<input type="string">https://(host)/servlets/CelerraManagementServices [P,FC]</input>
			<input type="string">https://(host)/Login?user=@fileurlusername&amp;password=@filepassword&amp;Login=Login [G,SC,CC]</input>
			<input type="string">https://(host)/servlets/CelerraManagementServices</input>
			<host>@csprimary</host>
			<host>@cssecondary</host>
			<parameter name="input-file">
				<value>conf/requests/FileSystemUsage-CapacityInfo-CheckpointInfo.xml</value>
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
		<value name="FilesUsed" type="counter" unit="Nb" value="/ResponsePacket/Response/FileSystemSetUsageStats/Item/@filesUsed">
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../@fileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="FilesTotal" type="counter" unit="Nb" value="/ResponsePacket/Response/FileSystemSetUsageStats/Item/@filesTotal">
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../@fileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="MetaVolumeCapacity" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='FileSystemCapacityInfo']/FileSystemCapacityInfo/@volumeSize">
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../@fileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='FileSystemCapacityInfo']/FileSystemCapacityInfo/ResourceUsage/@spaceTotal">
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../../@fileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='FileSystemCapacityInfo']/FileSystemCapacityInfo/ResourceUsage/@spaceUsed">
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../../@fileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='FileSystemCheckpointInfo']/FileSystemCheckpointInfo/@volumeSize">
			<property name="parttype" type="hard-coded" value="Snapshot" />
			<property name="partid" type="data" value="../@fileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='FileSystemCheckpointInfo']/FileSystemCheckpointInfo/@spaceUsed">
			<property name="parttype" type="hard-coded" value="Snapshot" />
			<property name="partid" type="data" value="../@fileSystem" />
			<property-set>Properties</property-set>
		</value>
		<value name="RemoveMeZero" type="counter" unit="GB" value="/ResponsePacket/Response[@clientHandle='FileSystemCapacityInfo']/QueryStatus/@maxSeverity">
			<replace value="warning" by="0"/>
			<replace value="ok" by="0"/>
			<replace value="info" by="0"/>
			<replace value="error" by="0"/>
			<replace value="critical" by="0"/>
			<replace value="emergency" by="0"/>
			<property name="partid" type="hard-coded" value="1" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="sstype" type="hard-coded" value="@sstype" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="datagrp" type="hard-coded" value="VNXFile-FileSystemUsage-CapacityInfo-CheckpointInfo" />
			<property name="device" type="hard-coded" value="@friendlyname" />
			<property name="deviceid" type="hard-coded" value="@deviceid" />
			<property name="devtype" type="hard-coded" value="FileServer" />
		</property-set>
	</collecting-configuration>
</configuration>