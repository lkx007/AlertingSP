[#ftl]
[#assign pollingperiod = topology.pollingperiod]
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
<configuration xmlns="http://www.watch4net.com/XMLCollector" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xsi:schemaLocation="http://www.watch4net.com/XMLCollector xmlcollector.xsd ">
    
    <simultaneous-collecting>1</simultaneous-collecting>
    <polling-interval>${pollingperiod}</polling-interval>
    <collecting-group>group</collecting-group>
    <source>VMAX-Alerts-Collector</source>
    <refresh>3600</refresh>
    
    <collecting-configuration id="VMAX-CLI-ALERTS" variable="source device parttype part event_code_symbol severity name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Event</for-each>
		<data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
		<input>conf/vmax-alert.cmd symevent -output XML -sid (host) -${symapi.severity} list</input>
[#else]
		<input>conf/vmax-alert.sh symevent -output XML -sid (host) -${symapi.severity} list</input>
[/#if]
[#if vmax??]
[#list vmax as vmax]
[#assign serialnb = vmax.serialnb?string]
            <host>${serialnb?left_pad(12, "0")}</host>
[/#list]
[/#if]
            <parameter name="connect-type">
                <value>all</value>
            </parameter>
            <parameter name="data-timeout">
                <value>${pollingperiod}</value>
            </parameter>
            <parameter name="connection-timeout">
                <value>${pollingperiod}</value>
            </parameter>
        </data>
        <timestamp type="use-system-time"/>
        <value name="AlertSeverity" value="/Event/severity" >
            <replace value="Fatal" by="100"/>
            <replace value="Error" by="75"/>
            <replace value="Warning" by="50"/>
            <property-set>symProperties</property-set>
        </value>
        <property-set name="symProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-CLI-ALERTS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="Array-Alerts"/>
            <property name="part" type="data" value="../director"/>
            <property name="director" type="data" value="../director"/>
            <property name="alerttime" type="data" value="../time"/>
            <property name="alertsource" type="data" value="../source"/>
            <property name="category" type="data" value="../category"/>
            <property name="severity" type="data" value="../severity"/>
            <property name="numericcode" type="data" value="../numeric_code"/>
            <property name="eventcodesymbol" type="data" value="../event_code_symbol"/>
            <property name="description" type="data" value="../description"/>
            <property name="devname" type="data" value="if (exists(../dev_name)) then (../dev_name) else (string('N/A'))"/>
            <property name="ragroupnum" type="data" value="if (exists(../ra_group_num)) then (../ra_group_num) else (string('N/A'))"/>			
        </property-set>
    </collecting-configuration>
</configuration>
