[#ftl]
[#if use_advancedsettings]
    [#assign pollingperiod = topology.pollingperiod]
[#else]
    [#assign pollingperiod = 1200]
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
<config xmlns="http://www.watch4net.com/Collecting/InlineCalculationFilter1" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.watch4net.com/Collecting/InlineCalculationFilter1 inline-calculation-filter.xsd">
    
    <!-- Performance Calculations -->
    
    <!-- LUN Read Response Time -->
    <result name="ReadResponseTime" unit="ms" time-window="${pollingperiod}s">
        <input keep="false">EMCSampledReadsTime</input>
        <input keep="false">EMCSampledReads</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        <filter>parttype=='LUN'</filter>
        <properties propagation="all"/>
        <jexl-formula>
            <![CDATA[if ((EMCSampledReadsTime==0.0) or (EMCSampledReads==0.0)) {0.0;} else {(EMCSampledReadsTime / EMCSampledReads);}]]>
        </jexl-formula>
    </result>
    
    <!-- LUN Write Response Time -->
    <result name="WriteResponseTime" unit="ms" time-window="${pollingperiod}s">
        <input keep="false">EMCSampledWritesTime</input>
        <input keep="false">EMCSampledWrites</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        <filter>parttype=='LUN'</filter>
        <properties propagation="all"/>
        <jexl-formula>
            <![CDATA[if ((EMCSampledWritesTime==0.0) or (EMCSampledWrites==0.0)) {0.0;} else {(EMCSampledWritesTime / EMCSampledWrites);}]]>
        </jexl-formula>
    </result>
    
    <!-- Total Read IOs/sec -->
    <result name="ReadRequests" unit="IOPS" time-window="${pollingperiod}s">
        <!-- ReadIOsRate - Random READ IOs/sec -->
        <input keep="false">ReadIOsRate</input>
        <!-- EMCSequentialReadIOsRate - Sequential READ IOs/sec -->
        <input keep="false">EMCSequentialReadIOsRate</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        <filter>parttype=='LUN'</filter>
        <properties propagation="all"/>
        <jexl-formula>
            <![CDATA[(ReadIOsRate + EMCSequentialReadIOsRate);]]>
        </jexl-formula>
    </result>
    
    <!-- Total Write IOs/sec -->
    <result name="WriteRequests" unit="IOPS" time-window="${pollingperiod}s">
        <!-- WriteIOsRate - Random WRITE IOs/sec -->
        <input keep="false">WriteIOsRate</input>
        <!-- EMCSequentialWriteIOsRate - Sequential WRITE IOs/sec -->
        <input keep="false">EMCSequentialWriteIOsRate</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        <filter>parttype=='LUN'</filter>
        <properties propagation="all"/>
        <jexl-formula>
            <![CDATA[(WriteIOsRate + EMCSequentialWriteIOsRate);]]>
        </jexl-formula>
    </result>
    
    <!-- Read Thoughput -->
    <result name="ReadThroughput" unit="MB/s" time-window="${pollingperiod}s">
        <!-- KBytesRead / 1024 -->
        <input keep="false">KBytesRead</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        <filter>parttype=='LUN'</filter>
        <properties propagation="all"/>
        <jexl-formula>
            <![CDATA[(KBytesRead / 1024);]]>
        </jexl-formula>
    </result>
    
    <!-- Write Thoughput -->
    <result name="WriteThroughput" unit="MB/s" time-window="${pollingperiod}s">
        <!-- KBytesWritten / 1024 -->
        <input keep="false">KBytesWritten</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        <filter>parttype=='LUN'</filter>
        <properties propagation="all"/>
        <jexl-formula>
            <![CDATA[(KBytesWritten / 1024);]]>
        </jexl-formula>
    </result>
</config>
