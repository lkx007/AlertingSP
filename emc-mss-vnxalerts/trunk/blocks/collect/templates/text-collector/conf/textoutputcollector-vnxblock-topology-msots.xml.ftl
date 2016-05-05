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
<!-- https://alliance.emc.com/PCDPartners/VPNSearchkm.asp -->
<configuration xmlns="http://www.watch4net.com/TextOutputCollector"	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/TextOutputCollector textoutputcollector.xsd ">
	<simultaneous-collecting>5</simultaneous-collecting>
	<polling-interval>[#if use_advancedsettings]${topology.pollingperiod}[#else]600[/#if]</polling-interval>
	<collecting-group>group</collecting-group>
	<source>VNXBlock-Collector</source>
	<collecting-configuration name="VNX-AGENTS" timeout="300">
		<parsing-configuration-file>conf/parser-agents.xml</parsing-configuration-file>
		<raw-value-group-list master-node="AGENT.*" delete-after-group="true" variable-id="serialnb datagrp parttype part name">
			<property-list name="w4ncert">
				<hardcoded>1.0</hardcoded>
			</property-list>
			<property-list name="deviceid">
				<hardcoded>@deviceid</hardcoded>
			</property-list>
			<property-list name="sstype">
				<hardcoded>@sstype</hardcoded>
			</property-list>
			<property-list name="datatype">
				<hardcoded>Block</hardcoded>
			</property-list>
			<property-list name="serialnb">
				<position>Serial No</position>
			</property-list>
			<property-list name="device">
				<hardcoded>@friendlyname</hardcoded>
			</property-list>
			<property-list name="devtype">
				<hardcoded>Array</hardcoded>
			</property-list>
			<property-list name="datagrp">
				<hardcoded>VNXBlock-Array</hardcoded>
			</property-list>
			<property-list name="host">
				<position>/</position>
			</property-list>
			<property-list name="model">
				<position>Model</position>
			</property-list>
			<property-list name="revision">
				<position>Revision</position>
			</property-list>
			<property-list name="part">
				<hardcoded>System</hardcoded>
			</property-list>
			<property-list name="parttype">
				<hardcoded>Memory</hardcoded>
			</property-list>
			<property-list name="arraytyp">
				<hardcoded>CLARiiON</hardcoded>
			</property-list>
			<property-list name="vendor">
				<hardcoded>EMC Corporation</hardcoded>
			</property-list>
			<value-list name="TotalMemory" leaf="SP Memory" unit="MB"/>
			<value-list name="Availability" leaf="Availability" unit="%">
				<replace value="" by="100"/>
			</value-list>
			<!-- Used for zeroing NULL values. -->
			<value-list name="RemoveMeZero" leaf="RemoveMeZero" unit="">
				<replace value="" by="0"/>
			</value-list>
		</raw-value-group-list>
	</collecting-configuration>
    <collecting-configuration name="VNX-SP-STATE" timeout="300">
                <parsing-configuration-file>conf/parser-sp-state.xml</parsing-configuration-file>
                <raw-value-group-list master-node="AGENT2_.*" delete-after-group="true" variable-id="device ip datagrp parttype part name">

                        <property-list name="w4ncert">
                                <hardcoded>1.0</hardcoded>
                        </property-list>
                        <property-list name="deviceid">
                                <hardcoded>@deviceid</hardcoded>
                        </property-list>
                        <property-list name="sstype">
                                <hardcoded>@sstype</hardcoded>
                        </property-list>
                        <property-list name="datatype">
                                <hardcoded>Block</hardcoded>
                        </property-list>
                        <property-list name="device">
                                <hardcoded>@friendlyname</hardcoded>
                        </property-list>
                        <property-list name="devtype">
                                <hardcoded>Array</hardcoded>
                        </property-list>
                        <property-list name="datagrp">
                                <hardcoded>VNXBlock-Array-SP</hardcoded>
                        </property-list>
                        <property-list name="host">
                                <position>/</position>
                        </property-list>
                        <property-list name="enclosure">
                                <position>EnName</position>
			<!--	<replace value="^\w+\s(.*)$" by="$1" /> -->
                        </property-list>
                        <property-list name="parttype">
                                <hardcoded>VNXBlock SP</hardcoded>
                        </property-list>
                        <property-list name="part">
                                <position>EnName</position> 
			<!--	<replace value="^\w+\s(.*)$" by="$1" />  -->
                        </property-list> 
                        <property-list name="partdesc">
                                <hardcoded>VNX-Block SP Status details</hardcoded>
                        </property-list>
                        <property-list name="arraytype">
                                <hardcoded>CLARiiON</hardcoded>
                        </property-list>
                        <property-list name="vendor">
                                <hardcoded>EMC Corporation</hardcoded>
                        </property-list>
                        <property-list name="ip">       
				<position>/</position>
			</property-list>
					
			<value-list name="SpaStatus" leaf="SpaState" unit="" >
				<replace value="Present" by="100"/>
				<replace value="Removed" by="75"/>
				<replace value="Not Present" by="50"/>
				<replace value="Empty" by="0"/>
			</value-list>			
			<value-list name="SpbStatus" leaf="SpbState" unit="" >
				<replace value="Present" by="100"/>
				<replace value="Removed" by="75"/>
				<replace value="Not Present" by="50"/>
				<replace value="Empty" by="0"/>
			</value-list>			
                </raw-value-group-list>				
    </collecting-configuration>	

    <collecting-configuration name="VNX-SPS-STATE" timeout="300">
                <parsing-configuration-file>conf/parser-sps-state.xml</parsing-configuration-file>
                <raw-value-group-list master-node="AGENT2_.*" delete-after-group="true" variable-id="device ip datagrp parttype part name">

                        <property-list name="w4ncert">
                                <hardcoded>1.0</hardcoded>
                        </property-list>
                        <property-list name="deviceid">
                                <hardcoded>@deviceid</hardcoded>
                        </property-list>
                        <property-list name="sstype">
                                <hardcoded>@sstype</hardcoded>
                        </property-list>
                        <property-list name="datatype">
                                <hardcoded>Block</hardcoded>
                        </property-list>
                        <property-list name="device">
                                <hardcoded>@friendlyname</hardcoded>
                        </property-list>
                        <property-list name="devtype">
                                <hardcoded>Array</hardcoded>
                        </property-list>
                        <property-list name="datagrp">
                                <hardcoded>VNXBlock-Array-SP</hardcoded>
                        </property-list>
                        <property-list name="host">
                                <position>/</position>
                        </property-list>
                        <property-list name="enclosure">
                                <position>SpsAName</position>
				<replace value="(.*) SPS A State$" by="$1" />
                        </property-list>
                        <property-list name="parttype">
                                <hardcoded>VNXBlock SPS</hardcoded>
                        </property-list>
                        <property-list name="part">
                                <position>SpsAName</position>
				<replace value="(.*) SPS A State$" by="$1" />
                        </property-list>
                        <property-list name="partdesc">
                                <hardcoded>VNX-Block Standby Power Supply Status details</hardcoded>
                        </property-list>
                        <property-list name="arraytype">
                                <hardcoded>CLARiiON</hardcoded>
                        </property-list>
                        <property-list name="vendor">
                                <hardcoded>EMC Corporation</hardcoded>
                        </property-list>
                        <property-list name="ip">       
				<position>/</position>
			</property-list>
					
			<value-list name="SpsAStatus" leaf="SpsAStat" unit="" >
				<replace value="Present" by="100"/>
				<replace value="Removed" by="75"/>
				<replace value="Not Present" by="50"/>
				<replace value="Empty" by="0"/>
			</value-list>			
			<value-list name="SpsBStatus" leaf="SpsBStat" unit="" >
				<replace value="Present" by="100"/>
				<replace value="Removed" by="75"/>
				<replace value="Not Present" by="50"/>
				<replace value="Empty" by="0"/>
			</value-list>			
                </raw-value-group-list>				
    </collecting-configuration>	

    <collecting-configuration name="VNX-LCC-STATE" timeout="300">
                <parsing-configuration-file>conf/parser-lcc-state.xml</parsing-configuration-file>
                <raw-value-group-list master-node="AGENT2_.*" delete-after-group="true" variable-id="device ip datagrp parttype part name">

                        <property-list name="w4ncert">
                                <hardcoded>1.0</hardcoded>
                        </property-list>
                        <property-list name="deviceid">
                                <hardcoded>@deviceid</hardcoded>
                        </property-list>
                        <property-list name="sstype">
                                <hardcoded>@sstype</hardcoded>
                        </property-list>
                        <property-list name="datatype">
                                <hardcoded>Block</hardcoded>
                        </property-list>
                        <property-list name="device">
                                <hardcoded>@friendlyname</hardcoded>
                        </property-list>
                        <property-list name="devtype">
                                <hardcoded>Array</hardcoded>
                        </property-list>
                        <property-list name="datagrp">
                                <hardcoded>VNXBlock-Array-SP</hardcoded>
                        </property-list>
                        <property-list name="host">
                                <position>/</position>
                        </property-list>
                        <property-list name="enclosure">
                                <position>LccAName</position>
				<!-- <replace value="(.*) LCC A State$" by="$1" /> -->
                        </property-list>
                        <property-list name="parttype">
                                <hardcoded>VNXBlock LCC</hardcoded>
                        </property-list>
                        <property-list name="part">
                                <position>LccAName</position>
				<!-- <replace value="(.*) LCC A State$" by="$1" /> -->
                        </property-list>
                        <property-list name="partdesc">
                                <hardcoded>VNX-Block Link Control Card Status details</hardcoded>
                        </property-list>
                        <property-list name="arraytype">
                                <hardcoded>CLARiiON</hardcoded>
                        </property-list>
                        <property-list name="vendor">
                                <hardcoded>EMC Corporation</hardcoded>
                        </property-list>
                        <property-list name="ip">       
				<position>/</position>
			</property-list>
					
			<value-list name="LccAStatus" leaf="LccAState" unit="" >
				<replace value="Present" by="100"/>
				<replace value="Removed" by="75"/>
				<replace value="Not Present" by="50"/>
				<replace value="Not" by="50"/>
				<replace value="Empty" by="0"/>
			</value-list>			
			<value-list name="LccBStatus" leaf="LccBState" unit="" >
				<replace value="Present" by="100"/>
				<replace value="Removed" by="75"/>
				<replace value="Not Present" by="50"/>
				<replace value="Not" by="50"/>
				<replace value="Empty" by="0"/>
			</value-list>			
                </raw-value-group-list>				
    </collecting-configuration>	

    <collecting-configuration name="VNX-ENCLOSURE-STATE" timeout="300">
                <parsing-configuration-file>conf/parser-enclosure-state.xml</parsing-configuration-file>
                <raw-value-group-list master-node="AGENT2_.*" delete-after-group="true" variable-id="device ip datagrp parttype part name">

                        <property-list name="w4ncert">
                                <hardcoded>1.0</hardcoded>
                        </property-list>
                        <property-list name="deviceid">
                                <hardcoded>@deviceid</hardcoded>
                        </property-list>
                        <property-list name="sstype">
                                <hardcoded>@sstype</hardcoded>
                        </property-list>
                        <property-list name="datatype">
                                <hardcoded>Block</hardcoded>
                        </property-list>
                        <property-list name="device">
                                <hardcoded>@friendlyname</hardcoded>
                        </property-list>
                        <property-list name="devtype">
                                <hardcoded>Array</hardcoded>
                        </property-list>
                        <property-list name="datagrp">
                                <hardcoded>VNXBlock-Array-Enclosure</hardcoded>
                        </property-list>
                        <property-list name="host">
                                <position>/</position>
                        </property-list>
                        <property-list name="enclosure">
                                <position>EnName</position>
				<replace value="^\w+\s(.*)$" by="$1" /> 
                        </property-list>
                        <property-list name="parttype">
                                <hardcoded>VNXBlock Enclosure</hardcoded>
                        </property-list>
                        <property-list name="part">
                                <position>EnName</position>
				<replace value="^\w+\s(.*)$" by="$1" /> 
                        </property-list>
                        <property-list name="partdesc">
                                <hardcoded>VNX-Block Enclosure Status details</hardcoded>
                        </property-list>
                        <property-list name="arraytype">
                                <hardcoded>CLARiiON</hardcoded>
                        </property-list>
                        <property-list name="vendor">
                                <hardcoded>EMC Corporation</hardcoded>
                        </property-list>
                        <property-list name="ip">       
				<position>/</position>
			</property-list>
                        <property-list name="partstat">       
				<position>Status</position>
			</property-list>

			<value-list name="PresentVal" leaf="Present" unit="watts" />
			<!-- <value-list name="RollingAvgVal" leaf="Rolling" unit="watts" /> -->

                </raw-value-group-list>				
    </collecting-configuration>	

    <collecting-configuration name="VNX-FAN-STATE" timeout="300">
                <parsing-configuration-file>conf/parser-fan-state.xml</parsing-configuration-file>
                <raw-value-group-list master-node="AGENT2_.*" delete-after-group="true" variable-id="device ip datagrp parttype part name">

                        <property-list name="w4ncert">
                                <hardcoded>1.0</hardcoded>
                        </property-list>
                        <property-list name="deviceid">
                                <hardcoded>@deviceid</hardcoded>
                        </property-list>
                        <property-list name="sstype">
                                <hardcoded>@sstype</hardcoded>
                        </property-list>
                        <property-list name="datatype">
                                <hardcoded>Block</hardcoded>
                        </property-list>
                        <property-list name="device">
                                <hardcoded>@friendlyname</hardcoded>
                        </property-list>
                        <property-list name="devtype">
                                <hardcoded>Array</hardcoded>
                        </property-list>
                        <property-list name="datagrp">
                                <hardcoded>VNXBlock-Array-SP</hardcoded>
                        </property-list>
                        <property-list name="host">
                                <position>/</position>
                        </property-list>
                        <property-list name="enclosure">
                                <position>FanName</position>
                        </property-list>
                        <property-list name="parttype">
                                <hardcoded>VNXBlock FAN</hardcoded>
                        </property-list>
                        <property-list name="part">
                                <position>FanName</position>
                        </property-list>
                        <property-list name="partdesc">
                                <hardcoded>VNX-Block Fan Status details</hardcoded>
                        </property-list>
                        <property-list name="arraytype">
                                <hardcoded>CLARiiON</hardcoded>
                        </property-list>
                        <property-list name="vendor">
                                <hardcoded>EMC Corporation</hardcoded>
                        </property-list>
                        <property-list name="ip">       
				<position>/</position>
			</property-list>
					
			<value-list name="FanStatus" leaf="FanState" unit="" >
				<replace value="Present" by="100"/>
				<replace value="Removed" by="75"/>
				<replace value="Not Present" by="50"/>
				<replace value="Not" by="50"/>
				<replace value="Empty" by="0"/>
			</value-list>			
                
		</raw-value-group-list>				
    </collecting-configuration>	

</configuration>
