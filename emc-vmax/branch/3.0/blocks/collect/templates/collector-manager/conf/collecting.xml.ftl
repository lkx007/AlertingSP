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
<config xmlns="http://www.watch4net.com/APG/Collecting" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.watch4net.com/APG/Collecting collecting.xsd ">
    <connectors>
        <connector enabled="true" name="Backend" type="Socket-Connector" config="conf/socketconnector.xml" />
[#if use_topo]
        <connector enabled="true" name="TopoBackend" type="Socket-Connector" config="conf/topoconnector.xml" />
[#else]
        <connector enabled="false" name="TopoBackend" type="Socket-Connector" config="conf/topoconnector.xml" />
[/#if]
[#if use_alert]
        <connector enabled="true" name="Alerting" type="Socket-Connector" config="conf/alertingconnector.xml" />
[#else]
        <connector enabled="false" name="Alerting" type="Socket-Connector" config="conf/alertingconnector.xml" />
[/#if]
    </connectors>
    
    <filters>
[#if storage.failover]
        <filter enabled="true" name="FailOver" next="Backend" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
[#else]
        <filter enabled="skip" name="FailOver" next="Backend" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
[/#if]
        <filter enabled="true" name="IgnoreErrors" next="Alerting" type="Ignore-Errors-Filter" config="Collector-Manager/${module['collector-manager'].instance}/" />

        <filter enabled="true" name="TopoFilter" next="TopoBackend" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-topobe.xml" />
        <filter enabled="true" name="APGBEFilter" next="FailOver IgnoreErrors" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-apgbe.xml" />
        <filter enabled="true" name="DataEnrichment" next="APGBEFilter TopoFilter" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter.xml" />
        
        <!-- 
            * vhf-vmax-sah3.xml
                * PoolSubscribedCapacity roll-up of SubscribedCapacity
                * PoolOversubscribedCapacity roll-up of OversubscribedCapacity
                * Block RemoveMeZero metrics
        -->
        <filter enabled="true" name="VMAX_VHF3" next="DataEnrichment" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-vmax3.xml" />
        
        <!-- Cross Reference LUN and StoragePool metric isfast properties -->
        <filter enabled="true" name="VMAX_CRF_ISFASTPOOL" next="VMAX_VHF3" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/crf-vmax-isfastpool.xml" />
        
        <!-- Calculate new Capacity metrics for:
            * Array RAID Overhead Capacity
            * Array Unusable Capacity
            * Array Block Used Capacity
            * Set the following metrics to zero: 
                * System Resource Service Level Free Capacity
                * Pool Contributor Service Level Used Capacity
                * Pool Contributor Service Level Free Capacity
            * Calculate Storage Pool isfast based on FastLunCount
            * Calculate Storage Pool BlockUsedCapacity, SubscribedCapacity, OversubscribedCapacity
        -->
        <filter enabled="true" name="VMAX_ICF_CAPACITYCALC" next="VMAX_CRF_ISFASTPOOL" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/icf-vmax-capacitycalc.xml"/>
        
        <!-- Compute Roll-up Capacity metrics and Storage Pool isfast
            * vhf-vmax-sah.xml
                * Sum up Capacity, FreeCapacity for Disks and Storage Pools
                * Sum up RawCapacity, UsedCapacity metrics for LUN
                * Sum up Service Level Capacity, FreeCapacity, UsedCapacity
                * Count LUNs with isfast=1 (FastLunCount)
            * peh-storagepool-part.xml
                * copy Storage Pool poolname to part for aggregate pool metrics
            * vhf-vmax-sah2.xml
                * set FastLunCount to zero if it is still null by taking max of FastLunCount and RemoveMeZero metric
            * pah-storagepool-isfast.xml 
                * set Storage Pool isfast based on FastLunCount
            * peh-svclevel-part.xml
                * copy svclevel to part for aggregate Service Level metrics
        -->
        <filter enabled="true" name="VMAX_VHF2" next="VMAX_ICF_CAPACITYCALC" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-vmax2.xml" />
        
        <!-- Set PresentedCapacity based on Thick/Thin/System Resource or Pool Contributor -->
        <filter enabled="true" name="VMAX_ICF_PRES" next="VMAX_VHF2" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/icf-vmax-presentedcap.xml"/>
        
        <!-- Set LunCapacity based on Thick Capacity or Thin ConsumedCapacity metric and isused property -->
        <filter enabled="true" name="VMAX_ICF_ISUSED" next="VMAX_ICF_PRES" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/icf-vmax-isused.xml"/>
        
        <!-- Cross Reference LUN svclevel with other LUNs -->
        <filter enabled="true" name="VMAX_CRF_SVCLEVEL" next="VMAX_ICF_ISUSED" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/crf-vmax-svclevel.xml" />
        
        <!-- 
            * Tag LUN svclevel using disk characteristics listed in "ServiceLevel by Disk.csv"
            * Tag LUN svclevel using FAST Policy Names listed in "ServiceLevel by FASTVP VMAX.csv"
            * Tag LUN svclevel using predefined Service Levels for "System Resource" and "Pool Contributor"
            * Tag LUN without svclevel with Service Level "Other"
        -->
        <filter enabled="true" name="ManageServiceLevels-VMAX" next="VMAX_CRF_SVCLEVEL" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/ptf-CustomizeServiceLevels.xml" />
        
        <!-- 
            * Block RemoveMe metrics
            * pah-lunrawcapacity.xml: Convert RawCapacity rawcap property (sum of LUN hypers) into raw value 
            * pah-thin-isused.xml: Calculate Thin LUN isused property
            * pah-thick-isused.xml: Calculate Thick LUN isused property
            * VariableStateMonitorHandler: Set LUNtoDirectorAssociation partstat property 
        -->
        <filter enabled="true" name="VMAX_VHF1" next="ManageServiceLevels-VMAX" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-vmax1.xml" />
        
        <!-- Convert (Capacity|FreeCapacity|SubscribedCapacity|EnabledCapacity|UserCapacity|ConsumedCapacity|UsedCapacity|PoolUsedCapacity|SnapPoolUsedCapacity) metrics from MB to GB -->
        <filter enabled="true" name="VMAX_VOF1" next="VMAX_VHF1" config="Value-Offset-Filter/${module['value-offset-filter'].instance}/conf/vof-vmax1.xml" />
        
        <!-- Cross Reference LUN metric isfast property -->
        <filter enabled="true" name="VMAX_CRF_ISFASTLUN" next="VMAX_VOF1" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/crf-vmax-isfastlun.xml" />
        
        <!-- Tag LUN metrics with isfast and remove isfastdp and isfastvp properties:
             Set LUN metric's isfast property if:
                * LUN is in a FAST Storage Group
                * if Thin LUN and the FAST Storage Group is associated to a "VP" FAST Tier then isfast = 1
                * if Thick LUN and the FAST Storage Group is associated to a "DP" FAST Tier then isfast = 1 
        -->
        <filter enabled="true" name="VMAX_PTF_ISFAST" next="VMAX_CRF_ISFASTLUN" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/ptf-vmax-isfast.xml" />
        
        <!-- Cross reference Pool Contributor LUN's disk information with the Storage Pool that it is bound -->
        <filter enabled="true" name="VMAX_CRF_POOL_DISKINFO" next="VMAX_PTF_ISFAST" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/crf-vmax-pool-diskinfo.xml" />
        
        <!-- Tag Thin LUN with disktype, disksize, diskrpm, dgraid using pool contributor -->
        <filter enabled="true" name="VMAX_PTF_THINDISK" next="VMAX_CRF_POOL_DISKINFO" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/ptf-vmax-thindisk.xml" />
        
        <!-- Cross Reference LUN purpose, dgstype, usedby -->
        <filter enabled="true" name="VMAX_CRF_LUNPURPOSE" next="VMAX_PTF_THINDISK" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/crf-vmax-lun-purpose.xml" />
        
        <!-- Set LUN usedby property by querying Topology Service -->
        <filter enabled="true" name="VMAX_PTF_LUN_USEDBY" next="VMAX_CRF_LUNPURPOSE" config="Property-Tagging-Filter/${module['value-offset-filter'].instance}/conf/ptf-vmax-lun-usedby.xml" />
        
        <!-- Set LUN purpose property and set isused from rootlun when it is different from rootlun by querying Topology Service -->
        <filter enabled="true" name="VMAX_PTF_LUN_PURPOSE" next="VMAX_PTF_LUN_USEDBY" config="Property-Tagging-Filter/${module['value-offset-filter'].instance}/conf/ptf-vmax-lun-purpose.xml" />
        
        <!-- Set LUN ismasked property to default of 0 if not set after cross referencing -->
        <filter enabled="true" name="VMAX_PTF_DEFAULTMASKING" next="VMAX_PTF_LUN_PURPOSE" config="Property-Tagging-Filter/${module['value-offset-filter'].instance}/conf/ptf-vmax-defaultmasking.xml" />

        <!-- Cross Reference collected LUN metric properties from device, replica, disk, tier, policy, masking/mapping collection -->
        <filter enabled="true" name="VMAX_CRF1" next="VMAX_PTF_DEFAULTMASKING" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/crf-vmax1.xml" />
        
        <!-- Set LUN dgstype "Thin" based on config="TDEV" or "VDEV" or "DLDEV" else "Thick" -->
        <filter enabled="true" name="VMAX_PTF_LUN_DGSTYPE" next="VMAX_CRF1" config="Property-Tagging-Filter/${module['value-offset-filter'].instance}/conf/ptf-vmax-lun-dgstype.xml" />
    </filters>
    
    <collectors>
        [#assign enabled="false" /]
        [#if vmax??]
            [#list vmax as vmax]
                [#assign enabled="true" /]
                [#break]
            [/#list]
        [/#if]
        <collector enabled="${enabled}" name="vmax-topo" next="VMAX_PTF_LUN_DGSTYPE" config="XML-Collector/${module['xml-collector'].instance}/conf/xmlcollector-vmax-topo.xml" />
        [#if emcvmax??]
        <collector enabled="true" name="vmax-perf" next="VMAX_PTF_LUN_DGSTYPE" config="XML-Collector/${module['xml-collector'].instance}/conf/xmlcollector-vmax-perf.xml" />
        [/#if]
    </collectors>
</config>