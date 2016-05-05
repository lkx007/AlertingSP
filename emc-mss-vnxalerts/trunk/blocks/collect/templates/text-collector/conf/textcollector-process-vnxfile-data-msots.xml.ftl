[#ftl]
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
	<polling-interval>[#if use_advancedsettings]${topology.pollingperiod}[#else]600[/#if]</polling-interval>
	<refresh>3600</refresh>
	<collecting-group>group</collecting-group>
	<source>VNXFile-Collector</source>
	<collecting-configuration name="VNXFile-DataMover-Interface" timeout="300">
		<parsing-configuration-file>./conf/textparsing-interface.xml</parsing-configuration-file>
		<raw-value-group-list delete-after-group="true" master-node="LINK_\d+" variable-id="datagrp deviceid partid parttype part name">
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
				<hardcoded>VNXFile-Interface</hardcoded>
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
				<hardcoded>Interface</hardcoded>
			</property-list>
			<property-list name="datamoverid">
				<position>../DmID</position>
			</property-list> 
			<property-list name="part">
				<position>./LinkName</position>
			</property-list>
			<property-list name="partid">
				<position>../DmID</position>
			</property-list> 
			<property-list name="partstat">
				<position>./LinkState</position>
			</property-list>			
			<value-list name="status" leaf="./LinkState" unit="%" >
                                <replace value="Up" by="100"/>
                                <replace value="Down" by="0"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
</configuration>
