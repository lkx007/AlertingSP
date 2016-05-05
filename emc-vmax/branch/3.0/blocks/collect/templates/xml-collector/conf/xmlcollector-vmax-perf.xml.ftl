[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<configuration xmlns="http://www.watch4net.com/XMLCollector" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/XMLCollector xmlcollector.xsd ">
	<simultaneous-collecting>10</simultaneous-collecting>
	<polling-interval>7200</polling-interval>
	<collecting-group>group</collecting-group>
	<source>VMAX-Collector</source>
	<refresh>14400</refresh>
	<collecting-configuration id="VMAX-Array " max-threads="10" timeout="7200" variable="datagrp device parttype part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input/>
			<host>@url</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
				<value>Accept: application/xml</value>
				<value>Content-Type: application/xml;charset=UTF-8</value>
			</parameter>
			<parameter name="request-1">
				<value/>
				<value>conf/arraymetricstmp.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Array/keys [G]</value>
			</parameter>
			<parameter name="request-2">
				<value>tmp/arraymetricstmp/</value>
				<value>conf/arraymetricsout.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Array/metrics [P,CC]</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp/arraymetricsout/</value>
			</parameter>
		</data>
		<timestamp format="ms">../@timestamp</timestamp>
		<value name="ReadRequests" unit="IOPS" value="/w4n/iterator/resultList/result/READS">
			<property name="namedesc" type="hard-coded" value="The number of host read operations performed each second by all Symmetrix volumes." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteRequests" unit="IOPS" value="/w4n/iterator/resultList/result/WRITES">
			<property name="namedesc" type="hard-coded" value="The number of host write operations performed each second by all Symmetrix volumes." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadThroughput" unit="MB/s" value="/w4n/iterator/resultList/result/MB_READ_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The number of host MBs read by all of the Symmetrix volumes each second." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteThroughput" unit="MB/s" value="/w4n/iterator/resultList/result/MB_WRITE_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The number of host MBs read by all of the Symmetrix volumes each second." />
			<property-set>properties-host</property-set>
		</value>
		<value name="TotalCacheUtilization" unit="%" value="/w4n/iterator/resultList/result/TOTAL_CACHE_UTILIZATION">
			<property name="namedesc" type="hard-coded" value="The percent of system cache that is write pending." />
			<property-set>properties-host</property-set>
		</value>
		<value name="SystemWritePending" unit="Nb/s" value="/w4n/iterator/resultList/result/SYS_WRITE_PENDING_EVENT_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The number of times each second that write activity was heavy enough to use up the system limit set for write tracks occupying cache. When the limit is reached, writes are deferred until data in cache is written to disk." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WritePending" unit="Nb" value="/w4n/iterator/resultList/result/WP">
			<property name="namedesc" type="hard-coded" value="The number of system cache slots that are write pending." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadMiss" unit="Nb/s" value="/w4n/iterator/resultList/result/READ_MISS_PER_SEC">
			<property name="namedesc" type="hard-coded" value="Total read requests from all FE directors per second that were misses. A miss occurs when the requested read data is not found in cache." />
			<property-set>properties-host</property-set>
		</value>
		<value name="IORate" unit="" value="/w4n/iterator/resultList/result/IO_RATE">
			<property name="namedesc" type="hard-coded" value="The number of host IO operations performed each second by all Symmetrix volumes, including writes and random and sequential reads." />
			<property-set>properties-host</property-set>
		</value>
		<property-set name="properties-host">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="datatype" type="hard-coded" value="Block"/>
			<property name="sstype" type="hard-coded" value="Block"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="device" type="data" value="//symmetrixId" />
			<property name="devtype" type="hard-coded" value="Array" />
			<property name="datagrp" type="hard-coded" value="VMAX-Array " />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-FEDirector " max-threads="10" timeout="7200" variable="datagrp device parttype part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input/>
			<host>@url</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
				<value>Accept: application/xml</value>
				<value>Content-Type: application/xml;charset=UTF-8</value>
			</parameter>
			<parameter name="request-1">
				<value/>
				<value>conf/fedirectortmp1.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Array/keys [G]</value>
			</parameter>
			<parameter name="request-2">
				<value>tmp/fedirectortmp1/</value>
				<value>conf/fedirectortmp2.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/FEDirector/keys [P]</value>
			</parameter>
			<parameter name="request-3">
				<value>tmp/fedirectortmp2/</value>
				<value>conf/fedirectorout.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/FEDirector/metrics [P,CC]</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp/fedirectorout/</value>
			</parameter>
		</data>
		<timestamp format="ms">../@timestamp</timestamp>
		<value name="CurrentUtilization" unit="%" value="/w4n/iterator/resultList/result/PERCENT_BUSY">
			<property name="namedesc" type="hard-coded" value="The percent of time the directory is busy." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadHit" unit="%" value="/w4n/iterator/resultList/result/PERCENT_READ_HIT">
			<property name="namedesc" type="hard-coded" value="The percent of read requests that are served from cache." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadMiss" unit="Nb/s" value="/w4n/iterator/resultList/result/READ_MISS_PER_SEC">
			<property name="namedesc" type="hard-coded" value="A read request that cannot be satisfied immediately from the cache and needs to wait for the data to arrive from the disk." />
			<property-set>properties-host</property-set>
		</value>
		<value name="IORate" unit="" value="/w4n/iterator/resultList/result/IO_RATE">
			<property name="namedesc" type="hard-coded" value="A host command for data transfer." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadRequests" unit="IOPS" value="/w4n/iterator/resultList/result/READS">
			<property name="namedesc" type="hard-coded" value="A read data transfer between the director and the cache. An IO may require multiple requests depending on IO size, alignment or both." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteRequests" unit="IOPS" value="/w4n/iterator/resultList/result/WRITES">
			<property name="namedesc" type="hard-coded" value="A write data transfer between the director and the cache. An IO may require multiple requests depending on IO size, alignment or both." />
			<property-set>properties-host</property-set>
		</value>
		<value name="HostMBperSec" unit="" value="/w4n/iterator/resultList/result/HA_MB_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The size of the data transfer from the host in MBs per second." />
			<property-set>properties-host</property-set>
		</value>
		<value name="SystemWP" unit="Events/s" value="/w4n/iterator/resultList/result/SYS_WRITE_PENDING_EVENT_PER_SEC">
			<property name="namedesc" type="hard-coded" value="A write miss due to the system write pending limit having been reached." />
			<property-set>properties-host</property-set>
		</value>
		<value name="DeviceWP" unit="Events/s" value="/w4n/iterator/resultList/result/DEV_WRITE_PENDING_EVENT_PER_SEC">
			<property name="namedesc" type="hard-coded" value="A write miss due to the volume write pending limit having been reached." />
			<property-set>properties-host</property-set>
		</value>
		<value name="Requests" unit="Reqs/s" value="/w4n/iterator/resultList/result/REQUEST_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The data transfer between the director and the cache. An IO may require multiple requests depending on IO size, alignment or both. The requests rate should be either equal to or greater than the IO rate." />
			<property-set>properties-host</property-set>
		</value>
		<property-set name="properties-host">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="datatype" type="hard-coded" value="Block"/>
			<property name="sstype" type="hard-coded" value="Block"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="device" type="data" value="//symmetrixId" />
			<property name="devtype" type="hard-coded" value="Array" />
			<property name="datagrp" type="hard-coded" value="VMAX-FEDirector " />
			<property name="parttype" type="hard-coded" value="Controller"/>
			<property name="partgrp" type="hard-coded" value="Front-End"/>
			<property name="part" type="data" value="//directorId"/>
			<property name="director" type="data" value="//directorId"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-BEDirector " max-threads="10" timeout="7200" variable="datagrp device parttype part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input/>
			<host>@url</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
				<value>Accept: application/xml</value>
				<value>Content-Type: application/xml;charset=UTF-8</value>
			</parameter>
			<parameter name="request-1">
				<value/>
				<value>conf/bedirectortmp1.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Array/keys [G]</value>
			</parameter>
			<parameter name="request-2">
				<value>tmp/bedirectortmp1/</value>
				<value>conf/bedirectortmp2.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/BEDirector/keys [P]</value>
			</parameter>
			<parameter name="request-3">
				<value>tmp/bedirectortmp2/</value>
				<value>conf/bedirectorout.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/BEDirector/metrics [P,CC]</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp/bedirectorout/</value>
			</parameter>
		</data>
		<timestamp format="ms">../@timestamp</timestamp>
		<value name="CurrentUtilization" unit="%" value="/w4n/iterator/resultList/result/PERCENT_BUSY">
			<property name="namedesc" type="hard-coded" value="The percent of time the directory is busy." />
			<property-set>properties-host</property-set>
		</value>
		<value name="IORate" unit="" value="/w4n/iterator/resultList/result/IO_RATE">
			<property name="namedesc" type="hard-coded" value="An IO command to the disk." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadRequests" unit="IOPS" value="/w4n/iterator/resultList/result/READS">
			<property name="namedesc" type="hard-coded" value="A data transfer of a read between the director and the cache." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteRequests" unit="IOPS" value="/w4n/iterator/resultList/result/WRITES">
			<property name="namedesc" type="hard-coded" value="A data transfer of a write between the cache and the director." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadThroughput" unit="MB/s" value="/w4n/iterator/resultList/result/MB_READ_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The reads per second in MBs." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteThroughput" unit="MB/s" value="/w4n/iterator/resultList/result/MB_WRITE_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The writes per second in MBs." />
			<property-set>properties-host</property-set>
		</value>
		<value name="Requests" unit="Reqs/s" value="/w4n/iterator/resultList/result/REQUEST_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The data transfer between the director and the cache. An IO may require multiple requests depending on IO size, alignment or both. The requests rate should be either equal to or greater than the IO rate." />
			<property-set>properties-host</property-set>
		</value>
		<property-set name="properties-host">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="datatype" type="hard-coded" value="Block"/>
			<property name="sstype" type="hard-coded" value="Block"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="device" type="data" value="//symmetrixId" />
			<property name="devtype" type="hard-coded" value="Array" />
			<property name="datagrp" type="hard-coded" value="VMAX-BEDirector " />
			<property name="parttype" type="hard-coded" value="Controller"/>
			<property name="partgrp" type="hard-coded" value="Back-End"/>
			<property name="part" type="data" value="//directorId"/>
			<property name="director" type="data" value="//directorId"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-RDFDirector " max-threads="10" timeout="7200" variable="datagrp device parttype part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input/>
			<host>@url</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
				<value>Accept: application/xml</value>
				<value>Content-Type: application/xml;charset=UTF-8</value>
			</parameter>
			<parameter name="request-1">
				<value/>
				<value>conf/rdfdirectortmp1.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Array/keys [G]</value>
			</parameter>
			<parameter name="request-2">
				<value>tmp/rdfdirectortmp1/</value>
				<value>conf/rdfdirectortmp2.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/RDFDirector/keys [P]</value>
			</parameter>
			<parameter name="request-3">
				<value>tmp/rdfdirectortmp2/</value>
				<value>conf/rdfdirectorout.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/RDFDirector/metrics [P,CC]</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp/rdfdirectorout/</value>
			</parameter>
		</data>
		<timestamp format="ms">../@timestamp</timestamp>
		<value name="CurrentUtilization" unit="%" value="/w4n/iterator/resultList/result/PERCENT_BUSY">
			<property name="namedesc" type="hard-coded" value="The percent of time the directory is busy." />
			<property-set>properties-host</property-set>
		</value>
		<value name="IORate" unit="" value="/w4n/iterator/resultList/result/IO_RATE">
			<property name="namedesc" type="hard-coded" value="A host command for data transfer." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadRequests" unit="IOPS" value="/w4n/iterator/resultList/result/READS">
			<property name="namedesc" type="hard-coded" value="A read data transfer between the director and the cache. An IO may require multiple requests depending on IO size, alignment or both." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteRequests" unit="IOPS" value="/w4n/iterator/resultList/result/WRITES">
			<property name="namedesc" type="hard-coded" value="A write data transfer between the director and the cache. An IO may require multiple requests depending on IO size, alignment or both." />
			<property-set>properties-host</property-set>
		</value>
		<value name="Requests" unit="Reqs/s" value="/w4n/iterator/resultList/result/REQUEST_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The data transfer between the director and the cache. An IO may require multiple requests depending on IO size, alignment or both. The requests rate should be either equal to or greater than the IO rate." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadThroughput" unit="MB/s" value="/w4n/iterator/resultList/result/MB_READ_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The size of the data received in MBs for the director." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteThroughput" unit="MB/s" value="/w4n/iterator/resultList/result/MB_WRITE_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The size of the host data transfer in MBs for the director." />
			<property-set>properties-host</property-set>
		</value>
		<value name="IOServiceTime" unit="ms" value="/w4n/iterator/resultList/result/AVG_IO_SERVICE_TIME">
			<property name="namedesc" type="hard-coded" value="The average time the director takes to serve IO." />
			<property-set>properties-host</property-set>
		</value>
		<property-set name="properties-host">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="datatype" type="hard-coded" value="Block"/>
			<property name="sstype" type="hard-coded" value="Block"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="device" type="data" value="//symmetrixId" />
			<property name="devtype" type="hard-coded" value="Array" />
			<property name="datagrp" type="hard-coded" value="VMAX-RDFDirector " />
			<property name="parttype" type="hard-coded" value="Controller"/>
			<property name="partgrp" type="hard-coded" value="RDF"/>
			<property name="part" type="data" value="//directorId"/>
			<property name="director" type="data" value="//directorId"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-Disk " max-threads="10" timeout="7200" variable="datagrp device parttype partid name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input/>
			<host>@url</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
				<value>Accept: application/xml</value>
				<value>Content-Type: application/xml;charset=UTF-8</value>
			</parameter>
			<parameter name="request-1">
				<value/>
				<value>conf/disktmp1.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Array/keys [G]</value>
			</parameter>
			<parameter name="request-2">
				<value>tmp/disktmp1/</value>
				<value>conf/disktmp2.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Disk/keys [P]</value>
			</parameter>
			<parameter name="request-3">
				<value>tmp/disktmp2/</value>
				<value>conf/diskout.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Disk/metrics [P,CC]</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp/diskout/</value>
			</parameter>
		</data>
		<timestamp format="ms">../@timestamp</timestamp>
		<value name="ReadRequests" unit="IOPS" value="/w4n/iterator/resultList/result/READS">
			<property name="namedesc" type="hard-coded" value="The number of host reads per second for the disk." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteRequests" unit="IOPS" value="/w4n/iterator/resultList/result/WRITES">
			<property name="namedesc" type="hard-coded" value="The number of host writes per second for the disk." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadThroughput" unit="MB/s" value="/w4n/iterator/resultList/result/MB_READ_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The read throughput (MBs) of the disk per second." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteThroughput" unit="MB/s" value="/w4n/iterator/resultList/result/MB_WRITE_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The write throughput (MBs) of the disk per second." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadResponseTime" unit="ms" value="/w4n/iterator/resultList/result/RESPONSE_TIME_READ">
			<property name="namedesc" type="hard-coded" value="The average time it took the disk to serve one read command." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteResponseTime" unit="ms" value="/w4n/iterator/resultList/result/RESPONSE_TIME_WRITE">
			<property name="namedesc" type="hard-coded" value="The average time it took the disk to serve one write command." />
			<property-set>properties-host</property-set>
		</value>
		<value name="IORate" unit="" value="/w4n/iterator/resultList/result/IO_RATE">
			<property name="namedesc" type="hard-coded" value="The number of host read and write requests for the disk." />
			<property-set>properties-host</property-set>
		</value>
		<value name="CurrentUtilization" unit="%" value="/w4n/iterator/resultList/result/PERCENT_DISK_BUSY">
			<property name="namedesc" type="hard-coded" value="The percent of time that the disk is busy serving IOs." />
			<property-set>properties-host</property-set>
		</value>
		<property-set name="properties-host">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="datatype" type="hard-coded" value="Block"/>
			<property name="sstype" type="hard-coded" value="Block"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="device" type="data" value="//symmetrixId" />
			<property name="devtype" type="hard-coded" value="Array" />
			<property name="parttype" type="hard-coded" value="Disk" />
			<property name="partid" type="data" value="//diskId" />
			<property name="datagrp" type="hard-coded" value="VMAX-Disk " />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-StorageGroup " max-threads="10" timeout="7200" variable="datagrp device parttype part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input/>
			<host>@url</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
				<value>Accept: application/xml</value>
				<value>Content-Type: application/xml;charset=UTF-8</value>
			</parameter>
			<parameter name="request-1">
				<value/>
				<value>conf/storagegrouptmp1.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Array/keys [G]</value>
			</parameter>
			<parameter name="request-2">
				<value>tmp/storagegrouptmp1/</value>
				<value>conf/storagegrouptmp2.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/StorageGroup/keys [P]</value>
			</parameter>
			<parameter name="request-3">
				<value>tmp/storagegrouptmp2/</value>
				<value>conf/storagegroupout.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/StorageGroup/metrics [P,CC]</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp/storagegroupout/</value>
			</parameter>
		</data>
		<timestamp format="ms">../@timestamp</timestamp>
		<value name="AverageIOSize" unit="KB" value="/w4n/iterator/resultList/result/AVG_IO_SIZE_KB">
			<property name="namedesc" type="hard-coded" value="Calculated value: (HA Kbytes transferred per sec / total IOs per sec)" />
			<property-set>properties-host</property-set>
		</value>
		<value name="IODensity" unit="" value="/w4n/iterator/resultList/result/IO_DENSITY">
			<property name="namedesc" type="hard-coded" value="The number of backend reads and writes per GB of disk." />
			<property-set>properties-host</property-set>
		</value>
		<value name="IORate" unit="" value="/w4n/iterator/resultList/result/IO_RATE">
			<property name="namedesc" type="hard-coded" value="The host operations performed each second by the group." />
			<property-set>properties-host</property-set>
		</value>
		<value name="SampledAverageReadTime" unit="s" value="/w4n/iterator/resultList/result/SAMPLED_AVG_READ_TIME">
			<property name="namedesc" type="hard-coded" value="The average time that it took the Symmetrix to serve one read IO for this group." />
			<property-set>properties-host</property-set>
		</value>
		<value name="SampledAverageWriteTime" unit="s" value="/w4n/iterator/resultList/result/SAMPLED_AVG_WRITE_TIME">
			<property name="namedesc" type="hard-coded" value="The average time that it took the Symmetrix to serve one write IO for this group." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadHit" unit="%" value="/w4n/iterator/resultList/result/PERCENT_READ_HIT">
			<property name="namedesc" type="hard-coded" value="The percent of read operations, performed by the group, that were immediately satisfied by cache." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadMiss" unit="Nb/s" value="/w4n/iterator/resultList/result/READ_MISS_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The host read operations performed each second by the group that were not satisfied from cache." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadRequests" unit="IOPS" value="/w4n/iterator/resultList/result/READS">
			<property name="namedesc" type="hard-coded" value="The host read operations performed each second by the group." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteRequests" unit="IOPS" value="/w4n/iterator/resultList/result/WRITES">
			<property name="namedesc" type="hard-coded" value="The host write operations performed each second by the group." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadThroughput" unit="MB/s" value="/w4n/iterator/resultList/result/MB_READ_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The cumulative number of host MBs read per second by the group." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteThroughput" unit="MB/s" value="/w4n/iterator/resultList/result/MB_WRITE_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The cumulative number of host MBs written per second by the group." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ResponseTime" unit="ms" value="/w4n/iterator/resultList/result/RESPONSE_TIME">
			<property name="namedesc" type="hard-coded" value="The average time it takes to satisfy IO requests." />
			<property-set>properties-host</property-set>
		</value>
		<property-set name="properties-host">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="datatype" type="hard-coded" value="Block"/>
			<property name="sstype" type="hard-coded" value="Block"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="device" type="data" value="//symmetrixId" />
			<property name="devtype" type="hard-coded" value="Array" />
			<property name="datagrp" type="hard-coded" value="VMAX-StorageGroup " />
			<property name="parttype" type="hard-coded" value="Storage Group"/>
			<property name="sgname" type="data" value="//storageGroupId"/>
			<property name="part" type="data" value="//storageGroupId"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-FEDirectorByPort " max-threads="10" timeout="7200" variable="datagrp device parttype director part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input/>
			<host>@url</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
				<value>Accept: application/xml</value>
				<value>Content-Type: application/xml;charset=UTF-8</value>
			</parameter>
			<parameter name="request-1">
				<value/>
				<value>conf/fedirectorbyporttmp1.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Array/keys [G]</value>
			</parameter>
			<parameter name="request-2">
				<value>tmp/fedirectorbyporttmp1/</value>
				<value>conf/fedirectorbyporttmp2.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/FEDirector/keys [P]</value>
			</parameter>
			<parameter name="request-3">
				<value>tmp/fedirectorbyporttmp2/</value>
				<value>conf/fedirectorbyportout.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/FEDirectorByPort/metrics [P,CC]</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp/fedirectorbyportout/</value>
			</parameter>
		</data>
		<timestamp format="ms">../@timestamp</timestamp>
		<value name="IORate" unit="" value="/w4n/iterator/resultList/result/IO_RATE">
			<property name="namedesc" type="hard-coded" value="A host command for data transfer. " />
			<property-set>properties-host</property-set>
		</value>
		<value name="Throughput" unit="MB/s" value="/w4n/iterator/resultList/result/MB_RATE">
			<property name="namedesc" type="hard-coded" value="The total IO (reads and writes) per second in MBs." />
			<property-set>properties-host</property-set>
		</value>
		<value name="AverageRequestSize" unit="KB" value="/w4n/iterator/resultList/result/AVG_REQ_SIZE_KB">
			<property name="namedesc" type="hard-coded" value="The average size of IO requests in KB." />
			<property-set>properties-host</property-set>
		</value>
		<value name="CurrentUtilization" unit="%" value="/w4n/iterator/resultList/result/UTILIZATION">
			<property name="namedesc" type="hard-coded" value="The amount of time the director port is busy." />
			<property-set>properties-host</property-set>
		</value>
		<property-set name="properties-host">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="datatype" type="hard-coded" value="Block"/>
			<property name="sstype" type="hard-coded" value="Block"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="device" type="data" value="//symmetrixId" />
			<property name="devtype" type="hard-coded" value="Array" />
			<property name="datagrp" type="hard-coded" value="VMAX-FEDirectorByPort " />
			<property name="parttype" type="hard-coded" value="Port"/>
			<property name="partgrp" type="hard-coded" value="Front-End"/>
			<property name="part" type="data" value="//portId"/>
			<property name="director" type="data" value="//directorId"/>
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="VMAX-ThinPool " max-threads="10" timeout="7200" variable="datagrp device parttype part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input/>
			<host>@url</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
				<value>Accept: application/xml</value>
				<value>Content-Type: application/xml;charset=UTF-8</value>
			</parameter>
			<parameter name="request-1">
				<value/>
				<value>conf/thinpooltmp1.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Array/keys [G]</value>
			</parameter>
			<parameter name="request-2">
				<value>tmp/thinpooltmp1/</value>
				<value>conf/thinpooltmp2.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/ThinPool/keys [P]</value>
			</parameter>
			<parameter name="request-3">
				<value>tmp/thinpooltmp2/</value>
				<value>conf/thinpoolout.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/ThinPool/metrics [P,CC]</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp/thinpoolout/</value>
			</parameter>
		</data>
		<timestamp format="ms">../@timestamp</timestamp>
		<value name="IngressTacks" unit="Nb/s" value="/w4n/iterator/resultList/result/INGRESS_TRACKS">
			<property name="namedesc" type="hard-coded" value="The number of tracks entering the pool." />
			<property-set>properties-host</property-set>
		</value>
		<value name="EgressTacks" unit="Nb/s" value="/w4n/iterator/resultList/result/EGRESS_TRACKS">
			<property name="namedesc" type="hard-coded" value="The number of tracks leaving the pool." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ResponseTime" unit="ms" value="/w4n/iterator/resultList/result/BE_RESPONSE_TIME">
			<property name="namedesc" type="hard-coded" value="The average time it took the disk to service IO (DATA pool)." />
			<property-set>properties-host</property-set>
		</value>
		<property-set name="properties-host">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="datatype" type="hard-coded" value="Block"/>
			<property name="sstype" type="hard-coded" value="Block"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="device" type="data" value="//symmetrixId" />
			<property name="devtype" type="hard-coded" value="Array" />
			<property name="datagrp" type="hard-coded" value="VMAX-ThinPool " />
			<property name="parttype" type="hard-coded" value="Storage Pool"/>
			<property name="part" type="data" value="//poolId"/>
		</property-set>
	</collecting-configuration>
[#--
MAV.  Not used yet, mostly because the current implementation of the query fails (returns 0 device group).  Need to check with Unisphere team.
	<collecting-configuration id="VMAX-DeviceGroup " max-threads="10" timeout="7200" variable="datagrp device parttype part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input/>
			<host>@url</host>
			<parameter name="disable-ssl-authentication">
				<value>true</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp</value>
			</parameter>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
			</parameter>
			<parameter name="data-timeout">
				<value>900</value>
			</parameter>
			<parameter name="connection-timeout">
				<value>900</value>
			</parameter>
			<parameter name="headers">
				<value>Accept: application/xml</value>
				<value>Content-Type: application/xml;charset=UTF-8</value>
			</parameter>
			<parameter name="request-1">
				<value/>
				<value>conf/devicegrouptmp1.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/Array/keys [G]</value>
			</parameter>
			<parameter name="request-2">
				<value>tmp/devicegrouptmp1/</value>
				<value>conf/devicegrouptmp2.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/DeviceGroup/keys [P]</value>
			</parameter>
			<parameter name="request-3">
				<value>tmp/devicegrouptmp2/</value>
				<value>conf/devicegroupout.xslt</value>
				<value>strict</value>
				<value>(host)/univmax/restapi/performance/DeviceGroup/metrics [P,CC]</value>
			</parameter>
			<parameter name="output-folder">
				<value>tmp/devicegroupout/</value>
			</parameter>
		</data>
		<timestamp format="ms">../@timestamp</timestamp>
		<value name="ReadHit" unit="%" value="/w4n/iterator/resultList/result/PERCENT_READ_HIT">
			<property name="namedesc" type="hard-coded" value="The percent of read operations, performed by the group, that were immediately satisfied by cache." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadMiss" unit="Nb/s" value="/w4n/iterator/resultList/result/READ_MISS_PER_SEC">
			<property name="namedesc" type="hard-coded" value="The number of random read IOs that were misses." />
			<property-set>properties-host</property-set>
		</value>
		<value name="IORate" unit="" value="/w4n/iterator/resultList/result/IO_RATE">
			<property name="namedesc" type="hard-coded" value="The number of host operations performed each second by the group." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ReadRequests" unit="IOPS" value="/w4n/iterator/resultList/result/READS">
			<property name="namedesc" type="hard-coded" value="The number of host read operations performed each second by the group." />
			<property-set>properties-host</property-set>
		</value>
		<value name="WriteRequests" unit="IOPS" value="/w4n/iterator/resultList/result/WRITES">
			<property name="namedesc" type="hard-coded" value="The number of host write operations performed each second by the group." />
			<property-set>properties-host</property-set>
		</value>
		<value name="HostMBperSec" unit="" value="/w4n/iterator/resultList/result/HA_MB_PER_SEC">
			<property name="namedesc" type="hard-coded" value="Cumulative number of host MBs read/writes per second by the group." />
			<property-set>properties-host</property-set>
		</value>
		<value name="ResponseTime" unit="ms" value="/w4n/iterator/resultList/result/RESPONSE_TIME">
			<property name="namedesc" type="hard-coded" value="The average time it takes to satisfy IO requests." />
			<property-set>properties-host</property-set>
		</value>
		<property-set name="properties-host">
			<property name="w4ncert" type="hard-coded" value="1.0"/>
			<property name="datatype" type="hard-coded" value="Block"/>
			<property name="sstype" type="hard-coded" value="Block"/>
			<property name="host" type="hard-coded" value="@host" />
			<property name="device" type="data" value="//symmetrixId" />
			<property name="devtype" type="hard-coded" value="Array" />
			<property name="datagrp" type="hard-coded" value="VMAX-DeviceGroup " />
			<property name="parttype" type="hard-coded" value="Device Group"/>
			<property name="part" type="data" value="//deviceGroupId"/>
		</property-set>
	</collecting-configuration>
--]
</configuration>