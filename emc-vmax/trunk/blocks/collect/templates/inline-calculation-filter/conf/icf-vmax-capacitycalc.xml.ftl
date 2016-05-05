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

    <!-- Array RAID Overhead Capacity -->
    <result name="RAIDOverheadCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">ConfiguredRawCapacity</input>
        <input keep="true">ConfiguredUsableCapacity</input>
        <group-by>device</group-by>
        <filter><![CDATA[devtype=='Array' & datagrp=='VMAX-SAF']]></filter>
        <properties propagation="all" />
        <jexl-formula><![CDATA[(ConfiguredRawCapacity - ConfiguredUsableCapacity)]]></jexl-formula>
    </result>

    <!-- Array Unusable Capacity -->
    <result name="UnusableCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">RawCapacity</input>
        <input keep="true">UnconfiguredCapacity</input>
        <input keep="true">ConfiguredRawCapacity</input>
        <input keep="true">HotSpareCapacity</input>
        <group-by>device</group-by>
        <filter><![CDATA[devtype=='Array' & datagrp=='VMAX-SAF']]></filter>
        <properties propagation="all" />
        <jexl-formula><![CDATA[RawCapacity - (UnconfiguredCapacity + ConfiguredRawCapacity + HotSpareCapacity)]]></jexl-formula>
    </result>

    <!-- Array Block Used Capacity -->
    <result name="BlockUsedCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">UsedCapacity</input>
        <input keep="true">FileUsedCapacity</input>
        <input keep="true">VirtualUsedCapacity</input>
        <group-by>device</group-by>
        <filter><![CDATA[devtype=='Array' & datagrp=='VMAX-SAF' & !parttype]]></filter>
        <properties propagation="all" />
        <jexl-formula><![CDATA[(UsedCapacity - FileUsedCapacity - VirtualUsedCapacity)]]></jexl-formula>
    </result>

    <!-- System Resource Service Level Free Capacity should always be zero -->
    <result name="FreeCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">Capacity</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        
        <filter><![CDATA[devtype=='Array' & datagrp=='VMAX-SAF' & parttype=='Service Level' & svclevel=='System Resource' 
                        & name=='Capacity']]></filter>
        <properties propagation="all" />
        <jexl-formula><![CDATA[0]]></jexl-formula>
    </result>
    
    <!-- Pool Contributor Service Level Used Capacity should always be zero -->
    <result name="UsedCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">Capacity</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        
        <filter><![CDATA[devtype=='Array' & datagrp=='VMAX-SAF' & parttype=='Service Level' & svclevel=='Pool Contributor' 
                        & name=='Capacity']]></filter>
        <properties propagation="all" />
        <jexl-formula><![CDATA[0]]></jexl-formula>
    </result>
    
    <!-- Pool Contributor Service Level Free Capacity should always be zero -->
    <result name="FreeCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">Capacity</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        
        <filter><![CDATA[devtype=='Array' & datagrp=='VMAX-SAF' & parttype=='Service Level' & svclevel=='Pool Contributor' 
                        & name=='Capacity']]></filter>
        <properties propagation="all" />
        <jexl-formula><![CDATA[0]]></jexl-formula>
    </result>
    
    <!-- Array Pool Used Capacity -->
    <result name="PoolUsedCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">PoolUsableCapacity</input>
        <input keep="true">PoolFreeCapacity</input>
        <group-by>device</group-by>
        
        <filter><![CDATA[devtype=='Array' & datagrp=='VMAX-SAF' & !parttype]]></filter>
        <properties propagation="all" />
        <jexl-formula><![CDATA[(PoolUsableCapacity - PoolFreeCapacity)]]></jexl-formula>
    </result>
    
    <!-- Pool Block Used Capacity -->
    <!-- Note: this calculation cannot be performed in icf-vmax-capacitycalc.xml because Storage Pool UsedCapacity is computed there. -->
    <result name="BlockUsedCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">UsedCapacity</input>
        <input keep="true">FileUsedCapacity</input>
        <input keep="true">VirtualUsedCapacity</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>pooltype</group-by>
        <group-by>part</group-by>
        <filter><![CDATA[devtype=='Array' & parttype=='Storage Pool']]></filter>
        <properties propagation="all" />
        <jexl-formula><![CDATA[(UsedCapacity - FileUsedCapacity - VirtualUsedCapacity)]]></jexl-formula>
    </result>
    
    <!-- Pool Subscribed Capacity -->
    <result name="SubscribedCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">Subscription</input>
        <input keep="true">EnabledCapacity</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>pooltype</group-by>
        <group-by>part</group-by>
        
        <filter><![CDATA[devtype=='Array' & pooltype=='Thin Pool']]></filter>
        <properties propagation="all" />
        <jexl-formula><![CDATA[(Subscription / 100 * EnabledCapacity)]]></jexl-formula>
    </result>
    
    <!-- Pool Oversubscribed Capacity -->
    <result name="OversubscribedCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">Subscription</input>
        <input keep="true">EnabledCapacity</input>
        <input keep="true">Capacity</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>pooltype</group-by>
        <group-by>part</group-by>
        
        <filter><![CDATA[devtype=='Array' & pooltype=='Thin Pool']]></filter>
        <properties propagation="all" />
        <jexl-formula><![CDATA[if (((Subscription / 100) * EnabledCapacity) > Capacity) {(((Subscription / 100) * EnabledCapacity) - Capacity)} else {0}]]></jexl-formula>
    </result>
</config>
