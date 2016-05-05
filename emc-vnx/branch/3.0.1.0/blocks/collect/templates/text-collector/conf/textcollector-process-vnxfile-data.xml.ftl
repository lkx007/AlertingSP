<#if use_advancedsettings>
	<#assign pollingperiod = topology.pollingperiod>
<#else>
	<#assign pollingperiod = 900>
</#if>
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
<configuration xmlns="http://www.watch4net.com/TextOutputCollector" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/TextOutputCollector textoutputcollector.xsd ">
	<simultaneous-collecting>1</simultaneous-collecting>
	<polling-interval>${pollingperiod}</polling-interval>
	<refresh>3600</refresh>
	<collecting-group>group</collecting-group>
	<source>VNXFile-Collector</source>
	<collecting-configuration name="VNXFile-nfs-totalCalls" timeout="${pollingperiod}">
		<!-- from 5mins data producer -->
		<parsing-configuration-file>conf/textparsing-nfs-totalCalls.xml</parsing-configuration-file>
		<raw-value-group-list delete-after-group="true" master-node="ROW.*" variable-id="datagrp deviceid parttype movernam name">
			<timestamp-id format="yyyy/MM/dd HH:mm:ss">../Timestamp</timestamp-id>
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>File</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXFile-NFS-totalCalls</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>FileServer</hardcoded>
			</property-list>
			<property-list name="movernam">
				<position>/device</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>DataMover</hardcoded>
			</property-list>
			<property-list name="part">
				<hardcoded>NFS</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXFile-NFS-totalCalls</hardcoded>
			</property-list>
			<value-list name="TotalCalls" leaf="Total NFS Ops diff" unit="IOPS"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNXFile-TopUser" timeout="${pollingperiod}">
		<parsing-configuration-file>conf/textparsing-topn-client.xml</parsing-configuration-file>
		<raw-value-group-list delete-after-group="true" master-node="ROW_[\d]+" variable-id="datagrp deviceid parttype part client user server">
			<timestamp-id format="">Time</timestamp-id>
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>File</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXFile-TopUser</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>FileServer</hardcoded>
			</property-list>
			<property-list name="part">
				<position>/device</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>DataMover</hardcoded>
			</property-list>
			<property-list name="part">
				<position>/protocol</position>
				<replace value="nfs" by="NFS"/>
				<replace value="cifs" by="CIFS"/>
			</property-list>
			<property-list name="client">
				<position>./IP</position>
			</property-list>
			<property-list name="user">
				<position>./User</position>
			</property-list>
			<property-list name="server">
				<position>./Server</position>
			</property-list>
			<property-list name="tcalls">
				<position>./TotalOps</position>
			</property-list>
			<property-list name="wcalls">
				<position>./WriteOps</position>
			</property-list>
			<property-list name="rcalls">
				<position>./ReadOps</position>
			</property-list>
			<property-list name="scalls">
				<position>./SuspectOps</position>
			</property-list>
			<property-list name="tbytes">
				<position>./TotalBytes</position>
			</property-list>
			<property-list name="wbytes">
				<position>./WriteBytes</position>
			</property-list>
			<property-list name="rbytes">
				<position>./ReadBytes</position>
			</property-list>
			<property-list name="avgtime">
				<position>./AvgTime</position>
			</property-list>
			<value-list name="null" leaf="./AvgTime" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNXFile-Dedupe" timeout="${pollingperiod}">
		<parsing-configuration-file>./conf/textparsing-dedup.xml</parsing-configuration-file>
		<raw-value-group-list delete-after-group="true" master-node="DEDUP_[\d]+" variable-id="datagrp deviceid partid name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>File</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXFile-Dedupe</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>FileServer</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>FileSystem</hardcoded>
			</property-list>
			<property-list name="part">
				<position>./Name</position>
			</property-list>
			<property-list name="partid">
				<position>./ID</position>
			</property-list>
			<property-list name="ddupstat">
				<position>./Deduplication</position>
			</property-list>
			<property-list name="partstat">
				<position>./Status</position>
			</property-list>
			<property-list name="dduplast">
				<position>./LastScan</position>
			</property-list>
			<value-list leaf="FilesScanned" unit="Nb" name="FilesScanned"/>
			<value-list leaf="FilesDeduped" unit="Nb" name="FilesDeduped"/>
			<value-list leaf="Originaldatasize" unit="GB" name="OriginalDataSize"/>
			<value-list leaf="SpaceSaved" unit="GB" name="SpaceSaved"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNXFile-SAVVOL" timeout="${pollingperiod}">
		<parsing-configuration-file>./conf/textparsing-savvol.xml</parsing-configuration-file>
		<raw-value-group-list delete-after-group="true" master-node="ROW_[\d]+" variable-id="datagrp deviceid partid name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>File</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXFile-Savvol</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>FileServer</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Checkpoint</hardcoded>
			</property-list>
			<property-list name="part">
				<position>./name</position>
			</property-list>
			<property-list name="partid">
				<position>./ID</position>
			</property-list>
			<property-list name="ppart">
				<position>./checkpointof</position>
			</property-list>
			<value-list leaf="savvolsize" unit="GB" name="Capacity"/>
			<value-list leaf="savvolavailable" unit="GB" name="FreeCapacity"/>
			<value-list leaf="savvolused" unit="GB" name="UsedCapacity"/>
			<value-list leaf="savvolusedpercent" unit="%" name="CurrentUtilization"/>
			<value-list leaf="CkptSavVolUsedMB" unit="GB" name="UsedOnSavvol"/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNXFile-cifs-server" timeout="${pollingperiod}">
		<parsing-configuration-file>conf/textparsing-cifs.xml</parsing-configuration-file>
		<raw-value-group-list delete-after-group="true" master-node=".*Server name.*" variable-id="datagrp deviceid parttype part name">
			<timestamp-id format="yyyy/MM/dd HH:mm:ss">../Timestamp</timestamp-id>
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>File</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXFile-CIFS-server</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>FileServer</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>DataMover</hardcoded>
			</property-list>
			<property-list name="part">
				<hardcoded>CIFS</hardcoded>
			</property-list>
			<property-list name="clientfs" use-leaf-name="true">
				<position>./</position>
				<replace value="Server name (.*) CIFS (.*) diff" by="$1"/>
				<replace value="Server name (.*) CIFS Avg uSecs/call" by="$1"/>
			</property-list>
			<property-list name="name" use-leaf-name="true">
				<position>./</position>
				<replace value="Server name (.*) CIFS (.*) diff" by="$2"/>
				<replace value="Server name (.*) CIFS (Avg uSecs)/call" by="$2"/>
			</property-list>
			<value-list leaf="./" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="VNXFile-REPLICATE" timeout="${pollingperiod}">
		<parsing-configuration-file>./conf/textparsing-nas_replicate.xml</parsing-configuration-file>
		<raw-value-group-list delete-after-group="true" master-node="REPLICATE_[\d]+" variable-id="datagrp deviceid partid name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>File</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXFile-Replication</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>FileServer</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Replication</hardcoded>
			</property-list>
			<property-list name="part">
				<position>./name</position>
			</property-list>
			<property-list name="partid">
				<position>./id</position>
			</property-list>
			<property-list name="ppart">
				<position>./object</position>
				<replace value="filesystem" by="FileSystem"/>
				<replace value="vdm" by="VDM"/>
			</property-list>
			<property-list name="partstat">
				<position>./localRole</position>
			</property-list>
			<property-list name="repllast">
				<position>./lastSyncTime</position>
			</property-list>
			<property-list name="pdevice">
				<position>./remoteSystem</position>
			</property-list>
			<value-list leaf="./prevTransferRateKB" unit="MB/s" name="Throughput"/>
			<value-list leaf="./prevReadRateKB" unit="MB/s" name="ReadThroughput"/>
			<value-list leaf="./prevWriteRateKB" unit="MB/s" name="WriteThroughput"/>
			<value-list leaf="./networkStatus" unit="%" name="Availability">
				<replace value="OK" by="100"/>
				<replace value="Active" by="100"/>
				<replace value="Idle" by="100"/>
				<replace value="Stopped" by="0"/>
				<replace value="Error" by="0"/>
				<replace value="Waiting" by="0"/>
				<replace value="Info" by="100"/>
				<replace value="Critical" by="0"/>
			</value-list>
			<value-list leaf="./sourceStatus" unit="%" name="SourceStatus">
				<replace value="OK" by="100"/>
				<replace value="Active" by="100"/>
				<replace value="Idle" by="100"/>
				<replace value="Stopped" by="0"/>
				<replace value="Error" by="0"/>
				<replace value="Waiting" by="0"/>
				<replace value="Info" by="100"/>
				<replace value="Critical" by="0"/>
			</value-list>
			<value-list leaf="./destinationStatus" unit="%" name="DestinationStatus">
				<replace value="OK" by="100"/>
				<replace value="Active" by="100"/>
				<replace value="Idle" by="100"/>
				<replace value="Stopped" by="0"/>
				<replace value="Error" by="0"/>
				<replace value="Waiting" by="0"/>
				<replace value="Info" by="100"/>
				<replace value="Critical" by="0"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
</configuration>