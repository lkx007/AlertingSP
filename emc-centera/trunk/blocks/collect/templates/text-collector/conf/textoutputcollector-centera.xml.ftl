[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<configuration xmlns="http://www.watch4net.com/TextOutputCollector"	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/TextOutputCollector textoutputcollector.xsd ">
	<simultaneous-collecting>1</simultaneous-collecting>
[#if emccentera.topo??]
	<polling-interval>${emccentera.topo.pollingperiod}</polling-interval>
[#else]
	<polling-interval>900</polling-interval>
[/#if]
	<collecting-group>group</collecting-group>
	<source>Centera-Collector</source>
	<collecting-configuration name="CENTERA-CONFIGOWNER" timeout="900">
		<parsing-configuration-file>conf/parser-configowner.xml</parsing-configuration-file>
		<raw-value-group-list master-node="CLUSTER_\d+" delete-after-group="false" variable-id="serialnb datagrp">
			<property-list name="serialnb">
				<position>SerialNumber</position>
			</property-list>
			<property-list name="device">
				<position>Name</position>
			</property-list>
			<property-list name="devtype">
				<hardcoded>CAS-Cluster</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>Centera</hardcoded>
			</property-list>
			<property-list name="ip">
				<position>/</position>
			</property-list>
			<property-list name="devdesc">
				<hardcoded>CASCluster</hardcoded>
			</property-list>
			<value-list name="RemoveMe" leaf="RemoveMe" unit="">
				<replace value="" by="1"/>
				<replace value=" " by="1"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="CENTERA-CAPACITY-AVAILABILITY" timeout="900">
		<parsing-configuration-file>conf/parser-capacityavailability.xml</parsing-configuration-file>
		<raw-value-group-list master-node="CLUSTER_\d+" delete-after-group="false" variable-id="serialnb datagrp name">
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>CAS-Cluster</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>Centera</hardcoded>
			</property-list>
			<property-list name="ip">
				<position>/</position>
			</property-list>
			<property-list name="devdesc">
				<hardcoded>CASCluster</hardcoded>
			</property-list>
			<property-list name="sysbufu">
				<position>SystemBufferUnit</position>
			</property-list>
			<property-list name="regenbu">
				<position>RegenerationBufferUnit</position>
			</property-list>
			<property-list name="availcapu">
				<position>AvailableCapacityUnit</position>
			</property-list>
			<property-list name="totobju">
				<position>TotalObjectCountUnit</position>
			</property-list>
			<property-list name="usedobju">
				<position>UsedObjectCountUnit</position>
			</property-list>
			<property-list name="freeobju">
				<position>FreeObjectCountUnit</position>
			</property-list>
			<value-list name="SystemBuffer" leaf="SystemBuffer" unit="GB"/>
			<value-list name="RegenerationBuffer" leaf="RegenerationBuffer" unit="GB"/>
			<value-list name="AvailableCapacity" leaf="AvailableCapacity" unit="GB"/>
			<value-list name="TotalObjectCount" leaf="TotalObjectCount" unit=""/>
			<value-list name="UsedObjectCount" leaf="UsedObjectCount" unit=""/>
			<value-list name="FreeObjectCount" leaf="FreeObjectCount" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="CENTERA-CAPACITY-TOTAL" timeout="900">
		<parsing-configuration-file>conf/parser-capacitytotal.xml</parsing-configuration-file>
		<raw-value-group-list master-node="CLUSTER_\d+" delete-after-group="false" variable-id="serialnb datagrp name">
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>CAS-Cluster</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>Centera</hardcoded>
			</property-list>
			<property-list name="ip">
				<position>/</position>
			</property-list>
			<property-list name="devdesc">
				<hardcoded>CASCluster</hardcoded>
			</property-list>
			<property-list name="trawcapu">
				<position>TotalRawCapacityUnit</position>
			</property-list>
			<property-list name="urawcapu">
				<position>UsedRawCapacityUnit</position>
			</property-list>
			<property-list name="frawcapu">
				<position>FreeRawCapacityUnit</position>
			</property-list>
			<property-list name="sysresu">
				<position>SystemResourcesUnit</position>
			</property-list>
			<property-list name="offcapu">
				<position>OfflineCapacityUnit</position>
			</property-list>
			<property-list name="spcapu">
				<position>SpareCapacityUnit</position>
			</property-list>
			<property-list name="usdcapu">
				<position>UsedCapacityUnit</position>
			</property-list>
			<property-list name="amcapu">
				<position>AuditAndMetadataUnit</position>
			</property-list>
			<property-list name="prusrdtu">
				<position>ProtectedUserDataUnit</position>
			</property-list>
			<property-list name="userobju">
				<position>UserObjectCountUnit</position>
			</property-list>
			<value-list name="TotalRawCapacity" leaf="TotalRawCapacity" unit="GB"/>
			<value-list name="UsedRawCapacity" leaf="UsedRawCapacity" unit="GB"/>
			<value-list name="FreeRawCapacity" leaf="FreeRawCapacity" unit="GB"/>
			<value-list name="SystemResources" leaf="SystemResources" unit="GB"/>
			<value-list name="OfflineCapacity" leaf="OfflineCapacity" unit="GB"/>
			<value-list name="SpareCapacity" leaf="SpareCapacity" unit="GB"/>
			<value-list name="UsedCapacity" leaf="UsedCapacity" unit="GB"/>
			<value-list name="AuditAndMetadataCapacity" leaf="AuditAndMetadataCapacity" unit="GB"/>
			<value-list name="ProtectedUserData" leaf="ProtectedUserData" unit="GB"/>
			<value-list name="UserObjectCount" leaf="UserObjectCount" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="CENTERA-NODE-DETAIL" timeout="900">
		<parsing-configuration-file>conf/parser-nodedetails.xml</parsing-configuration-file>
		<raw-value-group-list master-node="NODE_\d+" delete-after-group="false" variable-id="serialnb datagrp part parttype name">
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>CAS-Cluster</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>Centera</hardcoded>
			</property-list>
			<property-list name="ip">
				<position>/</position>
			</property-list>
			<property-list name="devdesc">
				<hardcoded>CASCluster</hardcoded>
			</property-list>
			<property-list name="part">
				<position>NodeName</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Node</hardcoded>
			</property-list>
			<property-list name="nodeser">
				<position>NodeSerialNumber</position>
			</property-list>
			<property-list name="status">
				<position>Status</position>
			</property-list>
			<property-list name="roles">
				<position>Roles</position>
			</property-list>
			<property-list name="ndmodel">
				<position>Model</position>
			</property-list>
			<property-list name="softver">
				<position>SoftwareVersion</position>
			</property-list>
			<property-list name="hasmodem">
				<position>ModemPresent</position>
			</property-list>
			<property-list name="extip">
				<position>ExternalIP</position>
			</property-list>
			<property-list name="intip">
				<position>InternalIP</position>
			</property-list>
			<property-list name="ntcapu">
				<position>TotalCapacityUnit</position>
			</property-list>
			<property-list name="nucapu">
				<position>UsedCapacityUnit</position>
			</property-list>
			<property-list name="nfcapu">
				<position>FreeCapacityUnit</position>
			</property-list>
			<property-list name="nfacapu">
				<position>FaultedCapacityUnit</position>
			</property-list>
			<value-list name="TotalCapacity" leaf="TotalCapacity" unit="GB"/>
			<value-list name="UsedCapacity" leaf="UsedCapacity" unit="GB"/>
			<value-list name="FreeCapacity" leaf="FreeCapacity" unit="GB"/>
			<value-list name="FaultedCapacity" leaf="FaultedCapacity" unit="GB"/>
			<value-list name="TotalObjectsStored" leaf="TotalNumberObjectsStored" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="CENTERA-POOL-CAPACITY" timeout="900">
		<parsing-configuration-file>conf/parser-poolcapacity.xml</parsing-configuration-file>
		<raw-value-group-list master-node="POOL_\d+" delete-after-group="false" variable-id="serialnb datagrp part parttype name">
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>CAS-Cluster</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>Centera</hardcoded>
			</property-list>
			<property-list name="ip">
				<position>/</position>
			</property-list>
			<property-list name="devdesc">
				<hardcoded>CASCluster</hardcoded>
			</property-list>
			<property-list name="part">
				<position>PoolName</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Storage Pool</hardcoded>
			</property-list>
			<property-list name="paqcapu">
				<position>AlertQuotaCapacityUnit</position>
			</property-list>
			<property-list name="phscapu">
				<position>HardStopCapacityUnit</position>
			</property-list>
			<property-list name="pusdcapu">
				<position>UsedCapacityUnit</position>
			</property-list>
			<value-list name="AlertQuotaCapacity" leaf="AlertQuotaCapacity" unit="GB">
				<replace value="-" by="0" />
			</value-list>
			<value-list name="HardStopCapacity" leaf="HardStopCapacity" unit="GB">
				<replace value="-" by="0" />
			</value-list>
			<value-list name="UsedCapacity" leaf="UsedCapacity" unit="GB"/>
			<value-list name="CClips" leaf="CClips" unit=""/>
			<value-list name="Files" leaf="Files" unit=""/>
		</raw-value-group-list>
	</collecting-configuration>
	<collecting-configuration name="CENTERA-PROFILES" timeout="900">
		<parsing-configuration-file>conf/parser-profiles.xml</parsing-configuration-file>
		<raw-value-group-list master-node="PROFILE_\d+" delete-after-group="false" variable-id="serialnb datagrp part parttype name">
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>CAS-Cluster</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>Centera</hardcoded>
			</property-list>
			<property-list name="ip">
				<position>/</position>
			</property-list>
			<property-list name="devdesc">
				<hardcoded>CASCluster</hardcoded>
			</property-list>
			<property-list name="part">
				<position>ProfileName</position>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Profile</hardcoded>
			</property-list>
			<property-list name="homepool">
				<position>HomePool</position>
			</property-list>
			<property-list name="cfgusage">
				<position>ConfiguredUsage</position>
			</property-list>
			<value-list name="Enabled" leaf="Enabled" unit="">
				<replace value="yes" by="1" />
				<replace value="no" by="0" />
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
</configuration>