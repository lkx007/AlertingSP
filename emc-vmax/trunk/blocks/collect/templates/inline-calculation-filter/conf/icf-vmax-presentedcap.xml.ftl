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
    
    <!-- Thick LUN Presented Capacity -->
    <!-- Thick LUN Presented Capacity is the same as UsedCapacity -->
    <result name="PresentedCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">UsedCapacity</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        <filter><![CDATA[devtype=='Array' & parttype=='LUN' & dgstype=='Thick' & !(purpose=='System Resource' | ispolctr=='1')]]>
        </filter>
        <properties propagation="all"/>
        <jexl-formula>
            <![CDATA[(UsedCapacity);]]>
        </jexl-formula>
    </result>
    
    <!-- Thin LUN Presented Capacity -->
    <!-- Thin LUN UsedCapacity is SubscribedCapacity -->
    <result name="PresentedCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">SubscribedCapacity</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        <filter><![CDATA[devtype=='Array' & parttype=='LUN' & dgstype=='Thin' & config='%TDEV%']]>
        </filter>
        <properties propagation="all"/>
        <jexl-formula>
            <![CDATA[(SubscribedCapacity);]]>
        </jexl-formula>
    </result>
    
    <!-- VDEV Presented Capacity -->
    <!--  -->
    <result name="PresentedCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">Capacity</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        <filter><![CDATA[devtype=='Array' & parttype=='LUN' & dgstype=='Thin' & config='%VDEV%']]>
        </filter>
        <properties propagation="all"/>
        <jexl-formula>
            <![CDATA[(Capacity);]]>
        </jexl-formula>
    </result>
    
    <!-- System Resource, SAVE Device, DATA Device, DLDEV Presented Capacity -->
    <result name="PresentedCapacity" unit="GB" time-window="${pollingperiod}s">
        <input keep="true">UsedCapacity</input>
        <group-by>device</group-by>
        <group-by>parttype</group-by>
        <group-by>part</group-by>
        <filter><![CDATA[devtype=='Array' & parttype=='LUN' & 
                            (purpose=='System Resource' | ispolctr=='1' | config='%DLDEV%')]]>
        </filter>
        <properties propagation="all"/>
        <jexl-formula>
            <![CDATA[(0);]]>
        </jexl-formula>
    </result>
</config>
