<#if use_advancedsettings>
	<#assign pollingperiod = topology.pollingperiod>
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
	<simultaneous-collecting>5</simultaneous-collecting>
	<polling-interval>${pollingperiod}</polling-interval>
	<collecting-group>group</collecting-group>
	<source>VNXUnity-Collector</source>
	<refresh>3600</refresh>
	<collecting-configuration id="UNITY-SYSTEM" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/system/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content/health/value">
			<property-set>Properties</property-set>
		</value>
		<value name="RemoveMeZero" type="counter" unit="GB" value="/root/entries/entries/content/isDefaultAdminPassword">
			<replace value="false" by="0" />
			<replace value="true" by="0" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-SYSTEM" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="serialnb" type="data" value="../../serialNumber | ../serialNumber" />
			<property name="model" type="data" value="concat(../../model | ../model, ' ', ../../platform | ../platform)" />
			<property name="device" type="data" value="../../name | ../name" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-MGMTINTERFACE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/mgmtInterface/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="RemoveMe" type="counter" unit="" value="/root/entries/entries/content[id='mgmt_ipv4']/id">
			<replace value="mgmt_ipv4" by="0" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-MGMTINTERFACE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="ip" type="data" value="../address" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-INSTALLEDSOFTWAREVERSION" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/installedSoftwareVersion/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="RemoveMe" type="counter" unit="" value="/root/entries/entries/content/revision">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-SYSTEM" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="devdesc" type="data" value="../id" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-DISK" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/disk/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="Capacity" type="counter" unit="GB" value="/root/entries/entries/content[size!='0']/size">
			<property-set>Properties</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content/health/value">
			<property-set>Properties</property-set>
		</value>
		<!--<value name="RemoveMeZero" value="/root/entries/entries/content/tierType" unit="GB">
			<replace value="" by="0" />
			<replace value="10" by="0" />
			<replace value="20" by="0" />
			<replace value="30" by="0" />
			<property-set>Properties</property-set>
		</value>-->
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-DISK" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Disk" />
			<property name="part" type="data" value="../name | ../../name" />
			<property name="partid" type="data" value="../wwn | ../../wwn" />
			<property name="crf" type="data" value="../emcSerialNumber | ../../emcSerialNumber" />
			<property name="partsn" type="data" value="replace(../wwn | ../../wwn, ':', '')" />
			<property name="dgid" type="data" value="../pool | ../../pool">
				<replace value="" by="None" />
			</property>
			<property name="tiername" type="data" value="../tierType | ../../tierType">
				<replace value="10" by="Extreme Performance" />
				<replace value="20" by="Performance" />
				<replace value="30" by="Capacity" />
			</property>
			<property name="partstat" type="data" value="if(../pool | ../../pool) then node-name(..) else ../diskTechnology | ../../diskTechnology">                 
				<replace value="content" by="Used" />
				<replace value="health" by="Used" />
				<replace value="" by="Empty" />
				<replace value="1" by="Hot Spare" />
				<replace value="2" by="Hot Spare" />
				<replace value="5" by="Hot Spare" />
				<replace value="6" by="Hot Spare" />
			</property>
			<property name="disktype" type="data" value="../diskTechnology | ../../diskTechnology">
				<replace value="1" by="SAS" />
				<replace value="2" by="NL SAS" />
				<replace value="5" by="Enterprise Flash Drive" />
				<replace value="6" by="SAS FLASH VP" />
			</property>
			<property name="disksize" type="data" value="../size | ../../size" />
			<property name="module" type="data" value="../diskTechnology | ../../diskTechnology">
				<replace value="1" by="SAS" />
				<replace value="2" by="NL SAS" />
				<replace value="5" by="Enterprise Flash Drive" />
				<replace value="6" by="SAS FLASH VP" />
			</property>
			<property name="diskrpm" type="data" value="../rpm | ../../rpm" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-STORAGEPROCESSOR" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/storageProcessor/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="TotalMemory" type="counter" unit="MB" value="/root/entries/entries/content/memorySize">
			<property-set>Properties</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content/health/value">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-STORAGEPROCESSOR" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Controller" />
			<property name="part" type="data" value="../name | ../../name" />
			<property name="partid" type="data" value="../id | ../../id" />
			<property name="partmdl" type="data" value="../model | ../../model" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-NASSERVER" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/nasServer/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content[isSystem='false']/health/value">
			<property name="parttype" type="hard-coded" value="VirtualDataMover" />
			<property name="sgname" type="data" value="../../pool/id" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-NASSERVER" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="part" type="data" value="../../name" />
			<property name="partid" type="data" value="../../id" />
			<property name="moverid" type="data" value="../../currentSP/id">
				<replace value="spa" by="SP A" />
				<replace value="spb" by="SP B" />
			</property>
			<property name="partdesc" type="data" value="../../mode">
				<replace value="0" by="Normal" />
				<replace value="0" by="Destination" />
			</property>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-FILEINTERFACE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/fileInterface/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="RemoveMe" type="counter" unit="" value="/root/entries/entries/content[isSystem='false']/health/value">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-FILEINTERFACE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="VirtualDataMover" />
			<property name="partid" type="data" value="../../nasServer/id" />
			<property name="moverid" type="data" value="substring(../../id, 1, 3)">
				<replace value="spa" by="SP A" />
				<replace value="spb" by="SP B" />
			</property>
			<property name="ifaceip" type="data" value="../../ipAddress" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-POOL" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/pool/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content/health/value">
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeTotal">
			<property-set>Properties</property-set>
		</value>
		<value name="FreeCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeFree">
			<property-set>Properties</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeUsed">
			<property-set>Properties</property-set>
		</value>
		<value name="SubscribedCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeSubscribed">
			<property-set>Properties</property-set>
		</value>
		<value name="SnapShotUsedCapacity" type="counter" unit="GB" value="/root/entries/entries/content/snapSizeUsed">
			<property-set>Properties</property-set>
		</value>
		<!--<value name="RemoveMeZero" value="/root/entries/entries/content/isEmpty" unit="GB">
            <replace value="false" by="0" />
            <replace value="false" by="0" />
            <property-set>Properties</property-set>
        </value>-->
		<value name="Capacity" type="counter" unit="GB" value="/root/entries/entries/content/tiers/tiers/sizeTotal">
			<property-set>PropertiesTiers</property-set>
		</value>
		<value name="FreeCapacity" type="counter" unit="GB" value="/root/entries/entries/content/tiers/tiers/sizeFree">
			<property-set>PropertiesTiers</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/root/entries/entries/content/tiers/tiers/sizeUsed">
			<property-set>PropertiesTiers</property-set>
		</value>
		<value name="MovingDownCapacity" type="counter" unit="GB" value="/root/entries/entries/content/tiers/tiers/sizeMovingDown">
			<property-set>PropertiesTiers</property-set>
		</value>
		<value name="MovingUpCapacity" type="counter" unit="GB" value="/root/entries/entries/content/tiers/tiers/sizeMovingUp">
			<property-set>PropertiesTiers</property-set>
		</value>
		<value name="MovingWithinCapacity" type="counter" unit="GB" value="/root/entries/entries/content/tiers/tiers/sizeMovingUp">
			<property-set>PropertiesTiers</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-POOL" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Storage Pool" />
			<property name="partid" type="data" value="../../id | ../id" />
			<property name="part" type="data" value="../../name | ../name" />
			<property name="dgid" type="data" value="../../id | ../id" />
			<property name="dgname" type="data" value="../../name | ../name" />
			<property name="dgtype" type="hard-coded" value="Storage Pool" />
			<property name="poolname" type="data" value="../../name | ../name" />
			<property name="pooltype" type="hard-coded" value="Storage Pool" />
			<property name="partdesc" type="data" value="../../description | ../description" />
			<property name="dgraid" type="data" value="../../raidType | ../raidType">
				<replace value="0" by="None" />
				<replace value="1" by="RAID-5" />
				<replace value="2" by="RAID-0" />
				<replace value="3" by="RAID-1" />
				<replace value="4" by="RAID-3" />
				<replace value="7" by="RAID-10" />
				<replace value="10" by="RAID-6" />
				<replace value="12" by="Mixed" />
			</property>
			<property name="hasfc" type="data" value="../../isFASTCacheEnabled | ../isFASTCacheEnabled">
				<replace value="false" by="0" />
				<replace value="true" by="1" />
			</property>
		</property-set>
		<property-set name="PropertiesTiers">
			<property name="datagrp" type="hard-coded" value="UNITY-POOL" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Storage Tier" />
			<property name="partid" type="data" value="../name" />
			<property name="part" type="data" value="../name" />
			<property name="dgid" type="data" value="../../../id" />
			<property name="dgname" type="data" value="../../../name" />
			<property name="dgtype" type="hard-coded" value="Storage Pool" />
			<property name="poolname" type="data" value="../../../name" />
			<property name="pooltype" type="hard-coded" value="Storage Pool" />
			<property name="dgraid" type="data" value="../../../raidType">
				<replace value="0" by="None" />
				<replace value="1" by="RAID-5" />
				<replace value="2" by="RAID-0" />
				<replace value="3" by="RAID-1" />
				<replace value="4" by="RAID-3" />
				<replace value="7" by="RAID-10" />
				<replace value="10" by="RAID-6" />
				<replace value="12" by="Mixed" />
			</property>
			<property name="hasfc" type="data" value="../../../isFASTCacheEnabled">
				<replace value="false" by="0" />
				<replace value="true" by="1" />
			</property>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-LUN" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/lun/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content/health/value">
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeTotal">
			<property-set>Properties</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeUsed">
			<property-set>Properties</property-set>
		</value>
		<value name="PresentedCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeAllocated">
			<property-set>Properties</property-set>
		</value>
		<value name="RemoveMeZero" value="/root/entries/entries/content/currentNode" unit="GB">
			<replace value="0" by="0" />
			<replace value="1" by="0" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-LUN" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="LUN" />
			<property name="partid" type="data" value="substring(../../id | ../id, 4)" />
			<property name="part" type="data" value="../../name | ../name" />
			<property name="dgid" type="data" value="../../pool/id | ../pool/id" />
			<property name="partdesc" type="data" value="../../description | ../description" />
			<property name="partsn" type="data" value="replace(../../wwn | ../wwn, ':', '')" />
			<property name="crf" type="data" value="replace(../../wwn | ../wwn, ':', '')" />
			<property name="dgstype" type="data" value="../../isThinEnabled | ../isThinEnabled">
				<replace value="true" by="Thin" />
				<replace value="false" by="Thick" />
			</property>
			<property name="storesid" type="data" value="../../storageResource/id | ../storageResource/id" />
			<property name="memberof" type="data" value="../../currentNode | ../currentNode" >
				<replace value="0" by="SP A" />
				<replace value="1" by="SP B" />
			</property>
			<property name="private" type="hard-coded" value="NO" />
			<property name="ismetam" type="hard-coded" value="0" />
			<property name="ismetah" type="hard-coded" value="0" />
			<property name="ispolcsu" type="hard-coded" value="1" />
			<property name="ispolctr" type="hard-coded" value="0" />
			<property name="haslun" type="hard-coded" value="1" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-LUNGROUPS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/storageResource/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content[type='2']/health/value">
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/root/entries/entries/content[type='2']//sizeTotal">
			<property-set>Properties</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/root/entries/entries/content[type='2']//sizeUsed">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-LUNGROUPS" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="LUNGroup" />
			<property name="partid" type="data" value="../../id | ../id" />
			<property name="part" type="data" value="../../name | ../name" />
			<property name="partdesc" type="data" value="../../description | ../description" />
			<property name="dgstype" type="data" value="../../thinStatus | ../thinStatus">
				<replace value="1" by="Thin" />
				<replace value="0" by="Thick" />
				<replace value="0xffff" by="Mixed" />
			</property>
			<property name="storesid" type="data" value="../../id | ../id" />
			<property name="stores" type="data" value="../../name | ../name" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-FILESYSTEM" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/filesystem/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content/health/value">
			<property-set>Properties</property-set>
		</value>
		<value name="PresentedCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeTotal">
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeAllocated">
			<property-set>Properties</property-set>
		</value>
		<value name="UsedCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeUsed">
			<property-set>Properties</property-set>
		</value>
		<value name="FreeCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeFree">
			<property-set>Properties</property-set>
		</value>
		<value name="OverheadCapacity" type="counter" unit="GB" value="/root/entries/entries/content/reserveSizeTotal">
			<property-set>Properties</property-set>
		</value>
		<value name="SnapshotCapacity" type="counter" unit="GB" value="/root/entries/entries/content/savVolSizeTotal">
			<property-set>Properties</property-set>
		</value>
		<value name="FilesScanned" type="counter" unit="Nb" value="/root/entries/entries/content/dedupNumFilesScanned">
			<property-set>Properties</property-set>
		</value>
		<value name="FilesDeduped" type="counter" unit="Nb" value="/root/entries/entries/content/dedupNumFilesDeduped">
			<property-set>Properties</property-set>
		</value>
		<value name="OriginalDataSize" type="counter" unit="GB" value="/root/entries/entries/content/dedupOriginalSizeUsed">
			<property-set>Properties</property-set>
		</value>
		<value name="SpaceSaved" type="counter" unit="GB" value="/root/entries/entries/content/dedupSizeSaved">
			<property-set>Properties</property-set>
		</value>
		<value name="RemoveMeZero" type="counter" unit="GB" value="/root/entries/entries/content/isThinEnabled">
			<replace value="true" by="0" />
			<replace value="false" by="0" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-FILESYSTEM" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="partid" type="data" value="../../id | ../id" />
			<property name="part" type="data" value="../../name | ../name" />
			<property name="type" type="data" value="../../type | ../type" >
				<replace value="1" by="Shared Folder" />
				<replace value="2" by="VmWare" />
			</property>
			<property name="internal" type="hard-coded" value="false" />
			<property name="dgid" type="data" value="../../pool/id | ../pool/id" />
			<property name="partdesc" type="data" value="../../description | ../description" />
			<property name="dgstype" type="data" value="../../isThinEnabled | ../isThinEnabled">
				<replace value="true" by="Thin" />
				<replace value="false" by="Thick" />
			</property>
			<property name="storesid" type="data" value="../../storageResource/id | ../storageResource/id" />
			<property name="protocol" type="data" value="../../supportedProtocols | ../supportedProtocols">
				<replace value="0" by="NFS" />
				<replace value="1" by="CIFS" />
				<replace value="2" by="NFS/CIFS" />
			</property>
			<property name="ddupstat" type="data" value="../../dedupState | ../dedupState">
				<replace value="0" by="Enabled" />
				<replace value="1" by="Suspend" />
				<replace value="2" by="Disabled" />
			</property>
			<property name="dduplast" type="data" value="../../dedupLastScan | ../dedupLastScan" />
			<property name="partstat" type="data" value="../../isDedupRunning | ../isDedupRunning">
				<replace value="true" by="Running" />
				<replace value="false" by="Stopped" />
			</property>
			<property name="fsid" type="data" value="../../id | ../id" />
			<property name="fsname" type="data" value="../../name | ../name" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-CIFSSHARE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/cifsShare/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="Identifier" type="counter" unit="" value="/root/entries/entries/content/isReadOnly">
			<replace value="false" by="0" />
			<replace value="true" by="0" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-CIFSSHARE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="CifsShare" />
			<property name="partid" type="data" value="../id" />
			<property name="part" type="data" value="../name" />
			<property name="partdesc" type="data" value="../path" />
			<property name="fsid" type="data" value="../filesystem/id" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-NFSSHARE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/nfsShare/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="Identifier" type="counter" unit="" value="/root/entries/entries/content/isReadOnly">
			<replace value="false" by="0" />
			<replace value="true" by="0" />
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-NFSSHARE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="File" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="NfsExport" />
			<property name="partid" type="data" value="../id" />
			<property name="part" type="data" value="../name" />
			<property name="partdesc" type="data" value="../path" />
			<property name="fsid" type="data" value="../parentFilesystem/id" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-ETHERNETPORT" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/ethernetPort/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content/health/value">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-ETHERNETPORT" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Interface" />
			<property name="part" type="data" value="substring(../../name, 6)" />
			<property name="partid" type="data" value="../../id" />
			<property name="moverid" type="data" value="../../storageProcessorId/id">
				<replace value="spa" by="SP A" />
				<replace value="spb" by="SP B" />
			</property>
			<property name="maxspeed" type="data" value="concat(../../speed, ' Mbps')" />
			<property name="ifacemac" type="data" value="../../macAddress" />
			<property name="iftype" type="hard-coded" value="ethernetCsmacd" />
			<property name="crf" type="data" value="substring(../../id, 5)" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-FCPORT" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/fcPort/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content/health/value">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-FCPORT" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Port" />
			<property name="part" type="data" value="substring(../../name, 6)" />
			<property name="partid" type="data" value="../../id" />
			<property name="moverid" type="data" value="../../storageProcessorId/id">
				<replace value="spa" by="SP A" />
				<replace value="spb" by="SP B" />
			</property>
			<!-- should probably be currentSpeed, but https://10.244.206.85/api/types/fcPort/instances?compact=true&per_page=2000  doesn't return it (Jan 2014, old firmware) -->
			<property name="maxspeed" type="data" value="../../currentSpeed | ../../requestedSpeed">
				<replace value="32" by="32Gbps" />
				<replace value="16" by="10Gbps" />
				<replace value="8" by="8Gbps" />
				<replace value="4" by="4Gbps" />
				<replace value="2" by="2Gbps" />
				<replace value="1" by="1Gbps" />
				<replace value="0" by="Auto" />
			</property>
			<property name="partsn" type="data" value="replace(../../wwn, ':', '')" />
			<property name="iftype" type="hard-coded" value="fibreChannel" />
			<property name="crf" type="data" value="substring(../../id, 5)" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-FASTCACHE" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/fastCache/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="OperationalStatus" type="counter" unit="" value="/root[entryCount='1']/entries/entries/content/health/value | /root[entryCount='0']/entryCount">
			<!-- 8 is a custom value, to show as not configured in reports -->
			<replace value="0" by="8" />
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeTotal">
			<property-set>Properties</property-set>
		</value>
		<value name="FreeCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeFree">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-FASTCACHE" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="FAST Cache" />
			<property name="part" type="hard-coded" value="FAST Cache" />
			<property name="partid" type="data" value="../../id" />
			<property name="dgraid" type="data" value="../../raidGroups/raidGroups/raidLevel | ../raidGroups/raidGroups/raidLevel">
				<replace value="0" by="None" />
				<replace value="1" by="RAID-5" />
				<replace value="2" by="RAID-0" />
				<replace value="3" by="RAID-1" />
				<replace value="4" by="RAID-3" />
				<replace value="7" by="RAID-10" />
				<replace value="10" by="RAID-6" />
				<replace value="12" by="Mixed" />
			</property>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-FASTVP" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/fastVP/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="Availability" type="counter" unit="" value="/root/entries/entries/content/isScheduleEnabled">
			<replace value="true" by="100" />
			<replace value="false" by="0" />
			<property-set>Properties</property-set>
		</value>
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content/status">
			<property-set>Properties</property-set>
		</value>
		<value name="MovingDownCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeMovingDown">
			<property-set>Properties</property-set>
		</value>
		<value name="MovingUpCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeMovingUp">
			<property-set>Properties</property-set>
		</value>
		<value name="MovingWithinCapacity" type="counter" unit="GB" value="/root/entries/entries/content/sizeMovingWithin">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-FASTVP" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="FASTVP" />
			<property name="part" type="hard-coded" value="FASTVP" />
			<property name="partid" type="data" value="../id" />
			<property name="partdesc" type="data" value="../relocationRate">
				<replace value="1" by="High" />
				<replace value="2" by="Medium" />
				<replace value="3" by="Low" />
			</property>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-STORAGEGROUPLUNS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/hostLUN/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="PropertiesOnly" type="counter" unit="" value="/root/entries/entries/content/type">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-SGLUNS" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="LUN" />
			<property name="partid" type="data" value="../lun/id" />
			<property name="sgname" type="data" value="../host/id" />
			<property name="purpose" type="data" value="../type" >
				<replace value="1" by="Primary" /> <!-- Storage Pool lun-->
				<replace value="2" by="Local Replica" /> <!-- Snapshot lun-->
			</property>
			<property name="ispolcsu" type="data" value="../type" >
				<replace value="1" by="1" />  <!-- Storage Pool - all pool luns are consumers-->
				<replace value="2" by="1" /> <!-- Snapshot luns are consumers-->
			</property>
			<property name="ispolctr" type="hard-coded" value="0" />
			<property name="private" type="hard-coded" value="NO" />
			<property name="ismetam" type="hard-coded" value="0" />
			<property name="ismetah" type="hard-coded" value="0" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-INITIATORS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/hostInitiator/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content/health/value">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-INIT" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="Initiator" />
			<property name="partid" type="data" value="../../initiatorId" />
			<property name="sgname" type="data" value="../../parentHost/id" />
			<property name="hasinit" type="hard-coded" value="1" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="UNITY-SNAPSHOTLUNS" max-threads="10" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.JsonToNuxXmlJob" variable="source host parttype partid name">
		<data>
			<include-contexts>conf/context-unity.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host):443/api/types/lunSnap/instances?compact=true&amp;per_page=2000 [G]</input>
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
		<value name="OperationalStatus" type="counter" unit="" value="/root/entries/entries/content/operationalStatus">
			<property-set>Properties</property-set>
		</value>
		<value name="Capacity" type="counter" unit="GB" value="/root/entries/entries/content/size">
			<property-set>Properties</property-set>
		</value>
		<property-set name="Properties">
			<property name="datagrp" type="hard-coded" value="UNITY-SNAPLUNS" />
			<property name="sstype" type="hard-coded" value="Unified" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="VNXe"/>
			<property name="vendor" type="hard-coded" value="EMC Corporation"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="devtype" type="hard-coded" value="UnifiedArray" />
			<property name="parttype" type="hard-coded" value="LUN" />
			<property name="partid" type="data" value="../id" />
			<property name="part" type="data" value="../name" />
			<property name="srclun" type="data" value="../lun" />
			<property name="private" type="hard-coded" value="NO" />
			<property name="ispolctr" type="hard-coded" value="0" />
			<property name="ispolcsu" type="hard-coded" value="1" />
			<property name="purpose" type="hard-coded" value="Local Replica" />
			<property name="ismetam" type="hard-coded" value="0" />
			<property name="ismetah" type="hard-coded" value="0" />
		</property-set>
	</collecting-configuration>
</configuration>