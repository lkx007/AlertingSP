[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<configuration xmlns="http://www.watch4net.com/XMLCollector" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/XMLCollector xmlcollector.xsd ">
	<simultaneous-collecting>1</simultaneous-collecting>
	[#if emcatmos.use_advancedsettings]
		<polling-interval>${emcatmos.pollingperiod}</polling-interval>
	[#else]
		<polling-interval>3600</polling-interval>
	[/#if]
	
	<collecting-group>group</collecting-group>
	<source>ATMOS-SYSMGMNT</source>
	<refresh>14400</refresh>

	<collecting-configuration id="ATMOSSYSMGMNT_GetAllSites" max-threads="2" timeout="7200" variable="datagrp device name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context-sysmgmnt.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>https://(host)/sysmgmt/rmgs [G,CC]</input>
			<host>@host</host>
			
			<parameter name="headers">
					<value>x-atmos-systemadmin:@sysadminuser</value>
					<value>x-atmos-systemadminpassword:@sysadminpass</value>
				<value>x-atmos-authtype:password</value>
			</parameter>
			<parameter name="username">
				<value>@sysadminuser</value>
			</parameter>
			<parameter name="password">
				<value>@sysadminpass</value>
			</parameter>
			<parameter name="data-timeout">
				<value>300</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>300</value>
			</parameter>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="nodesUp" unit="nb" value="/rmgList/rmg/nodesUp">
			<property name="namedesc" type="hard-coded" value="Number of running Nodes in the Site." />
			<property-set>properties-rmg</property-set>
		</value>
		<value name="nodesDown" unit="nb" value="/rmgList/rmg/nodesDown">
			<property name="namedesc" type="hard-coded" value="Number of Nodes that are down." />
			<property-set>properties-rmg</property-set>
		</value>
		<value name="avgLoad15" unit="" value="/rmgList/rmg/avgLoad15">
			<property name="namedesc" type="hard-coded" value="Average load on RMG in the past 15 minutes." />
			<property-set>properties-rmg</property-set>
		</value>
		<value name="avgLoad5" unit="Bytes" value="/rmgList/rmg/avgLoad5">
			<property name="namedesc" type="hard-coded" value="Average load on RMG in the past 5 minutes." />
			<property-set>properties-rmg</property-set>
		</value>
		<value name="avgLoad1" unit="Bytes" value="/rmgList/rmg/avgLoad1">
			<property name="namedesc" type="hard-coded" value="Average load on RMG in the past 1 minutes." />
			<property-set>properties-rmg</property-set>
		</value>
		<property-set name="properties-rmg">
			<property name="device" type="data" value="../name" />
			<property name="sitename" type="data" value="../name" />
			<property name="location" type="data" value="../location" />
			<property name="nodesUp" type="data" value="../nodesUp" />
			<property name="nodesDown" type="data" value="../nodesDown" />
			<property name="devtype" type="hard-coded" value="Site" />
			<property name="datagrp" type="hard-coded" value="ATMOS-Site" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ATMOSSYSMGMNT_GetAllNodes" max-threads="2" timeout="7200" variable="datagrp sitename device name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context-sysmgmnt.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input />
			<host>@host</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="executor-type">
				<value>CAS</value>
			</parameter>
			<parameter name="username">
				<value>@sysadminuser</value>
			</parameter>
			<parameter name="password">
				<value>@sysadminpass</value>
			</parameter>
			<parameter name="dynamic-url">
				<value />
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
					<value>x-atmos-systemadmin:@sysadminuser</value>
					<value>x-atmos-systemadminpassword:@sysadminpass</value>
				<value>x-atmos-authtype:password</value>
			</parameter>
			<parameter name="request-1">
				<!-- The file to send to the web service -->
				<value/>
				<!-- The XSL file to use to transform the response into the second request -->
				<value>conf/GetRMGNames.xslt</value>
				<!-- The error handling mode (either strict or lenient) -->
				<value>strict</value>
				<!-- The URL of the web service -->
				<value>https://(host)/sysmgmt/rmgs [G,CC]</value>
			</parameter>
			<parameter name="request-2">
				<value/>
				<value/>
				<value>strict</value>
				<value>https://(host)/sysmgmt/~DYNAMIC_URL~/nodes [G,CC]</value>
			</parameter>
		</data>

		<timestamp type="use-system-time" />
		<value name="nodestatus" value="/nodeList/node/@up"> 
			<replace value="true" by="100"/>
			<replace value="false" by="0"/>
			<property-set>properties-node</property-set> 
		</value>
		<property-set name="properties-node">
			<property name="device" type="data" value="../@name" />
			<property name="nodename" type="data" value="../@name" />
			<property name="sitename" type="data" value="../substring-before(@name,'-')" />
			<property name="location" type="data" value="../@location" />
			<property name="mgmtIp" type="data" value="../@mgmtIp" />
			<property name="devtype" type="hard-coded" value="Node" />
			<property name="datagrp" type="hard-coded" value="ATMOS-Node" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ATMOSSYSMGMNT_GetNodeChildren" max-threads="2" timeout="7200" variable="datagrp device parttype part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context-sysmgmnt.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input />
			<host>@host</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="executor-type">
				<value>CAS</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="dynamic-url">
				<value />
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
					<value>x-atmos-systemadmin:@sysadminuser</value>
					<value>x-atmos-systemadminpassword:@sysadminpass</value>
				<value>x-atmos-authtype:password</value>
			</parameter>
			<parameter name="request-1">
				<!-- The file to send to the web service -->
				<value/>
				<!-- The XSL file to use to transform the response into the second request -->
				<value>conf/GetRMGNames.xslt</value>
				<!-- The error handling mode (either strict or lenient) -->
				<value>strict</value>
				<!-- The URL of the web service -->
				<value>https://(host)/sysmgmt/rmgs [G,CC]</value>
			</parameter>
			<parameter name="request-2">
				<value/>
				<value>conf/GetNodeNames.xslt</value>
				<value>strict</value>
				<value>https://(host)/sysmgmt/~DYNAMIC_URL~/nodes [G,CC]</value>
			</parameter>
			<parameter name="request-3">
				<value/>
				<value/>
				<value>strict</value>
				<!-- Actual URL: https://{{ipaddress}}/sysmgmt/rmgs/{{RMG}}/nodes/{{NODES}}-->
				<value>https://(host)/sysmgmt/~DYNAMIC_URL~ [G,CC]</value>
			</parameter>
		</data>

		<timestamp type="use-system-time" />
		<value name="totalMemory" unit="KBytes" value="/node/totalMemory">
			<property name="namedesc" type="hard-coded" value="Total System memory." />
			<property-set>properties-system-memory</property-set>
		</value>
		<value name="freeMemory" unit="KBytes" value="/node/freeMemory">
			<property name="namedesc" type="hard-coded" value="Free System memory." />
			<property-set>properties-system-memory</property-set>
		</value>
		<value name="toremove_usedmemory" unit="KBytes" value="/node/freeMemory">
			<property name="namedesc" type="hard-coded" value="Used System memory." />
			<property-set>properties-system-memory</property-set>
		</value>
		<value name="toremove_currentutil" unit="%" value="/node/freeMemory">
			<property name="namedesc" type="hard-coded" value="CurrentUtilization of System Memory" />
			<property-set>properties-system-memory</property-set>
		</value>
		<value name="totalSwapMemory" unit="KBytes" value="/node/totalSwapMemory">
			<property name="namedesc" type="hard-coded" value="Total Swap memory." />
			<property-set>properties-swap-memory</property-set>
		</value>
		<value name="freeSwapMemory" unit="KBytes" value="/node/freeSwapMemory">
			<property name="namedesc" type="hard-coded" value="Free Swap memory." />
			<property-set>properties-swap-memory</property-set>
		</value>
		<value name="toremove_usedmemory" unit="KBytes" value="/node/freeSwapMemory">
			<property name="namedesc" type="hard-coded" value="Used Swap memory." />
			<property-set>properties-swap-memory</property-set>
		</value>
		<value name="toremove_currentutil" unit="%" value="/node/totalSwapMemory">
			<property name="namedesc" type="hard-coded" value="CurrentUtilization of Swap Memory" />
			<property-set>properties-swap-memory</property-set>
		</value>
		<value name="cpuSystemUsage" unit="%" value="/node/cpuSystemUsage">
			<property name="namedesc" type="hard-coded" value="Processor Usage system mode." />
			<property-set>properties-processor</property-set>
		</value>
		<value name="cpuUserUsage" unit="%" value="/node/cpuUserUsage">
			<property name="namedesc" type="hard-coded" value="Processor Usage user mode." />
			<property-set>properties-processor</property-set>
		</value>
		<value name="cpuIdle" unit="%" value="/node/cpuIdle">
			<property name="namedesc" type="hard-coded" value="Processor Idle." />
			<property-set>properties-processor</property-set>
		</value>
		<value name="toremove_currentutil" unit="%" value="/node/cpuIdle">
			<property name="namedesc" type="hard-coded" value="CurrentUtilization on the Processor" />
			<property-set>properties-processor</property-set>
		</value>
		<value name="numberOfprocesses" unit="nb" value="/node/numberOfprocesses">
			<property name="namedesc" type="hard-coded" value="Total number of processes running on the System." />
			<property-set>properties-processor</property-set>
		</value>
		<property-set name="properties-processor">
			<property name="device" type="data" value="../@name" />
			<property name="nodename" type="data" value="../@name" />
			<property name="sitename" type="data" value="../substring-before(@name,'-')" />
			<property name="location" type="data" value="../@location" />
			<property name="nodetype" type="data" value="../machineType" />
			<property name="osname" type="data" value="../operationSystem" />
			<property name="atmosver" type="data" value="../atmosVersion" />
			<property name="numcpu" type="data" value="../numberOfcpu" />
			<property name="cpuspeed" type="data" value="../cpuSpeed" />
			<property name="part" type="hard-coded" value="CPU" />
			<property name="parttype" type="hard-coded" value="Processor" />
			<property name="devtype" type="hard-coded" value="Node" />
			<property name="datagrp" type="hard-coded" value="ATMOS-Processor" />
		</property-set>
		<property-set name="properties-system-memory">
			<property name="device" type="data" value="../@name" />
			<property name="nodename" type="data" value="../@name" />
			<property name="sitename" type="data" value="../substring-before(@name,'-')" />
			<property name="location" type="data" value="../@location" />
			<property name="part" type="hard-coded" value="System" />
			<property name="parttype" type="hard-coded" value="Memory" />
			<property name="devtype" type="hard-coded" value="Node" />
			<property name="datagrp" type="hard-coded" value="ATMOS-Memory" />
		</property-set>
		<property-set name="properties-swap-memory">
			<property name="device" type="data" value="../@name" />
			<property name="nodename" type="data" value="../@name" />
			<property name="sitename" type="data" value="../substring-before(@name,'-')" />
			<property name="location" type="data" value="../@location" />
			<property name="part" type="hard-coded" value="Swap" />
			<property name="parttype" type="hard-coded" value="Memory" />
			<property name="devtype" type="hard-coded" value="Node" />
			<property name="datagrp" type="hard-coded" value="ATMOS-Memory" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ATMOSSYSMGMNT_GetNodeWSStats" max-threads="2" timeout="7200" variable="datagrp device parttype part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context-sysmgmnt.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input />
			<host>@host</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="executor-type">
				<value>CAS</value>
			</parameter>
			<parameter name="username">
				<value>@sysadminuser</value>
			</parameter>
			<parameter name="password">
				<value>@sysadminpass</value>
			</parameter>
			<parameter name="dynamic-url">
				<value />
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
					<value>x-atmos-systemadmin:@sysadminuser</value>
					<value>x-atmos-systemadminpassword:@sysadminpass</value>
				<value>x-atmos-authtype:password</value>
			</parameter>
			<parameter name="request-1">
				<value/>
				<value>conf/GetRMGNames.xslt</value>
				<value>strict</value>
				<value>https://(host)/sysmgmt/rmgs [G,CC]</value>
			</parameter>
			<parameter name="request-2">
				<value/>
				<value>conf/GetNodeNames.xslt</value>
				<value>strict</value>
				<value>https://(host)/sysmgmt/~DYNAMIC_URL~/nodes [G,CC]</value>
			</parameter>
			<parameter name="request-3">
				<value/>
				<value/>
				<value>strict</value>
				<value>https://(host)/sysmgmt/~DYNAMIC_URL~/wsstats [G,CC]</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="rawReadsPerSec" value="/WSStat/ReadsPerSec">
			<property name="namedesc" type="hard-coded" value="Total number of Read transactions (List, Get, Head) per second." />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawWritesPerSec" value="/WSStat/WritesPerSec">
			<property name="namedesc" type="hard-coded" value="Total number of Write transactions (PUT, POST) per second." />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawDeletesPerSec" value="/WSStat/DeletesPerSec">
			<property name="namedesc" type="hard-coded" value="Total number of delete transactions (DELETE) per second." />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawTransPerSec" value="/WSStat/TransPerSec">
			<property name="namedesc" type="hard-coded" value="Total number of transactions per second." />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawMeanReadLatencyMS" unit="ms" value="/WSStat/MeanReadLatencyMS">
			<property name="namedesc" type="hard-coded" value="Mean latency is the sum of the individual latencies reported at logging time, divided by the total number of transactions." />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawMeanWriteLatencyMS" unit="ms" value="/WSStat/MeanWriteLatencyMS">
			<property name="namedesc" type="hard-coded" value="Mean latency is the sum of the individual latencies reported at logging time, divided by the total number of transactions." />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawMeanLatencyMS" unit="ms" value="/WSStat/MeanLatencyMS">
			<property name="namedesc" type="hard-coded" value="Mean latency is the sum of the individual latencies reported at logging time, divided by the total number of transactions." />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawReads" unit="nb" value="/WSStat/Reads">
			<property name="namedesc" type="hard-coded" value="Total number of Read transactions (GET,HEAD, LIST)." />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawWrites" unit="nb" value="/WSStat/Writes">
			<property name="namedesc" type="hard-coded" value="Total number of Writes transactions (PUT, POST)." />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawDeletes" unit="nb" value="/WSStat/Deletes">
			<property name="namedesc" type="hard-coded" value="Total number of delete transactions (DELETE)." />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawTotal" unit="nb" value="/WSStat/Total">
			<property name="namedesc" type="hard-coded" value="Total number of transactions." />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawReadLatencyMS" unit="ms" value="/WSStat/ReadLatencyMS">
			<property name="namedesc" type="hard-coded" value="This latency is reported for each Read operation in milliseconds" />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawWriteLatencyMS" unit="ms" value="/WSStat/WriteLatencyMS">
			<property name="namedesc" type="hard-coded" value="This latency is reported for each write operation in milliseconds" />
			<property-set>properties-webservice</property-set>
		</value>
		<value name="rawDeleteLatencyMS" unit="ms" value="/WSStat/DeleteLatencyMS">
			<property name="namedesc" type="hard-coded" value="This latency is reported for each delete operation in milliseconds" />
			<property-set>properties-webservice</property-set>
		</value>
		
		<value name="rawUptimeMS" unit="ms" value="/WSStat/UptimeMS">
			<property name="namedesc" type="hard-coded" value="Server Uptime." />
			<property-set>properties-webservice</property-set>
		</value>
		<property-set name="properties-webservice">
			<property name="device" type="data" value="../Node/@name" />
			<property name="nodename" type="data" value="../Node/@name" />
			<property name="sitename" type="data" value="../Node/substring-before(@name,'-')" />
			<property name="part" type="hard-coded" value="WebService" />
			<property name="parttype" type="hard-coded" value="Service" />
			<property name="devtype" type="hard-coded" value="Node" />
			<property name="datagrp" type="hard-coded" value="ATMOS-Service" />
		</property-set>
	</collecting-configuration>
</configuration>