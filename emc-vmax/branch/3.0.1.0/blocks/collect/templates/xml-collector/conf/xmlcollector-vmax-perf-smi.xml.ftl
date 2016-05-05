[#ftl]
[#if smi??]
    [#assign pollingperiod = smi.smiperf.pollingperiod]
    [#assign collectingthreads = 1]
[#else]
    [#assign pollingperiod = 3600]
    [#assign collectingthreads = 1]
[/#if]
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
    <simultaneous-collecting>${collectingthreads}</simultaneous-collecting>
    <polling-interval>${pollingperiod}</polling-interval>
    <collecting-group>group</collecting-group>
    <source>VMAX-Collector</source>
    <refresh>0</refresh>
[#if vmax??]
    [#list vmax as vmax]
    [#assign serialnb = vmax.serialnb?string]
    <collecting-configuration id="VMAX-SMI-PERF-ARRAY-${serialnb?left_pad(12, "0")}" max-threads="1" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" variable="source device parttype part name">
        <data>
            <include-contexts>conf/smi-context.xml</include-contexts>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
            
            <input/>
            
            <host/>
            
            <parameter name="disable-ssl-authentication">
                <value>true</value>
            </parameter>
            
            <parameter name="username">
                <value>@username</value>
            </parameter>
            
            <parameter name="password">
                <value>@password</value>
            </parameter>
            
            <parameter name="connect-type">
                <value>all</value>
            </parameter>
            
            <parameter name="input-file">
                <value>conf/GetStatisticsCollection-Array-${serialnb}.request</value>
            </parameter>
            
            <parameter name="request-1">
                <!-- The file to send to the web service -->
                <value>conf/GetStatisticsCollection-Array-${serialnb}.request</value>
                
                <!-- The XSL file to use to transform the response into the second request -->
                <value>conf/smi-arraymetrics-csv2xml-out.xslt</value>
                
                <!-- The error handling mode (either strict or lenient) -->
                <value>strict</value>
                
                <!-- The URL of the web service -->
                <value>@url</value>
                
                <!-- The specific headers to include with this header -->
                <value>CIMProtocolVersion:1.0;CIMOperation:MethodCall;CIMMethod:GetStatisticsCollection;CIMObject:root/emc:Symm_BlockStatisticsService.CreationClassName="Symm_BlockStatisticsService",Name="EMCBlockStatisticsService",SystemCreationClassName="Symm_StorageSystem",SystemName="SYMMETRIX+${serialnb?left_pad(12, "0")}"</value>
            </parameter>

            <parameter name="output-folder">
                <value>tmp/smi-arraymetricsout/</value>
            </parameter>
            
            <parameter name="data-timeout">
                <value>3600</value>
            </parameter>
            <parameter name="connection-timeout">
                <value>3600</value>
            </parameter>
        </data>
        
        <timestamp format="yyyyMMddHHmmss">/STAT/StatisticTime</timestamp>
        <value name="TotalIOs" type="delta" unit="Nb" value="/STATS/STAT/TotalIOs">
            <property-set>Properties</property-set>
        </value>
        <value name="KBTransferred" type="delta" unit="KB" value="/STATS/STAT/KBytesTransferred">
            <property-set>Properties</property-set>
        </value>
        <value name="ReadIOs" type="delta" unit="Nb" value="/STATS/STAT/ReadIOs">
            <property-set>Properties</property-set>
        </value>
        <value name="ReadHitIOs" type="delta" unit="Nb" value="/STATS/STAT/ReadHitIOs">
            <property-set>Properties</property-set>
        </value>
        <value name="KBytesRead" type="delta" unit="Nb" value="/STATS/STAT/KBytesRead">
            <property-set>Properties</property-set>
        </value>
        <property-set name="Properties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix" />
            <property name="devtype" type="hard-coded" value="Array" />
            <property name="datagrp" type="hard-coded" value="VMAX-ARRAY" />
            <property name="device" type="data" value="../Array"/>
        </property-set>
    </collecting-configuration>
    [/#list]
[/#if]
    
[#if vmax??]
    [#list vmax as vmax]
    [#assign serialnb = vmax.serialnb?string]
    <collecting-configuration id="VMAX-SMI-PERF-VOLUMES-${serialnb?left_pad(12, "0")}" max-threads="1" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" variable="source device parttype part name">
        <for-each>STAT</for-each>
        <data>
            <include-contexts>conf/smi-context.xml</include-contexts>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
            
            <input/>
            
            <host/>
            
            <parameter name="disable-ssl-authentication">
                <value>true</value>
            </parameter>
            
            <parameter name="username">
                <value>@username</value>
            </parameter>
            
            <parameter name="password">
                <value>@password</value>
            </parameter>
            
            <parameter name="connect-type">
                <value>all</value>
            </parameter>
            
            <parameter name="input-file">
                <value>conf/GetStatisticsCollection-Volumes-${serialnb}.request</value>
            </parameter>
            
            <parameter name="request-1">
                <!-- The file to send to the web service -->
                <value>conf/GetStatisticsCollection-Volumes-${serialnb}.request</value>
                
                <!-- The XSL file to use to transform the response into the second request -->
                <value>conf/smi-volumemetrics-csv2xml-out.xslt</value>
                
                <!-- The error handling mode (either strict or lenient) -->
                <value>strict</value>
                
                <!-- The URL of the web service -->
                <value>@url</value>
                
                <!-- The specific headers to include with this header -->
                <value>CIMProtocolVersion:1.0;CIMOperation:MethodCall;CIMMethod:GetStatisticsCollection;CIMObject:root/emc:Symm_BlockStatisticsService.CreationClassName="Symm_BlockStatisticsService",Name="EMCBlockStatisticsService",SystemCreationClassName="Symm_StorageSystem",SystemName="SYMMETRIX+${serialnb?left_pad(12, "0")}"</value>
            </parameter>

            <parameter name="output-folder">
                <value>tmp/smi-volumemetricsout/</value>
            </parameter>
            
            <parameter name="data-timeout">
                <value>3600</value>
            </parameter>
            <parameter name="connection-timeout">
                <value>3600</value>
            </parameter>
        </data>
        
        <timestamp format="yyyyMMddHHmmss">/STAT/StatisticTime</timestamp>
        
        <value name="EMCSampledReads" type="delta" unit="Nb" value="/STAT/EMCSampledReads">
            <property-set>Properties</property-set>
        </value>
        
        <value name="EMCSampledReadsTime" type="delta" unit="ms" value="/STAT/EMCSampledReadsTime">
            <property-set>Properties</property-set>
        </value>
        
        <value name="KBytesRead" type="rate" unit="KB/s" value="/STAT/KBytesRead">
            <property-set>Properties</property-set>
        </value>
        
        <value name="ReadIOsRate" type="rate" unit="IOPS" value="/STAT/ReadIOs">
            <property-set>Properties</property-set>
        </value>
        
        <value name="EMCSequentialReadIOsRate" type="rate" unit="IOPS" value="/STAT/EMCSequentialReadIOs">
            <property-set>Properties</property-set>
        </value>
        
        <value name="EMCSampledWrites" type="delta" unit="Nb" value="/STAT/EMCSampledWrites">
            <property-set>Properties</property-set>
        </value>
        
        <value name="EMCSampledWritesTime" type="delta" unit="ms" value="/STAT/EMCSampledWritesTime">
            <property-set>Properties</property-set>
        </value>
        
        <value name="EMCSequentialWriteIOsRate" type="rate" unit="IOPS" value="/STAT/EMCSequentialWriteIOs">
            <property-set>Properties</property-set>
        </value>
        
        <value name="WriteIOsRate" type="rate" unit="IOPS" value="/STAT/WriteIOs">
            <property-set>Properties</property-set>
        </value>
        
        <value name="KBytesWritten" type="rate" unit="KB/s" value="/STAT/KBytesWritten">
            <property-set>Properties</property-set>
        </value>
        
        <property-set name="Properties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix" />
            <property name="devtype" type="hard-coded" value="Array" />
            <property name="datagrp" type="hard-coded" value="VMAX-SMIPERF-DEVICES" />
            <property name="device" type="data" value="../Array"/>
            <property name="parttype" type="hard-coded" value="LUN" />
            <property name="part" type="data" value="substring(../Volume, 2, 4)"/>
            <property name="volcsv" type="data" value="../CSV"/>
        </property-set>
    </collecting-configuration>
    [/#list]
[/#if]
</configuration>