[#ftl]
[#if use_advancedsettings]
	[#assign pollingperiod = topology.pollingperiod]
[#else]
	[#assign pollingperiod = 1200]
[/#if]
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
<configuration xmlns="http://www.watch4net.com/XMLCollector" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xsi:schemaLocation="http://www.watch4net.com/XMLCollector xmlcollector.xsd ">
    
    <simultaneous-collecting>1</simultaneous-collecting>
    <polling-interval>${pollingperiod}</polling-interval>
    <collecting-group>group</collecting-group>
    <source>VMAX-Collector</source>
    <refresh>3600</refresh>
    
    <collecting-configuration id="VMAX-ARRAYS" variable="source device name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symcfg -output XML -sid (host) list -v</input>
[#else]
            <input>conf/vmax.sh symcfg -output XML -sid (host) list -v</input>
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
        <value name="TotalMemory" value="/SymCLI_ML/Symmetrix/Cache/megabytes" unit="MB">
            <property-set>symProperties</property-set>
        </value>
        <value name="TotalDisk" value="/SymCLI_ML/Symmetrix/Symm_Info/disks" unit="">
            <property-set>symProperties</property-set>
        </value>
        <value name="TotalHotSpare" value="/SymCLI_ML/Symmetrix/Symm_Info/hot_spares" unit="">
            <property-set>symProperties</property-set>
        </value>
        <value name="TotalLun" value="/SymCLI_ML/Symmetrix/Symm_Info/devices" unit="">
            <property-set>symProperties</property-set>
        </value>
        <value name="TotalUnconfiguredDisk" value="/SymCLI_ML/Symmetrix/Symm_Info/unconfigured_disks" unit="">
            <property-set>symProperties</property-set>
        </value>
        <value name="RemoveMeZero" value="/SymCLI_ML/Symmetrix/Symm_Info/attachment" unit="GB">
            <replace value="Local" by="0" />
            <replace value="Remote" by="0" />
            <property-set>symProperties</property-set>
        </value>
        
        <property-set name="symProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-ARRAYS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="vendor" type="hard-coded" value="EMC Corporation"/>
            <property name="model" type="data" value="/SymCLI_ML/Symmetrix/Symm_Info/product_model"/>
            <property name="devdesc" type="data" value="concat(/SymCLI_ML/Symmetrix/Enginuity/patch_level, ' date:', /SymCLI_ML/Symmetrix/Microcode/date, ' patch_date:', /SymCLI_ML/Symmetrix/Microcode/patch_date)"/>            
        </property-set>
    </collecting-configuration>
    
    <collecting-configuration id="VMAX-BE-DIRECTORS" variable="source device partgrp parttype directid name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Director</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symcfg -output XML -sid (host) list -da all</input>
[#else]
            <input>conf/vmax.sh symcfg -output XML -sid (host) list -da all</input>
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
        <value name="Availability" value="/Director/Dir_Info/status" unit="%">
            <replace value="Online" by="100"/>
            <replace value="Offline" by="0"/>
            <property-set>symProperties</property-set>
        </value>
        <property-set name="symProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-DIRECTORS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="Controller"/>
            <property name="partgrp" type="hard-coded" value="Back-End"/>
            <property name="directid" type="data" value="../symbolic"/>
            <property name="part" type="data" value="../id"/>
            <property name="director" type="data" value="../id"/>
        </property-set>
    </collecting-configuration>
    
    <collecting-configuration id="VMAX-FE-DIRECTORS" variable="source device partgrp parttype part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Director</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symcfg -output XML -sid (host) list -sa all</input>
[#else]
            <input>conf/vmax.sh symcfg -output XML -sid (host) list -sa all</input>
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
        <value name="Availability" value="/Director/Dir_Info/status" unit="%">
            <replace value="Online" by="100"/>
            <replace value="Offline" by="0"/>
            <property-set>symProperties</property-set>
        </value>
        <property-set name="symProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="ip" type="host" value=""/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-DIRECTORS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="Controller"/>
            <property name="partgrp" type="hard-coded" value="Front-End"/>
            <property name="directid" type="data" value="../symbolic"/>
            <property name="part" type="data" value="../id"/>
            <property name="director" type="data" value="../id"/>
        </property-set>
    </collecting-configuration>
    
    <collecting-configuration id="VMAX-PORTS" variable="source device parttype director part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Director</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symcfg -output XML -sid (host) list -fa all -port -v</input>
[#else]
            <input>conf/vmax.sh symcfg -output XML -sid (host) list -fa all -port -v</input>
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
        <timestamp type="use-system-time" />
        <value name="Availability" value="/Director/Dir_Info/port0_conn_status" unit="%">
            <replace value="Yes" by="100" />
            <replace value="No" by="0" />
            <replace value="N/A" by="0" />
            <property-set>port0Properties</property-set>
        </value>
        <value name="Availability" value="/Director/Dir_Info/port1_conn_status" unit="%">
            <replace value="Yes" by="100" />
            <replace value="No" by="0" />
            <replace value="N/A" by="0" />
            <property-set>port1Properties</property-set>
        </value>
        <property-set name="port0Properties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value="" />
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-PORTS" />
            <property name="devtype" type="hard-coded" value="Array" />
            <property name="parttype" type="hard-coded" value="Port" />
            <property name="director" type="data" value="../id" />
            <property name="directid" type="data" value="../symbolic" />
            <property name="part" type="hard-coded" value="0" />
            <property name="port" type="hard-coded" value="0" />
            <property name="feport" type="data" value="concat(../id, ':', '0')" />
            <property name="partstat" type="data" value="../port0_status" />
            <property name="porttype" type="hard-coded" value="FA" />
            <property name="nodewwn" type="data" value="../../Port/Port_Info[port='0']/node_wwn" />
            <property name="portwwn" type="data" value="../../Port/Port_Info[port='0']/port_wwn" />
            <property name="partgrp" type="hard-coded" value="Front-End" />
            
            <!-- FCPort Flags -->
            <property name="vcmbit" type="data" value="../../Port/Port_Info[port='0']/../Fibre_Flags/vcm_state | ../../Port/Port_Info[port='0']/../Fibre_Flags/aclx"/>
            <property name="fcswbit" type="data" value="../../Port/Port_Info[port='0']/../Fibre_Flags/init_point_to_point"/>
            <property name="wwnbit" type="data" value="../../Port/Port_Info[port='0']/../Fibre_Flags/unique_wwn"/>
            <property name="cbit" type="data" value="../../Port/Port_Info[port='0']/../SCSI_Flags/common_serial_number"/>
            <property name="sc3bit" type="data" value="../../Port/Port_Info[port='0']/../SCSI_Flags/scsi_3"/>
            <property name="spc2bit" type="data" value="../../Port/Port_Info[port='0']/../SCSI_Flags/spc2_protocol_version"/>
        </property-set>
        <property-set name="port1Properties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value="" />
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-PORTS" />
            <property name="devtype" type="hard-coded" value="Array" />
            <property name="parttype" type="hard-coded" value="Port" />
            <property name="director" type="data" value="../id" />
            <property name="directid" type="data" value="../symbolic" />              
            <property name="part" type="hard-coded" value="1" />
            <property name="port" type="hard-coded" value="1" />            
            <property name="feport" type="data" value="concat(../id, ':', '1')" />
            <property name="partstat" type="data" value="../port1_status" />
            <property name="porttype" type="hard-coded" value="FA" />
            <property name="nodewwn" type="data" value="../../Port/Port_Info[port='1']/node_wwn" />
            <property name="portwwn" type="data" value="../../Port/Port_Info[port='1']/port_wwn" />
            <property name="partgrp" type="hard-coded" value="Front-End" />
            
            <!-- FCPort Flags -->
            <property name="vcmbit" type="data" value="../../Port/Port_Info[port='1']/../Fibre_Flags/vcm_state | ../../Port/Port_Info[port='1']/../Fibre_Flags/aclx"/>
            <property name="fcswbit" type="data" value="../../Port/Port_Info[port='1']/../Fibre_Flags/init_point_to_point"/>
            <property name="wwnbit" type="data" value="../../Port/Port_Info[port='1']/../Fibre_Flags/unique_wwn"/>
            <property name="cbit" type="data" value="../../Port/Port_Info[port='1']/../SCSI_Flags/common_serial_number"/>
            <property name="sc3bit" type="data" value="../../Port/Port_Info[port='1']/../SCSI_Flags/scsi_3"/>
            <property name="spc2bit" type="data" value="../../Port/Port_Info[port='1']/../SCSI_Flags/spc2_protocol_version"/>
            
        </property-set>
    </collecting-configuration>
    
    <collecting-configuration id="VMAX-DISKS" variable="source device parttype part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Disk</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symdisk -output XML -sid (host) list -da ALL -v</input>
[#else]
            <input>conf/vmax.sh symdisk -output XML -sid (host) list -da ALL -v</input>
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
        <value name="Capacity" value="/Disk/Disk_Info/actual_megabytes" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        <value name="FreeCapacity" value="/Disk/Disk_Info/avail_megabytes" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        <value name="Availability" value="/Disk/Disk_Info/failed_disk" unit="%">
            <replace value="False" by="100"/>
            <replace value="True" by="0"/>
            <property-set>symProperties</property-set>
        </value>
        <property-set name="symProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="datagrp" type="hard-coded" value="VMAX-DISKS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="Disk"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="part" type="data" value="concat(../ident, ':', ../interface, ' ', ../tid)"/>
            <property name="partid" type="data" value="../spindle_id"/>
            <property name="director" type="data" value="../ident"/>
            <property name="partvend" type="data" value="../vendor"/>
            <property name="partver" type="data" value="../revision"/>
            <property name="raidgrp" type="data" value="../hypers"/>
            <property name="dgname" type="data" value="if (exists(../disk_group_name)) then (../disk_group_name) else (string('N/A'))"/>
            <property name="diskgrp" type="data" value="if (exists(../disk_group)) then (../disk_group) else (string('N/A'))"/>
            <property name="diskrpm" type="data" value="../speed"/>
            <property name="diskfail" type="data" value="../failed_disk"/>
            
            <property name="partmode" type="data" value="../hot_spare">
                <replace value="True" by="Hot spare"/>
                <replace value="False" by="Assigned"/>
            </property>
            
            <property name="diskloc" type="data" value="../disk_location"/>
            <property name="disktype" type="data" value="../technology">
                <replace value="FC" by="Fibre Channel"/>
                <replace value="SATA" by="SATA"/>
                <replace value="EFD" by="Enterprise Flash Drive"/>
                <replace value="Flash Drive" by="Enterprise Flash Drive"/>
                
                <!-- Seeing "Unknown" for EFD on Sym904 in lab -->
                <replace value="Unknown" by="Enterprise Flash Drive"/>
            </property>
            
            <property name="disksize" type="data" value="ceiling(../actual_megabytes div 1024)"/>
            <property name="hypers" type="data" value="string-join(../../Hyper/number, ',')"/>
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-ACCESS" variable="source device parttype part directid port initwwn hostlun initgrp name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
[#--
for-each can't be used, since we need the full XML, in order to get the WWNs in the reports accross all views...
        <for-each>Masking_View</for-each>
--]
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symaccess -output XML -sid (host) list view -detail</input>
[#else]
            <input>conf/vmax.sh symaccess -output XML -sid (host) list view -detail</input>
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
        
        <value name="Capacity" value="//Masking_View/View_Info/Initiators[group_name]/../Totals/total_dev_cap_mb" unit="GB">
            <property-set>MaskingViewsPropertiesGroup</property-set>
        </value>
        
        <value name="Capacity" value="//Masking_View/View_Info/Initiators[wwn]/..[not(view_name=//View_Info/Initiators[group_name]/../view_name)]/Totals/total_dev_cap_mb" unit="GB">
            <property-set>MaskingViewsPropertiesWWN</property-set>
        </value>
        
        <value name="MVLunCapacity" value="//Masking_View/View_Info/Device/capacity" unit="">
            <property-set>LunsProperties</property-set>
        </value>
        
        <value name="MappingData" value="//Masking_View/View_Info/Initiators[wwn]/../Device/dev_port_info/port" unit="">
            <property-set>MappingDataProperties</property-set>
        </value>
        
        <property-set name="MappingDataProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-MAPPING" />
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="part" type="data" value="../../dev_name" />
            <property name="partid" type="data" value="../../dev_name" />
            <property name="directid" type="data" value="../director"/>
            <property name="port" type="data" value="../port"/>
            <property name="hostlun" type="data" value="if(starts-with(../host_lun, '0x') or starts-with(../host_lun, '0X')) then ../host_lun else concat('0x', ../host_lun)"/>                 
            <property name="initwwn" type="data" value="string-join(../../../Initiators[wwn]/wwn,',')"/> 
            <property name="masked" type="hard-coded" value="true"/>
            <property name="mapped" type="hard-coded" value="true"/>
        </property-set> 
        
        <property-set name="MaskingViewsPropertiesGroup">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            
            <!-- TODO: Review whether changing datagrp will break reports -->
            <property name="datagrp" type="data" value="matches(../../init_grpname, '\*')">
                <replace value="true" by="VMAX-ACCESS-CHILD"/>
                <replace value="false" by="VMAX-ACCESS"/>
            </property>

            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="Access"/>
            <property name="part" type="data" value="../../view_name"/>
            <property name="initgrp" type="data" value="../../init_grpname"/>
            <property name="portgrp" type="data" value="../../port_grpname"/>
            
            <!-- TODO: Review director and port value changes to make sure we don't break reports -->
            <property name="director" type="data" value="string-join(../../port_info/Director_Identification/dir, ',')"/>
            <property name="dirnport" type="data" value="string-join(../../port_info/Director_Identification/concat(dir,':',port),'|')"/>
            <property name="port" type="data" value="string-join(../../port_info/Director_Identification/port, ',')"/>
            <property name="sgname" type="data" value="../../stor_grpname"/>
            <property name="devices" type="data" value="string-join(../../Device/dev_name,',')"/>
            <property name="partsngr" type="data" value="string-join(../../Initiators/group_name,',')"/>
            <property name="hostname" type="data" value="distinct-values((for $v in ../../view_name return //Masking_View/View_Info[view_name=$v]/Initiators[wwn]/user_node_name))"/>
            <property name="extgrp" type="data" value="string-join((for $v in ../../view_name return //SymCLI_ML/Symmetrix/Masking_View/View_Info[view_name=$v]/Initiators[wwn]/../init_grpname),',')"/>
            <property name="partsn" type="data" value="string-join((for $v in ../../view_name return //Masking_View/View_Info[view_name=$v]/Initiators[wwn]/wwn),',')"/>
            <!-- Note that in VMAX, a volume is masked and mapped always if it is part of masking view -->
            <property name="masked" type="hard-coded" value="true" />
            <property name="mapped" type="hard-coded" value="true" />
        </property-set>
        
        <property-set name="MaskingViewsPropertiesWWN">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            
            <!-- TODO: Review to make sure this doesn't break reports -->
            <property name="datagrp" type="data" value="matches(../../init_grpname, '\*')">
                <replace value="true" by="VMAX-ACCESS-CHILD"/>
                <replace value="false" by="VMAX-ACCESS"/>
            </property>

            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="Access"/>
            <property name="part" type="data" value="../../view_name"/>
            <property name="initgrp" type="data" value="../../init_grpname"/>
            <property name="portgrp" type="data" value="../../port_grpname"/>
            
            <!-- TODO: Review to make sure this doesn't break reports -->
            <property name="director" type="data" value="string-join(../../port_info/Director_Identification/dir, ',')"/>
            <property name="dirnport" type="data" value="string-join(../../port_info/Director_Identification/concat(dir,':',port),'|')"/>
            <property name="port" type="data" value="string-join(../../port_info/Director_Identification/port, ',')"/>

            <property name="sgname" type="data" value="../../stor_grpname"/>
            <property name="devices" type="data" value="string-join(../../Device/dev_name,',')"/>
            <property name="partsngr" type="data" value="string-join(../../Initiators/group_name,',')"/>
            <property name="hostname" type="data" value="../../Initiators/user_node_name"/>
            <property name="portname" type="data" value="../../Initiators/user_port_name"/>
            <property name="partsn" type="data" value="../../Initiators/wwn"/>
            <!-- Note that in VMAX, a volume is masked and mapped always if it is part of masking view -->
            <property name="masked" type="hard-coded" value="true" />
            <property name="mapped" type="hard-coded" value="true" />
        </property-set>
        
        <property-set name="LunsProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="datagrp" type="hard-coded" value="VMAX-ACCESS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="part" type="data" value="../dev_name"/>
            <property name="partid" type="data" value="../dev_name"/>
            <property name="mvlist" type="data" value="string-join(distinct-values((for $l in ../dev_name return (//View_Info/Device[dev_name=$l]/../view_name))),',')"/>            
            <property name="ismasked" type="data" value="number(exists(../../Initiators/wwn | ../../init_grpname))"/>
            <property name="ismapped" type="data" value="number(exists(../../port_info/Director_Identification/port | ../../port_grpname))"/>
        </property-set>
    </collecting-configuration>
    
    <collecting-configuration id="DMX-MASK" variable="source device parttype part director port initwwn name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Originator_Port</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symmaskdb -output xml -sid (host) list devs </input>
[#else]
            <input>conf/vmax.sh symmaskdb -output xml -sid (host) list devs </input>
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
        <value name="DMXMasking" value="/Originator_Port/Device/port" unit="">
            <property-set>MaskingProperties</property-set>
        </value>
        
         <property-set name="MaskingProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="DMX-MASK"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="part" type="data" value="../dev_name"/>
            <property name="partid" type="data" value="../dev_name"/>
            <property name="maskid" type="data" value="concat(../dev_name, '-', ../director, '_', ../port, '-', ../../wwn)"/>
            <property name="directid" type="data" value="if(string-length(../director) &lt; 3) then concat('0', ../director) else ../director"/>
            <property name="port" type="data" value="../port"/>
            <property name="initwwn" type="data" value="../../wwn"/>
            <property name="hostname" type="data" value="../../user_node_name"/>
            <property name="ismasked" type="hard-coded" value="1"/>            
            <property name="ismapped" type="data" value="../host_lun != 'N/A'"/>  
            <!-- The below are needed for topology mapping which cant handle numbers as booleans -->
            <property name="masked" type="hard-coded" value="true"/>            
            <property name="mapped" type="data" value="number(../host_lun != 'N/A')"/>    
            <property name="hostlun" type="data" value="if(starts-with(../host_lun, '0x') or starts-with(../host_lun, '0X')) then ../host_lun else concat('0x', ../host_lun)"/>                
        </property-set>
        
    </collecting-configuration>
        
    <collecting-configuration id="VMAX-BCVREPLICAS" variable="source device parttype part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Device</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symbcv -output XML -sid (host) list</input>
[#else]
            <input>conf/vmax.sh symbcv -output XML -sid (host) list</input>
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
        
        <value name="StateOfReplica" value="/Device/Flags[meta != 'Member']/../BCV_Pair/state" unit="">
            <replace value="NeverEstab" by="0"/>
            <replace value="SyncInProg"  by="1"/>
            <replace value="Synchronized" by="2"/>
            <replace value="SplitInProg" by="3"/>
            <replace value="SplitBfrSync" by="4"/>
            <replace value="Split" by="5"/>
            <replace value="SplitNoInc" by="6"/>
            <replace value="Restored" by="7"/>
            <replace value="RestInProg" by="8"/>
            <replace value="SplitBfrRest" by="9"/>
            <replace value="Invalid" by="10"/>
            <replace value="Unknown" by="11"/>
            
            <property-set>BCVSourceProperties</property-set>
        </value>

        <property-set name="BCVSourceProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-BCVREPLICAS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="repltype" type="hard-coded" value="Mirror"/>
            <property name="replstat" value="."/>
            <property name="part" value="../BCV/dev_name"/>
            <property name="partid" value="../BCV/dev_name"/>
            <property name="srcarray" type="host" value=""/>
            <property name="srclun" value="../STD/dev_name"/>
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-SNAPREPLICAS" variable="source device parttype part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Snap</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symsnap -output XML -sid (host) list -v</input>
[#else]
            <input>conf/vmax.sh symsnap -output XML -sid (host) list -v</input>
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
        <value name="StateOfReplica" value="/Snap/Session/state" unit="">
            <replace value="NotCreated" by="0"/>
            <replace value="CopyInProg" by="1"/>
            <replace value="Copied" by="2"/>
            <replace value="CopyOnAccess" by="3"/>
            <replace value="Invalid" by="4"/>
            <replace value="CopyOnWrite" by="5"/>
            <replace value="CreateInProg" by="6"/>
            <replace value="Created" by="7"/>
            <replace value="Restored" by="8"/>
            <replace value="TermInProg" by="9"/>
            <replace value="RestInProg" by="10"/>
            <replace value="Recreated" by="11"/>
            <replace value="Failed" by="12"/>
            <replace value="Unknown" by="13"/>

            <property-set>SnapSourceProperties</property-set>
        </value>

        <property-set name="SnapSourceProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-SNAPREPLICAS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="repltype" type="hard-coded" value="Snap"/>
            <property name="replstat" value="."/>
            <property name="part" value="../Target/dev_name"/>
            <property name="partid" value="../Target/dev_name"/>
            <property name="srcarray" type="host" value=""/>
            <property name="srclun" value="../Source/dev_name"/>
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-CLONEREPLICAS" variable="source device parttype part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Clone</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symclone -output XML -sid (host) list -v </input>
[#else]
            <input>conf/vmax.sh symclone -output XML -sid (host) list -v </input>
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
        
        <value name="StateOfReplica" value="/Clone/Session/state" unit="">
            <replace value="CopyInProg" by="0"/>
            <replace value="Copied" by="1"/>
            <replace value="CopyOnAccess" by="2"/>
            <replace value="Invalid" by="3"/>
            <replace value="CopyOnWrite" by="4"/>
            <replace value="CreateInProg" by="5"/>
            <replace value="Created" by="6"/>
            <replace value="Restored" by="7"/>
            <replace value="TermInProg" by="8"/>
            <replace value="RestInProg" by="9"/>
            <replace value="Recreated" by="10"/>
            <replace value="Failed" by="11"/>
            <replace value="Unknown" by="12"/>

            <property-set>CloneSourceProperties</property-set>
        </value>

        <property-set name="CloneSourceProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-CLONEREPLICAS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="repltype"  type="hard-coded" value="Clone"/>
            <property name="replstat" value="."/>
            <property name="part" value="../Target/dev_name"/>
            <property name="partid" value="../Target/dev_name"/>
            <property name="srcarray" type="host" value=""/>
            <property name="srclun" value="../Source/dev_name"/>
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-RDFREPLICAS" variable="source device parttype part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Device</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symrdf -output XML -sid (host) list -v </input>
[#else]
            <input>conf/vmax.sh symrdf -output XML -sid (host) list -v </input>
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

        <value name="StateOfReplica" value="/Device/Flags[meta != 'Member']/../RDF/Local[contains(type,'R2')]/../RDF_Info/pair_state" unit="">
            <replace value="Invalid" by="0"/>
            <replace value="SyncInProg" by="1"/>
            <replace value="Synchronized" by="2"/>
            <replace value="Split" by="3"/>
            <replace value="Suspended" by="4"/>
            <replace value="Failed Over" by="5"/>
            <replace value="Partitioned" by="6"/>
            <replace value="R1 Updated" by="7"/>
            <replace value="R1 UpdInProg" by="8"/>
            <replace value="Mixed" by="9"/>
            <replace value="N/A" by="10"/>
            <replace value="Consistent" by="11"/>
            <replace value="Unknown" by="12"/>

            <property-set>RDFSourceProperties</property-set>
        </value>
        
        <property-set name="RDFSourceProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-RDFREPLICAS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="part" value="../../../Dev_Info/dev_name"/>
            <property name="partid" value="../../../Dev_Info/dev_name"/>
            <property name="srcarray" value="../../Local[contains(type,'R2')]/../Remote/remote_symid"/>
            <property name="srclun" value="../../Local[contains(type,'R2')]/../Remote/dev_name"/>
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-RCOPYREPLICAS" variable="source device parttype part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Device</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symrcopy -output XML -sid (host) list -v </input>
[#else]
            <input>conf/vmax.sh symrcopy -output XML -sid (host) list -v </input>
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
        
        <value name="StateOfReplica" value="/Device/RCopy/RCopy_Info/pair_state" unit="">
            <property-set>RCopySourceProperties</property-set>
        </value>
        
        <property-set name="RCopySourceProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-RCOPYREPLICAS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="repltype"  type="hard-coded" value="Clone"/>
            <property name="part" value="../../Remote/dev_name"/>
            <property name="partid" value="../../Remote/dev_name"/>
            <property name="srcarray" value="../../Remote/remote_symid"/>
            <property name="srclun" value="../../Local/dev_name"/>
        </property-set>
    </collecting-configuration>
    
    <collecting-configuration id="VMAX-POOLS-CAPACITY" variable="source device parttype part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>DevicePool</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symcfg -output XML -sid (host) list -pool</input>
[#else]
            <input>conf/vmax.sh symcfg -output XML -sid (host) list -pool</input>
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
        
        <!-- DO NOT REMOVE: this metric is needed for workaround. --> 
        <value name="RemoveMeZero" value="/DevicePool/vp_compression_state" unit="%">
            <replace value="Enabled" by="0"/>
            <replace value="Disabled" by="0"/>
            <replace value="N/A" by="0"/>
            
            <property-set>symProperties</property-set>
        </value>
        
        <!-- Exclude DEFAULT_POOL snap pools except for FBA emulation -->
        <value name="Capacity" value="/DevicePool[not(pool_name='DEFAULT_POOL')]/total_tracks_mb | /DevicePool[pool_name='DEFAULT_POOL' and dev_emulation='FBA']/total_tracks_mb" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        
        <value name="UsedCapacity" value="/DevicePool[not(pool_name='DEFAULT_POOL')]/total_used_tracks_mb | /DevicePool[pool_name='DEFAULT_POOL' and dev_emulation='FBA']/total_used_tracks_mb" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        
        <value name="FreeCapacity" value="/DevicePool[not(pool_name='DEFAULT_POOL')]/total_free_tracks_mb | /DevicePool[pool_name='DEFAULT_POOL' and dev_emulation='FBA']/total_free_tracks_mb" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        
        <!-- Pool Enabled Usable Capacity -->
        <value name="EnabledCapacity" value="/DevicePool[not(pool_name='DEFAULT_POOL')]/total_usable_tracks_mb | /DevicePool[pool_name='DEFAULT_POOL' and dev_emulation='FBA']/total_usable_tracks_mb" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        
        <property-set name="symProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-POOLS-CAPACITY"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="Storage Pool"/>
            <property name="part" type="data" value="../pool_name"/>
            <property name="poolname" value="../pool_name"/>
            <property name="partstat" type="data" value="../pool_state"/>
            <property name="dgstype" type="data" value="../pool_type"/>
            <property name="pooltype" type="data" value="if (../pool_type = 'Thin') then 'Thin Pool' else (if (../pool_type = 'Snap') then 'Snap Pool' else 'Storage Pool')"/>
            <property name="poolemul" type="data" value="../dev_emulation"/>
            <property name="diskloc" type="data" value="../disk_location"/>
            <property name="disktype" type="data" value="../technology">
                <replace value="FC" by="Fibre Channel"/>
                <replace value="SATA" by="SATA"/>
                <replace value="EFD" by="Enterprise Flash Drive"/>
                <replace value="Flash Drive" by="Enterprise Flash Drive"/>
                
                <!-- Seeing "Unknown" for EFD on Sym904 in lab -->
                <replace value="Unknown" by="Enterprise Flash Drive"/>
            </property>
            <property name="raidtype" type="data" value="../dev_config"/>
            
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-POOLS-AVAILABILITY" variable="source device parttype part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>DevicePool</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symcfg -output XML -sid (host) list -pool -detail -v -thin</input>
[#else]
            <input>conf/vmax.sh symcfg -output XML -sid (host) list -pool -detail -v -thin</input>
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
        
        <value name="Availability" value="/DevicePool/pool_state" unit="%">
            <replace value="Enabled" by="100"/>
            <replace value="Disabled" by="0"/>
            <property-set>symProperties</property-set>
        </value>
        
        <property-set name="symProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-POOLS-AVAILABILITY"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="Storage Pool"/>
            <property name="part" type="data" value="../pool_name"/>
            <property name="poolname" value="../pool_name"/>
            <property name="partstat" type="data" value="../pool_state"/>
            <property name="dgstype" type="data" value="../pool_type"/>
            <property name="poolemul" type="data" value="../dev_emulation"/>
            <property name="raidtype" type="data" value="../dev_config"/>
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-POOLS-SUBSCRIPTION" variable="source device parttype part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>DevicePool</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symcfg -output XML -sid (host) list -pool -detail -thin</input>
[#else]
            <input>conf/vmax.sh symcfg -output XML -sid (host) list -pool -detail -thin</input>
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
        
        <value name="Subscription" value="/DevicePool/subs_percent" unit="%">
            <property-set>symProperties</property-set>
        </value>
        
        <property-set name="symProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-POOLS-SUBSCRIPTION"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="Storage Pool"/>
            <property name="part" type="data" value="../pool_name"/>
            <property name="poolname" value="../pool_name"/>
            <property name="partstat" type="data" value="../pool_state"/>
            <property name="dgstype" type="data" value="../pool_type"/>
            <property name="poolemul" type="data" value="../dev_emulation"/>
            <property name="raidtype" type="data" value="../dev_config"/>
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-TIERS" variable="source device parttype part sgname name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Fast_Policy</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symfast -output XML -sid (host) list -association -demand</input>
[#else]
            <input>conf/vmax.sh symfast -output XML -sid (host) list -association -demand</input>
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
        
        <value name="TierCapacity" value="/Fast_Policy/Tier/tier_sg_limit" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        
        <value name="TierUsedCapacity" value="/Fast_Policy/Tier/tier_sg_used" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        
        <value name="TierGrowth" value="/Fast_Policy/Tier/tier_growth" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        
        <property-set name="symProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-TIERS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="Tier"/>
            <property name="part" type="data" value="../tier_name"/>
            <property name="tiername" type="data" value="../tier_name"/>
            <property name="tiertype" type="data" value="../tier_type"/>
            <property name="tiermax" type="data" value="../tier_max_sg_per"/>
            <property name="poltype" type="data" value="if (exists(..[tier_type = 'VP']/tier_type)) then 'Thin' else 'Thick'"/>
            <property name="polname" type="data" value="../../Policy_Info/policy_name"/>
            <property name="sgname" type="data" value="../../Policy_Info/storage_group_name"/>
            <property name="sgprio" type="data" value="../../Policy_Info/storage_group_priority">
                <replace value="1" by="Highest"/>
                <replace value="2" by="Medium"/>
                <replace value="3" by="Lowest"/>
            </property>
            
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-TIER-POOL" variable="source device parttype tiername part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Tier_Info</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symtier -output XML -sid (host) list -v</input>
[#else]
            <input>conf/vmax.sh symtier -output XML -sid (host) list -v</input>
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
        
        <value name="TierPoolCapacity" value="/Tier_Info/Thin_Pool_Info/enabled_gb" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        
        <value name="TierPoolFreeCapacity" value="/Tier_Info/Thin_Pool_Info/free_gb" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        
        <value name="TierPoolUsedCapacity" value="/Tier_Info/Thin_Pool_Info/used_gb" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        
        <property-set name="symProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-TIER-POOL"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="Storage Pool"/>
            <property name="part" type="data" value="../pool_name"/>
            <property name="poolname" type="data" value="../pool_name"/>
            <property name="tiertype" type="data" value="../../tier_type"/>
            <property name="tiername" type="data" value="../../tier_name"/>
            <property name="diskloc" type="data" value="../../disk_location"/>
            <property name="disktype" type="data" value="../../technology">
                <replace value="FC" by="Fibre Channel"/>
                <replace value="SATA" by="SATA"/>
                <replace value="EFD" by="Enterprise Flash Drive"/>
                <replace value="Flash Drive" by="Enterprise Flash Drive"/>
                
                <!-- Seeing "Unknown" for EFD on Sym904 in lab -->
                <replace value="Unknown" by="Enterprise Flash Drive"/>
            </property>
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-STORAGE-GROUPS" variable="source device parttype sgname part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>SG</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symsg -output XML -sid (host) list -v</input>
[#else]
            <input>conf/vmax.sh symsg -output XML -sid (host) list -v</input>
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
        <value name="SGLunCapacity" value="//DEVS_List/Device/megabytes" unit="GB">
            <property-set>symProperties</property-set>
        </value>
        <property-set name="symProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-STORAGE-GROUPS"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="part" type="data" value="../dev_name"/>
            <property name="partid" type="data" value="../dev_name"/>
            <property name="devconf" value="../configuration"/>
            <property name="sgname" type="data" value="../../../SG_Info/name"/>
            <property name="inmvsg" type="data" value="number(exists(../../../SG_Info[Masking_views='Yes']/Masking_views))"/>
            <property name="infastsg" type="data" value="number(exists(../../../SG_Info[FAST_Policy='Yes']/FAST_Policy))"/>
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-DEVICES-POOL" variable="source device parttype part poolname name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Device</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symcfg -output XML -sid (host) list -tdev -detail -mb</input>
[#else]
            <input>conf/vmax.sh symcfg -output XML -sid (host) list -tdev -detail -mb</input>
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
        <timestamp type="use-system-time" />
        
        <value name="PoolUsedCapacity" value="/Device/pool/alloc_tracks_mb" unit="GB">
            <property-set>Properties</property-set>
        </value>
        
        <value name="PoolUsedPercentage" value="/Device/pool/pool_alloc_percent" unit="%">
            <property-set>Properties</property-set>
        </value>
        
        <property-set name="Properties">        
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value="" />
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-DEVICES-POOL"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="part" value="../../dev_name"/>
            <property name="partid" value="../../dev_name"/>
            <property name="poolname" value="../pool_name"/>
        </property-set>
    </collecting-configuration>

    <collecting-configuration id="VMAX-DEVICES" variable="source device parttype part name directid port" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <for-each>Device</for-each>
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symdev -output XML -sid (host) list -v -all</input>
[#else]
            <input>conf/vmax.sh symdev -output XML -sid (host) list -v -all</input>
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
                <value>1200</value>
            </parameter>
            <parameter name="connection-timeout">
                <value>1200</value>
            </parameter>
        </data>
        <timestamp type="use-system-time"/>
        <value name="Capacity" value="/Device/Capacity/megabytes" unit="GB">
            <property-set>Properties</property-set>
        </value>
        
        <!-- VMAX - has RAID_Group_Information for every LUN -->
        <value name="RawCapacity" value="/Device/Capacity/megabytes" unit="GB">
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-DEVICES"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="config" value="../../RAID_Group_Information/Mirror_Info/raid_type | ../../Dev_Info/configuration"/>
            <property name="parttype" value="if (exists(../../Flags[meta = 'Member']/meta)) then 'METAMEMBER' else 'LUN'"/>
            <property name="part" value="../../Dev_Info/dev_name"/>
            
            <!-- Sum up the hyper capacities to get raw capacity of RAID Group will assign this later to RawCapacity metric value 
                 in PAH since this cannot be done in raw value XPath expression but can be in property XPath expression. -->
            <property name="rawcap" 
                     value="if (exists(../../RAID_Group_Information | ../../RAID-6_Device | ../../RAID-5_Device)) 
                            then ( sum(../../RAID_Group_Information/Mirror_Info/Hyper_Devices/*/hyper_capacity_in_mb 
                                    | ../../RAID-6_Device/*/hyper_capacity_in_mb 
                                    | ../../RAID-5_Device/*/hyper_capacity_in_mb)
                            ) 
                            else (
                                if (../../Dev_Info[contains(configuration,'TDEV') 
                                                    or contains(configuration,'VDEV') 
                                                    or contains(configuration,'DLDEV')]) 
                                then (0)
                                else (
                                    if (../../Dev_Info[contains(configuration,'Mir') 
                                                    and not(contains(configuration,'3-Way')) 
                                                    and not(contains(configuration,'4-Way'))])  
                                    then (. * 2)
                                    else (
                                        if (../../Dev_Info[contains(configuration,'3-Way')])
                                        then (. * 3)
                                        else (
                                            if (../../Dev_Info[contains(configuration,'4-Way')])
                                            then (. * 4)
                                            else (.)
                                        )
                                    )
                                )
                            )" />
        </value>
        
        <value name="Availability" value="/Device/Dev_Info/service_state" unit="%">
            <replace value="N/A" by="0" />
            <replace value="Normal" by="100"/>
            <replace value="Degraded" by="50"/>
            <replace value="Failed" by="0"/>
            <replace value="Unknown" by="0"/>
            
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-DEVICES"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" value="if (exists(../../Flags[meta = 'Member']/meta)) then 'METAMEMBER' else 'LUN'"/>
            <property name="part" value="../../Dev_Info/dev_name"/>
            <property name="partsn" value="../../Product/wwn"/>
        </value>
        
        <value name="LUNtoDirectorPortAssociation" value="/Device/Device_External_Identity/Front_End/Port/port" unit="">
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-DEVICES"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" value="if (exists(../../../../Flags[meta = 'Member']/meta)) then 'METAMEMBER' else 'LUN'"/>
            <property name="part" value="../../../../Dev_Info/dev_name"/>
            <property name="partsn" value="../../../../Product/wwn"/>
            <property name="directid" value="../director"/>
            <property name="port" value="../port"/>
            <property name="feport" value="concat(../director, ':', ../port)"/>
            <property name="hostlun" value="../host_lun"/>
            
            <!-- If LUN is exposed on a Front-End Array Port then it is mapped -->
            <property name="ismapped" type="hard-coded" value="1"/>
        </value>
        
        <property-set name="Properties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-DEVICES"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" value="if (exists(../../Flags[meta = 'Member']/meta)) then 'METAMEMBER' else 'LUN'"/>
            <property name="part" value="../../Dev_Info/dev_name"/>
            
            <!-- Pad LUN ID so it is 5 characters long. Note: XPath string index starts at 1 -->
            <property name="luntagid" value="concat(../../Product/symid, '_', substring(concat('0', ../../Dev_Info/dev_name),(string-length(concat('0', ../../Dev_Info/dev_name)) - 4),5))"/>
            
            <property name="pdname" value="../../Dev_Info/pd_name"/> 
            <property name="partsn" value="../../Product/wwn"/>
            <property name="partconf" value="../../Flags/meta"/>
            <property name="config" value="../../RAID_Group_Information/Mirror_Info/raid_type | ../../Dev_Info/configuration"/>
            <property name="devconf" value="../../Dev_Info/configuration"/>
            
            <!-- Only works for VMAX -->
            <property name="hypercnt" value="count(../../RAID_Group_Information/Mirror_Info/Hyper_Devices/Hyper)"/>
            
            <property name="dgname" value="if (exists(../../Back_End/Hyper/Disk/disk_group_name)) then (../../Back_End/Hyper/Disk/disk_group_name) else (string('N/A'))"/>
            <property name="dgraid"  value="if (exists(../../RAID_Group_Information/Mirror_Info/raid_type)) 
                                            then (../../RAID_Group_Information/Mirror_Info/raid_type) 
                                            else (
                                                if (exists(../../RAID-5_Device)) 
                                                then ('RAID-5')
                                                else (
                                                    if (exists(../../RAID-6_Device))
                                                    then ('RAID-6')
                                                    else (
                                                        if (../../Dev_Info[contains(configuration,'Mir') 
                                                                            and not(contains(configuration,'3-Way')) 
                                                                            and not(contains(configuration,'4-Way'))])
                                                        then ('RAID-1')
                                                        else (
                                                            if (../../Dev_Info[contains(configuration,'RAID-S') 
                                                                                or contains(configuration,'R-S')])
                                                            then ('RAID-S')
                                                            else (
                                                                if (../../Dev_Info[contains(configuration,'Unprotected')])
                                                                then ('Unprotected')
                                                                else (../../Dev_Info/configuration)
                                                            )
                                                        )
                                                    )
                                                )
                                            )"/>
                                            
            <!-- Only works for VMAX -->
            <property name="spindles" value="concat('|', string-join(../../RAID_Group_Information/Mirror_Info/Hyper_Devices/Hyper/spindle_id, '|'), '|')"/>
            
            <property name="ismapped" value="number(exists(../../Device_External_Identity/Front_End/Port/port))"/>
            
            <property name="symfs" value="../../Flags/symmetrix_filesystem"/>
            <property name="gatekpr" value="../../Flags/gatekeeper"/>
            <property name="aclx" value="../../Flags/aclx"/>
            <property name="vcm" value="../../Flags/vcm"/>
            <property name="ismetah" value="number(exists(../../Flags[meta = 'Head']/meta))"/>
            <!-- Need to determine the strategy for default value for "None" as empty values are not replaced in W4N core -->
            <property name="metadesc" value="../../Flags/meta"> 
               <replace value="Head" by="Meta Head"/>
               <replace value="Member" by="Meta Member"/>
               <replace value="None" by="N/A"/> 
            </property> 
            <!-- Flag to see whether the LUN is meta striped or not -->
            <property name="metaconf" value="../../Meta/configuration"/>
            <property name="stripesz" value="../../Meta/stripe_size"/>
            <!-- Meta head name -->
            <property name="headname" value="../../Meta/Meta_Device[1]/dev_name"/>
            
            <property name="datadev" value="../../Flags/datadev"/>
            <property name="savedev" value="../../Flags/snap_save_device">
                <replace value="N/A" by=""/>
            </property>
            
            <property name="ispolctr" value="number(exists(../../Flags[datadev = 'True']/datadev | ../../Flags[snap_save_device = 'True']/snap_save_device))"/>
            <property name="ispolcsu" value="number(exists(/Device/Dev_Info[contains(configuration,'TDEV') 
                                                                                or contains(configuration,'VDEV')]/configuration))"/>
            
            <property name="ispcbnd" value="number(exists(../../Flags[datadev = 'True']/../Dev_Info[thin_pool_name != 'N/A']/thin_pool_name 
                                                        | ../../Flags[snap_save_device = 'True']/../Dev_Info[save_pool_name != 'N/A']/save_pool_name))"/>
            
            <property name="poolname" value="if (../../Flags[snap_save_device = 'True']) 
                                             then (if (exists(../../Dev_Info/save_pool_name)) 
                                                   then (../../Dev_Info/save_pool_name) 
                                                   else (string('N/A'))) 
                                             else (if (../../Dev_Info[contains(configuration,'VDEV')]) 
                                                   then (../../SNAP_Device/save_pool_name) 
                                                   else (if (../../Flags[datadev = 'True'] or ../../Dev_Info[contains(configuration,'TDEV')]) 
                                                         then (../../Dev_Info/thin_pool_name) 
                                                         else (string('N/A'))))" />
                                                         
            <property name="usedby" value="string('N/A')"/>
        </property-set>
    </collecting-configuration>
    
    <collecting-configuration id="VMAX-DEVICES-THIN" variable="source device parttype part name" timeout="${pollingperiod}" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob" max-threads="10">
        <data>
            <data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.local.CLICommandExecutor</data-accessor>
[#if apg.os == 'windows'] 
            <input>conf/vmax.cmd symcfg -output XML -sid (host) list -tdev</input>
[#else]
            <input>conf/vmax.sh symcfg -output XML -sid (host) list -tdev</input>
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
        
        <value name="SubscribedCapacity" value="/SymCLI_ML/Symmetrix/total_enabled_mb" unit="GB">
            <property-set>systemProperties</property-set>
        </value>
        
        <value name="UserCapacity" value="/SymCLI_ML/Symmetrix/total_bound_mb" unit="GB">
            <property-set>systemProperties</property-set>
        </value>
        
        <value name="SubscribedCapacity" value="/SymCLI_ML/Symmetrix/ThinDevs/Device/total_tracks_mb" unit="GB">
            <property-set>thinProperties</property-set>
        </value>
        
        <value name="UserCapacity" value="/SymCLI_ML/Symmetrix/ThinDevs/Device/alloc_tracks_mb" unit="GB">
            <property-set>thinProperties</property-set>
        </value>
        
        <!-- TODO: Verify that ConsumedCapacity using alloc_tracks_mb is more correct (seems that what 
                   ProSphere is using). 
        <value name="ConsumedCapacity" value="/SymCLI_ML/Symmetrix/ThinDevs/Device/written_tracks_mb" unit="GB">
            <replace value="N/A" by="0"/>
            <property-set>thinProperties</property-set>
        </value> -->
        
        <value name="ConsumedCapacity" value="/SymCLI_ML/Symmetrix/ThinDevs/Device/alloc_tracks_mb" unit="GB">
            <replace value="N/A" by="0"/>
            <property-set>thinProperties</property-set>
        </value>
        
        <property-set name="thinProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-DEVICES-THIN"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="dgstype" type="hard-coded" value="Thin"/>
            <property name="part" value="../dev_name"/>
            <property name="partid" value="../dev_name"/>
            <property name="poolname" value="../pool_name"/>
            <property name="isbound" value="../tdev_status">
                <replace value="Bound" by="1"/>
                <replace value="Unbound" by="0"/>
            </property>
            <property name="poolemul" value="../dev_emul"/>
            
        </property-set>
        
        <property-set name="systemProperties">
            <property name="w4ncert" type="hard-coded" value="1.0"/>
            <property name="datatype" type="hard-coded" value="Block"/>
            <property name="sstype" type="hard-coded" value="Block"/>
            <property name="device" type="host" value=""/>
            <property name="serialnb" type="host" value=""/>
            <property name="arraytyp" type="hard-coded" value="Symmetrix"/>
            <property name="datagrp" type="hard-coded" value="VMAX-DEVICES-THIN"/>
            <property name="devtype" type="hard-coded" value="Array"/>
            <property name="parttype" type="hard-coded" value="LUN"/>
            <property name="part" type="hard-coded" value="System"/>
            <property name="partid" type="hard-coded" value="System"/>
            <property name="dgstype" type="hard-coded" value="Thin"/>
        </property-set>
    </collecting-configuration>
    
</configuration>
