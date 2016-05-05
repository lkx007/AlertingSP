<#if use_advancedsettings>
    <#assign pollingperiod = topology.pollingperiod>
<#else>
    <#assign pollingperiod = 1200>
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
<config xmlns="http://www.watch4net.com/spatial-aggregation-handler" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.watch4net.com/spatial-aggregation-handler spatial-aggregation-handler.xsd">

    <!-- Array Unconfigured Capacity -->
    <!-- Rollup Array UnconfiguredCapacity using sum(Disk.FreeCapacity) -->
    <aggregation id="VMAX-Collector-UnconfiguredCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='Disk' &amp; name=='FreeCapacity' &amp; !(diskfail=='1'))
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">UnconfiguredCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
            
            <remove name="parttype" />
            <remove name="part" />
            <remove name="diskgrp" />
            <remove name="raidgrp" />
            <remove name="dgname" />
            <remove name="partvend" />
            <remove name="director" />
            <remove name="partver" />
            <remove name="partmode" />
            <remove name="disktype" />
            <remove name="diskrpm" />
            <remove name="hypers" />
        </properties>
    </aggregation>

    <!-- Array Hot Spare Capacity -->
    <!-- Rollup Array's HotSpareCapacity using sum(HotSpare Disk Capacity) -->
    <aggregation id="VMAX-Collector-HotSpareCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='Disk' &amp; partmode=='Hot spare' 
                    &amp; name=='Capacity' &amp; !(diskfail=='1'))
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')
        </filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">HotSpareCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
            
            <remove name="parttype" />
            <remove name="part" />
            <remove name="diskgrp" />
            <remove name="raidgrp" />
            <remove name="dgname" />
            <remove name="partvend" />
            <remove name="director" />
            <remove name="partver" />
            <remove name="partmode" />
            <remove name="disktype" />
            <remove name="diskrpm" />
            <remove name="hypers" />
        </properties>
    </aggregation>
    
    <aggregation id="VMAX-Collector-ExternalCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='Disk' &amp; name=='Capacity' 
                    &amp; (diskloc=='External' | diskloc=='Encapsulated') &amp; !(diskfail=='1'))
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">ExternalCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
            
            <remove name="parttype" />
            <remove name="part" />
            <remove name="partstat"/>
            <remove name="dgstype"/>
            <remove name="poolemul"/>
            <remove name="raidtype"/>
        </properties>
    </aggregation>

    <!-- Array Configured Usable -->
    <!-- Rollup Array's ConfiguredUsableCapacity using sum(LUN.Capacity) for LUNs that are not VDEV or TDEV -->
    <aggregation id="VMAX-Collector-ConfiguredUsableCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' 
                    &amp; name=='Capacity' &amp; dgstype=='Thick')
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')
        </filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">ConfiguredUsableCapacity</add>
            <add name="devtype">Array</add>
            <add name="dgstype">Thick</add>
            <add name="unit">GB</add>
            
            <remove name="part" />
            <remove name="diskgrp" />
            <remove name="raidgrp" />
            <remove name="dgname" />
            <remove name="partvend" />
            <remove name="director" />
            <remove name="partver" />
            <remove name="partmode" />
            <remove name="disktype" />
            <remove name="diskrpm" />
            <remove name="hypers" />
            <remove name="roc1" />
            <remove name="roc2" />
            <remove name="partsn" />
            <remove name="pdname" />
            <remove name="poolname" />
            <remove name="partconf" />
            <remove name="config" />
            <remove name="hypercnt" />
        </properties>
    </aggregation>

    <!-- Array Raw (Disk) Capacity -->
    <!-- Rollup Array's RawCapacity using sum(Disk Capacity) -->
    <aggregation id="VMAX-Collector-RawCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='Disk' &amp; name=='Capacity' &amp; !(diskfail=='1'))
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">RawCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
            <remove name="parttype" />
            <remove name="part" />
            <remove name="diskgrp" />
            <remove name="raidgrp" />
            <remove name="dgname" />
            <remove name="partvend" />
            <remove name="director" />
            <remove name="partver" />
            <remove name="partmode" />
            <remove name="disktype" />
            <remove name="diskrpm" />
            <remove name="hypers" />
        </properties>
    </aggregation>

    <!-- Array Configured Raw (LUN) Capacity -->
    <!-- Rollup Array's ConfiguredRawCapacity using sum(LUN RawCapacity) -->
    <!-- Individual LUN RawCapacity is sum of the hyper capacity in RAID Group. -->
    <!-- NOTE: Failed disks will be excluded from the RawCapacity -->
    <aggregation id="VMAX-Collector-ConfiguredRawCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' 
                    &amp; name=='RawCapacity' &amp; dgstype=='Thick') 
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')
        </filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">ConfiguredRawCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
            
            <remove name="parttype" />
            <remove name="part" />
            <remove name="diskgrp" />
            <remove name="raidgrp" />
            <remove name="dgname" />
            <remove name="partvend" />
            <remove name="director" />
            <remove name="partver" />
            <remove name="partmode" />
            <remove name="disktype" />
            <remove name="diskrpm" />
            <remove name="hypers" />
        </properties>
    </aggregation>

    
    <!-- Array LUN Count (VMAX-Device Capacity) -->
    <!-- Count of Array's Capacity metrics -->
    <aggregation id="VMAX-Collector-LunCount" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' 
                    &amp; name=='Capacity' &amp; datagrp=='VMAX-DEVICES')
        </filter>
        <group-by>device</group-by>
        <compute spatial="count">
            <output-timestamp use="max" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">LunCount</add>
            <add name="devtype">Array</add>
            <add name="unit"></add>
            
            <remove name="parttype" />
            <remove name="part" />
            <remove name="diskgrp" />
            <remove name="raidgrp" />
            <remove name="dgname" />
            <remove name="partvend" />
            <remove name="director" />
            <remove name="partver" />
            <remove name="partmode" />
            <remove name="disktype" />
            <remove name="diskrpm" />
            <remove name="hypers" />
        </properties>
    </aggregation>

    <!-- Array Used Capacity -->
    <aggregation id="VMAX-Collector-UsedCapacity" forward-input="true">
        <!-- Will use Snap Pool UsedCapacity instead of summing VDEVs ConsumedCapacity
             because VDEV tracks can be shared. -->
        <filter>(devtype=='Array' &amp; name=='UsedCapacity' &amp; 
                    ( (parttype=='LUN' &amp; !config='%VDEV%' &amp; isused=='1') 
                    | (parttype=='Storage Pool' &amp; dgstype=='Snap') ))
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')
        </filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">UsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
            
            <remove name="parttype" />
            <remove name="part" />
            <remove name="roc1" />
            <remove name="roc2" />
            <remove name="partsn" />
            <remove name="spindles" />
            <remove name="config" />
            <remove name="mvsgname" />
            <remove name="devconf" />
            <remove name="dgstype" />
            <remove name="pdname" />
            <remove name="partconf" />
            <remove name="disktype" />
            <remove name="dgraid" />
            <remove name="ismapped" />
            <remove name="hypercnt" />
            <remove name="ismasked" />
        </properties>
    </aggregation>
    
    <!-- Array File Used Capacity -->
    <aggregation id="VMAX-Collector-FileUsedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; (name=='UsedCapacity' | name=='FileUsedCapacity') &amp;
                    ( (parttype=='LUN' &amp; usedby=='File' &amp; isused=='1') ) )
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')
        </filter>
        <group-by>device</group-by>
        <group-by>sstype</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">FileUsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>

            <remove name="parttype" />
            <remove name="part" />
            <remove name="partsn" />
            <remove name="luntagid" />
            <remove name="purpose" />
            <remove name="isbound" />
            <remove name="isused" />
            <remove name="ismasked" />
            <remove name="usedby" />
            <remove name="poolname" />
            <remove name="svclevel" />
            <remove name="sgname" />
            <remove name="dgraid" />
            <remove name="dgstype" />
            <remove name="config" />
            <remove name="devconf" />
        </properties>
    </aggregation>

    <!-- Array Virtual Used Capacity -->
    <aggregation id="VMAX-Collector-VirtualUsedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; name=='UsedCapacity' &amp;
                 parttype=='LUN' &amp; usedby=='Virtual' &amp; isused=='1')
                 | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')
        </filter>
        <group-by>device</group-by>
        <group-by>sstype</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">VirtualUsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>

            <remove name="parttype" />
            <remove name="part" />
            <remove name="partsn" />
            <remove name="luntagid" />
            <remove name="purpose" />
            <remove name="isbound" />
            <remove name="isused" />
            <remove name="ismasked" />
            <remove name="usedby" />
            <remove name="poolname" />
            <remove name="svclevel" />
            <remove name="sgname" />
            <remove name="dgraid" />
            <remove name="dgstype" />
            <remove name="config" />
            <remove name="devconf" />
        </properties>
    </aggregation>

    <!-- Array Free Capacity -->
    <!-- Sum of Unused Luns, Unbound Data Devices, and Unbound Save Devices -->
    <aggregation id="VMAX-Collector-FreeCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' 
                    &amp; dgstype=='Thick' &amp; isused=='0')
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')
        </filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">FreeCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
            
            <remove name="parttype" />
            <remove name="part" />
            <remove name="partsn" />
            <remove name="partconf" />
            <remove name="config" />
            <remove name="devconf" />
            <remove name="hypercnt" />
            <remove name="datadev" />
        </properties>
    </aggregation>
    
    <!-- Pool Usable Capacity -->
    <!-- Sum of all array thin pools and snap pools -->
    <aggregation id="VMAX-Collector-PoolUsableCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='Storage Pool' &amp; name=='Capacity')
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">PoolUsableCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
            
            <remove name="parttype" />
            <remove name="part" />
            <remove name="partstat"/>
            <remove name="dgstype"/>
            <remove name="poolemul"/>
            <remove name="raidtype"/>
        </properties>
    </aggregation>
    
    <!-- Pool Free Capacity -->
    <!-- Unwritten space within Thin Pool and Snap Pool -->
    <aggregation id="VMAX-Collector-PoolFreeCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='Storage Pool' &amp; name=='FreeCapacity')
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">PoolFreeCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
            
            <remove name="parttype" />
            <remove name="part" />
            <remove name="partstat"/>
            <remove name="dgstype"/>
            <remove name="poolemul"/>
            <remove name="raidtype"/>
        </properties>
    </aggregation>
    
    <!-- Storage Pool Used File Capacity -->
    <aggregation id="VMAX-Collector-PoolFileUsedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' &amp; isused=='1' &amp; usedby=='File'
                    &amp; (poolname &amp; !poolname=='N/A')) 
                    | (datagrp=='VMAX-POOLS-CAPACITY' &amp; name=='RemoveMeZero')
        </filter>
        <group-by>device</group-by>
        <group-by>pooltype</group-by>
        <group-by>poolname</group-by>

        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">FileUsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="parttype">Storage Pool</add>
            <add name="unit">GB</add>
        </properties>
    </aggregation>

    <!-- Storage Pool Used Virtual Capacity -->
    <aggregation id="VMAX-Collector-PoolVirtualUsedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' &amp; isused=='1' &amp; usedby=='Virtual'
                    &amp; (poolname &amp; !poolname=='N/A')) 
                    | (datagrp=='VMAX-POOLS-CAPACITY' &amp; name=='RemoveMeZero')
        </filter>
        <group-by>device</group-by>
        <group-by>pooltype</group-by>
        <group-by>poolname</group-by>

        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">VirtualUsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="parttype">Storage Pool</add>
            <add name="unit">GB</add>
        </properties>
    </aggregation>

    <!-- Thick LUN Capacity -->
    <aggregation id="VMAX-Collector-ThickLunCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' &amp; name=='Capacity' 
                    &amp; dgstype=='Thick' &amp; !(ispcbnd=='1'))
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">ThickLunCapacity</add>
            <add name="parttype">Thick Lun</add>
            <add name="part">Thick Lun</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
        </properties>
    </aggregation>
    
    <!-- Thick LUN Used Capacity -->
    <aggregation id="VMAX-Collector-ThickLunUsedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' 
                     &amp; dgstype=='Thick' &amp; !(ispcbnd=='1') &amp; isused=='1')
                     | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">ThickLunUsedCapacity</add>
            <add name="parttype">Thick Lun</add>
            <add name="part">Thick Lun</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
        </properties>
    </aggregation>
    
     <!-- Thick LUN Free Capacity -->
    <aggregation id="VMAX-Collector-ThickLunFreeCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' 
                     &amp; dgstype=='Thick' &amp; !(ispcbnd=='1') &amp; isused=='0')
                     | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">ThickLunFreeCapacity</add>
            <add name="parttype">Thick Lun</add>
            <add name="part">Thick Lun</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
        </properties>
    </aggregation>
    
    <!-- Primary Used Capacity -->
    <aggregation id="VMAX-Collector-PrimaryUsedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' 
                    &amp; purpose=='Primary' &amp; isused=='1')
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">PrimaryUsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
        </properties>
    </aggregation>
    
    <!-- Local Replica Used Capacity -->
    <aggregation id="VMAX-Collector-LocalReplicaUsedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' 
                    &amp; purpose=='Local Replica' &amp; isused=='1')
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">LocalReplicaUsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
        </properties>
    </aggregation>
    
    <!-- Remote Replica Used Capacity -->
    <aggregation id="VMAX-Collector-RemoteReplicaUsedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' 
                    &amp; purpose=='Remote Replica' &amp; isused=='1')
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">RemoteReplicaUsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
        </properties>
    </aggregation>
    
    <!-- System Resource Used Capacity -->
    <aggregation id="VMAX-Collector-SystemUsedCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' 
                    &amp; purpose=='System Resource' &amp; isused=='1')
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">SystemUsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="unit">GB</add>
        </properties>
    </aggregation>

    <!-- Service Level Usable Capacity -->
    <!-- Sum of all UsedCapacity from LUNs in Service Level -->
    <!-- NOTE: Pool Contributor Used Capacity is always zero -->
    <aggregation id="VMAX-Collector-ServiceLevelUsableCapacity" forward-input="true">
        <filter>devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity'
                    &amp; !svclevel=='Pool Contributor'</filter>
        <group-by>device</group-by>
        <group-by>serialnb</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>svclevel</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">Capacity</add>
            <add name="devtype">Array</add>
            <add name="parttype">Service Level</add>
            <!-- Set part based on svclevel using PEH -->
            <add name="unit">GB</add>
        </properties>
    </aggregation>
    
    <!-- Service Level Usable Capacity for Pool Contributors-->
    <!-- Sum of all Capacity from LUNs in Pool Contributor Service Level -->
    <!-- NOTE: Pool Contributor Used Capacity is always zero so we sum the Pool Contributor LUN's Capacity instead. -->
    <aggregation id="VMAX-Collector-ServiceLevelUsableCapacity-PoolContributor" forward-input="true">
        <filter>devtype=='Array' &amp; parttype=='LUN' &amp; name=='Capacity'
                    &amp; svclevel=='Pool Contributor'
        </filter>
        <group-by>device</group-by>
        <group-by>serialnb</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>svclevel</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">Capacity</add>
            <add name="devtype">Array</add>
            <add name="parttype">Service Level</add>
            <!-- Set part based on svclevel using PEH -->
            <add name="unit">GB</add>
        </properties>
    </aggregation>

    <!-- Service Level Used Capacity -->
    <!-- Sum of UsedCapacity from LUNs in Service Level -->
    <!-- NOTE: Pool Contributor Used Capacity is always zero -->
    <aggregation id="VMAX-Collector-ServiceLevelUsedCapacity" forward-input="true">
        <filter>devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' 
                    &amp; isused=='1' &amp; !svclevel=='Pool Contributor'
        </filter>
        <group-by>device</group-by>
        <group-by>serialnb</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>svclevel</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">UsedCapacity</add>
            <add name="devtype">Array</add>
            <add name="parttype">Service Level</add>
            <!-- Set part based on svclevel using PEH -->
            <add name="unit">GB</add>
        </properties>
    </aggregation>
    
    <!-- Service Level Free Capacity -->
    <!-- Sum of FreeCapacity from LUNs in Service Level -->
    <!-- NOTE: Pool Contributor Free Capacity is always zero -->
    <aggregation id="VMAX-Collector-ServiceLevelFreeCapacity" forward-input="true">
        <filter>(devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' 
                    &amp; isused=='0' &amp; !svclevel=='Pool Contributor')
                    | (datagrp=='VMAX-ARRAYS' &amp; name=='RemoveMeZero')</filter>
        <group-by>device</group-by>
        <group-by>serialnb</group-by>
        <group-by>model</group-by>
        <group-by>devdesc</group-by>
        <group-by>arraytyp</group-by>
        <group-by>vendor</group-by>
        <group-by>svclevel</group-by>
        <compute spatial="sum">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">FreeCapacity</add>
            <add name="devtype">Array</add>
            <add name="parttype">Service Level</add>
            <!-- Set part based on svclevel using PEH -->
            <add name="unit">GB</add>
        </properties>
    </aggregation>

    <!-- Calculate StoragePool isfast value based on LUN isfast values -->
    <aggregation id="VMAX-Collector-FastLunCount" forward-input="true">
        <filter>devtype=='Array' &amp; parttype=='LUN' &amp; name=='UsedCapacity' 
                   &amp; isbound &amp; (poolname &amp; !poolname=='N/A') &amp; isfast=='1'</filter>
        <group-by>device</group-by>
        <group-by>pooltype</group-by>
        <group-by>poolname</group-by>
        <compute spatial="count">
            <output-timestamp use="first" rounding="ceiling" rounding-base="1" />
            <output-group>group</output-group>
            <inventory period="${pollingperiod}" removal-timeout="${pollingperiod * 2}" />
        </compute>
        <properties>
            <add name="w4ncert">1.0</add>
            <add name="datatype">Block</add>
            <add name="sstype">Block</add>
            <add name="source">VMAX-Collector</add>
            <add name="datagrp">VMAX-SAF</add>
            <add name="name">FastLunCount</add>
            <add name="devtype">Array</add>
            <add name="parttype">Storage Pool</add>
        </properties>
    </aggregation>

</config>