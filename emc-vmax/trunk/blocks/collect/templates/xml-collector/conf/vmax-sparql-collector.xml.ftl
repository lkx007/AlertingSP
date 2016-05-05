<#ftl>
<#if use_topo>
	<#assign host = topologyservice.host>
	<#assign port = topologyservice.gateway.port>
	<#assign username = topologyservice.gateway.username>
	<#assign password = topologyservice.gateway.password>
<#else>
	<#assign host = 'localhost'>
	<#assign port = 48443>
	<#assign username = 'admin'>
	<#assign password = 'changeme'>
</#if>
<#if use_advancedsettings>
	<#assign pollingperiod = topology.pollingperiod>
<#else>
	<#assign pollingperiod = 900>
</#if>
<?xml version="1.0" encoding="UTF-8"?>
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
<configuration xmlns="http://www.watch4net.com/XMLCollector" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/XMLCollector xmlcollector.xsd ">

	<simultaneous-collecting>1</simultaneous-collecting>
	<polling-interval>${pollingperiod}</polling-interval>
	<collecting-group>group</collecting-group>
	<source>VMAX</source>
	<refresh>3600</refresh>

	<!-- Generate new metric based on the topology service replica chain path data -->
	<collecting-configuration id="VMAX-SPARQL-TOPO-REPLICAPATH" max-threads="10" timeout="${pollingperiod}" variable="rcpathid">
		<for-each namespace-uri="http://www.w3.org/2005/sparql-results#">result</for-each>
		<data>
			<include-contexts>conf/context-vmax-sparql.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://@hostport/Backends/Topology-Service/Default/topology/repository/sparql[P]</input>
			<host>@hostport</host>
			<parameter name="headers">
				<value>Accept:application/xml</value>
				<value>Content-Type:application/x-www-form-urlencoded</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="disableSSLValidation">
				<value>true</value>
			</parameter>
			<parameter name="input-file"><value>conf/requests/ReplicaPath-Sparql.request</value></parameter>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="connect-type">
				<value>all</value>
			</parameter>
			<parameter name="data-timeout">
				<value>120</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>120</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="ReplicaPath" unit="GB" value="/result/binding[@name='capacity']/literal">
			<property-set>properties-capacity</property-set>
		</value>
		<property-set name="properties-capacity">
			<property name="w4ncert" type="hard-coded" value="1.0" />
			<property name="datatype" type="hard-coded" value="Block" />
			<property name="sstype" type="hard-coded" value="Block" />
			<property name="arraytyp" type="hard-coded" value="Symmetrix" />
			<property name="devtype" type="hard-coded" value="Array" />
			<property name="datagrp" type="hard-coded" value="VMAX-ReplicaPath" />
			<property name="rcpathid" type="data" value="../../binding[@name='rcpathid']/literal" />
			<property name="device" type="data" value="../../binding[@name='device']/literal" />
			<property name="parttype" type="hard-coded" value="LUN" />
			<property name="part" type="data" value="../../binding[@name='part']/literal" />
			<property name="rep1arry" type="data" value="../../binding[@name='rep1arry']/literal" />
			<property name="rep1lun" type="data" value="../../binding[@name='rep1lun']/literal" />
			<property name="rep2arry" type="data" value="../../binding[@name='rep2arry']/literal" >
				<replace value="" by="N/A"/>
			</property>
			<property name="rep2lun" type="data" value="../../binding[@name='rep2lun']/literal" >
				<replace value="" by="N/A"/>
			</property>
			<property name="rep3arry" type="data" value="../../binding[@name='rep3arry']/literal" >
				<replace value="" by="N/A"/>
			</property>
			<property name="rep3lun" type="data" value="../../binding[@name='rep3lun']/literal" >
				<replace value="" by="N/A"/>
			</property>
		</property-set>
	</collecting-configuration>

</configuration>
