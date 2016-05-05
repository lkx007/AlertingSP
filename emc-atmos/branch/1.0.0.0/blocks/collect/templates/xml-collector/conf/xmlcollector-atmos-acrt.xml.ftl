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
	<source>ATMOS-ACRT</source>
	<refresh>14400</refresh>
	
	
	<collecting-configuration id="ATMOSACRT_GetAllSites" max-threads="2" timeout="7200" variable="datagrp device name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context-acrt.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>http://(host)/capacity/latest/sites [G,CC]</input>
			<host>@host</host>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
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
		<value name="used_capacity" unit="Bytes" value="/result/sites/site/used_capacity">
			<property name="namedesc" type="hard-coded" value="This is the used Capacity on a specific RMG" />
			<property-set>properties-rmg</property-set>
		</value>
		<value name="free_capacity" unit="Bytes" value="/result/sites/site/free_capacity">
			<property name="namedesc" type="hard-coded" value="This is the free Capacity on a specific RMG" />
			<property-set>properties-rmg</property-set>
		</value>
		<value name="total_capacity" unit="Bytes" value="/result/sites/site/capacity">
			<property name="namedesc" type="hard-coded" value="This is the Total Capacity on a specific RMG" />
			<property-set>properties-rmg</property-set>
		</value>
		<value name="toremove_currentutil" unit="%" value="/result/sites/site/capacity">
			<property name="namedesc" type="hard-coded" value="This is the CurrentUtilization on a specific RMG" />
			<property-set>properties-rmg</property-set>
		</value>
		<property-set name="properties-rmg">
			<property name="device" type="data" value="../name" />
			<property name="sitename" type="data" value="../name" />
			<property name="location" type="data" value="../location" />
			<property name="devtype" type="hard-coded" value="Site" />
			<property name="datagrp" type="hard-coded" value="ATMOS-Site" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ATMOSACRT_GetAllClusters" max-threads="2" timeout="7200" variable="datagrp sitename device name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context-acrt.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>http://(host)/capacity/latest/clusters [G,CC]</input>
			<host>@host</host>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
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
		<value name="used_capacity" unit="Bytes" value="/result/clusters/cluster/used_capacity">
			<property name="namedesc" type="hard-coded" value="This is the Used Capacity on Installation Segment or Cluster" />
			<property-set>properties-cluster</property-set>
		</value>
		<value name="free_capacity" unit="Bytes" value="/result/clusters/cluster/free_capacity">
			<property name="namedesc" type="hard-coded" value="This is the Free Capacity on Installation Segment or Cluster" />
			<property-set>properties-cluster</property-set>
		</value>
		<value name="total_capacity" unit="Bytes" value="/result/clusters/cluster/capacity">
			<property name="namedesc" type="hard-coded" value="This is the Total Capacity on Installation Segment or Cluster" />
			<property-set>properties-cluster</property-set>
		</value>
		<value name="toremove_currentutil" unit="%" value="/result/clusters/cluster/capacity">
			<property name="namedesc" type="hard-coded" value="This is the CurrentUtilization on Installation Segment or Cluster" />
			<property-set>properties-cluster</property-set>
		</value>
		<property-set name="properties-cluster">
			<property name="device" type="data" value="../name" />
			<property name="sitename" type="data" value="../site_name" />
			<property name="siteid" type="data" value="../site_id" />
			<property name="devtype" type="hard-coded" value="Cluster" />
			<property name="datagrp" type="hard-coded" value="ATMOS-Cluster" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ATMOSACRT_GetAllNodes" max-threads="2" timeout="7200" variable="datagrp sitename device name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context-acrt.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>http://(host)/capacity/latest/nodes [G,CC]</input>
			<host>@host</host>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
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
		<value name="used_capacity" unit="Bytes" value="/result/nodes/node/used_capacity">
			<property name="namedesc" type="hard-coded" value="This is the Used Capacity on a Node" />
			<property-set>properties-node</property-set>
		</value>
		<value name="free_capacity" unit="Bytes" value="/result/nodes/node/free_capacity">
			<property name="namedesc" type="hard-coded" value="This is the Free Capacity on a Node" />
			<property-set>properties-node</property-set>
		</value>
		<value name="total_capacity" unit="Bytes" value="/result/nodes/node/capacity">
			<property name="namedesc" type="hard-coded" value="This is the Total Capacity on a Node" />
			<property-set>properties-node</property-set>
		</value>
		<value name="toremove_currentutil" unit="%" value="/result/nodes/node/capacity">
			<property name="namedesc" type="hard-coded" value="This is the CurrentUtilization on a Node" />
			<property-set>properties-node</property-set>
		</value>
		<property-set name="properties-node">
			<property name="device" type="data" value="../name" />
			<property name="nodename" type="data" value="../name" />
			<property name="cluster" type="data" value="../cluster_name" />
			<property name="clustid" type="data" value="../cluster_id" />
			<property name="sitename" type="data" value="../site_name" />
			<property name="siteid" type="data" value="../site_id" />
			<property name="devtype" type="hard-coded" value="Node" />
			<property name="datagrp" type="hard-coded" value="ATMOS-Node" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ATMOSACRT_GetAllFileSystems" max-threads="2" timeout="7200" variable="datagrp device parttype part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context-acrt.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>http://(host)/capacity/latest/filesystems [G,CC]</input>
			<host>@host</host>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
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
		<value name="used_capacity" unit="Bytes" value="/result/filesystems/filesystem/used_capacity">
			<property name="namedesc" type="hard-coded" value="This is the Used Capacity on a specific filesystem in a Node" />
			<property-set>properties-filesystem</property-set>
		</value>
		<value name="free_capacity" unit="Bytes" value="/result/filesystems/filesystem/free_capacity">
			<property name="namedesc" type="hard-coded" value="This is the Free Capacity on a specific filesystem in a Node" />
			<property-set>properties-filesystem</property-set>
		</value>
		<value name="total_capacity" unit="Bytes" value="/result/filesystems/filesystem/capacity">
			<property name="namedesc" type="hard-coded" value="This is the Total Capacity on a specific filesystem in a Node" />
			<property-set>properties-filesystem</property-set>
		</value>
		<value name="toremove_currentutil" unit="%" value="/result/filesystems/filesystem/capacity">
			<property name="namedesc" type="hard-coded" value="This is the CurrentUtilization on a filesystem in a Node" />
			<property-set>properties-filesystem</property-set>
		</value>
		<property-set name="properties-filesystem">
			<property name="blkdevic" type="data" value="../path" />
			<property name="device" type="data" value="../node_name" />
			<property name="nodename" type="data" value="../node_name" />
			<property name="nodeid" type="data" value="../node_id" />
			<property name="part" type="data" value="../mount" />
			<property name="devtype" type="hard-coded" value="Node" />
			<property name="parttype" type="hard-coded" value="FileSystem" />
			<property name="datagrp" type="hard-coded" value="ATMOS-FileSystem" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ATMOSACRT_GetTenants" max-threads="2" timeout="7200" variable="datagrp device name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<data>
			<include-contexts>conf/context-acrt.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.CASXmlRequestExecutor</data-accessor>
			<input>http://(host)/capacity/latest/tenants [G,CC]</input>
			<host>@host</host>
			<parameter name="username">
				<value>@username</value>
			</parameter>
			<parameter name="password">
				<value>@password</value>
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
		<value name="num_objects" unit="nb" value="/result/tenants/tenant/num_objects">
			<property name="namedesc" type="hard-coded" value="The total number of objects for the selected tenant" />
			<property-set>properties-tenant</property-set>
		</value>
		<value name="object_size_user" unit="Bytes" value="/result/tenants/tenant/object_size_user">
			<property name="namedesc" type="hard-coded" value="The usage from a user's perspective, which does not include the number of replicas" />
			<property-set>properties-tenant</property-set>
		</value>
		<value name="object_size" unit="Bytes" value="/result/tenants/tenant/object_size">
			<property name="namedesc" type="hard-coded" value="Used capacity for the selected tenant" />
			<property-set>properties-tenant</property-set>
		</value>
		<value name="toremove_freememory" unit="Bytes" value="/result/tenants/tenant/object_size">
			<property name="namedesc" type="hard-coded" value="Free capacity for the selected tenant" />
			<property-set>properties-tenant</property-set>
		</value>
		<value name="toremove_currentutil" unit="Bytes" value="/result/tenants/tenant/object_size">
			<property name="namedesc" type="hard-coded" value="Current Utilization for the selected tenant" />
			<property-set>properties-tenant</property-set>
		</value>
		<value name="average_object_capacity" unit="Bytes" value="/result/tenants/tenant/object_size_user">
			<property name="namedesc" type="hard-coded" value="Average size of the objects for the selected tenant, ObjectCapacity/ObjectCount" />
			<property-set>properties-tenant</property-set>
		</value>
		<value name="metadata_size" unit="Bytes" value="/result/tenants/tenant/metadata_size">
			<property name="namedesc" type="hard-coded" value="The metadata capacity for the selected tenant" />
			<property-set>properties-tenant</property-set>
		</value>
		<value name="total_size" unit="Bytes" value="/result/tenants/tenant/total_size">
			<property name="namedesc" type="hard-coded" value="The total capacity of the objects plus the metadata for the selected tenant" />
			<property-set>properties-tenant</property-set>
		</value>
		<property-set name="properties-tenant">
			<property name="device" type="data" value="../name" />
			<property name="tenantnm" type="data" value="../name" />
			<property name="tenuuid" type="data" value="../uuid" />
			<property name="tenantid" type="data" value="../id" />
			<property name="devtype" type="hard-coded" value="Tenant" />
			<property name="datagrp" type="hard-coded" value="ATMOS-Tenant" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ATMOSACRT_GetSubTenants" max-threads="2" timeout="7200" variable="datagrp tenantnm device name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<!--<for-each namespace-uri="http://www.w3.org/2005/Atom">entry</for-each>-->
		<data>
			<include-contexts>conf/context-acrt.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input />
			<host>@host</host>
			<parameter name="disable-ssl-authentication"><value>true</value></parameter>
			<parameter name="output-folder"><value>tmp</value></parameter>
			<parameter name="executor-type"><value>CAS</value></parameter>
			<parameter name="username"><value>@username</value></parameter>
			<parameter name="password"><value>@password</value></parameter>
			<parameter name="dynamic-url"><value /></parameter>
			<parameter name="data-timeout"><value>900</value></parameter>
			<parameter name="connection-timeout"><value>900</value></parameter>
			<parameter name="request-1">
				<!-- The file to send to the web service -->
				<value></value>
				<!-- The XSL file to use to transform the response into the second request -->
				<value>conf/GetTenantId.xslt</value>
				<!-- The error handling mode (either strict or lenient) -->
				<value>strict</value>
				<!-- The URL of the web service -->
				<value>http://(host)/capacity/latest/tenants [G]</value>
			</parameter>
			<parameter name="request-2">
				<value></value>
				<value></value>
				<value>strict</value>
				<value>http://(host)/capacity/latest/subtenants?~DYNAMIC_URL~ [G]</value>
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="num_objects" unit="nb" value="/result/subtenants/subtenant/num_objects">
			<property name="namedesc" type="hard-coded" value="The total number of objects for the selected subtenant" />
			<property-set>properties-subtenant</property-set>
		</value>
		<value name="object_size_user" unit="Bytes" value="/result/subtenants/subtenant/object_size_user">
			<property name="namedesc" type="hard-coded" value="The usage from a user's perspective, which does not include the number of replicas" />
			<property-set>properties-subtenant</property-set>
		</value>
		<value name="object_size" unit="Bytes" value="/result/subtenants/subtenant/object_size">
			<property name="namedesc" type="hard-coded" value="The capacity of the objects for the selected subtenant" />
			<property-set>properties-subtenant</property-set>
		</value>
		<value name="average_object_capacity" unit="Bytes" value="/result/subtenants/subtenant/average_object_capacity">
			<property name="namedesc" type="hard-coded" value="The capacity of the objects for the selected subtenant, ObjectCapacity/ObjectCount" />
			<property-set>properties-subtenant</property-set>
		</value>
		<value name="metadata_size" unit="Bytes" value="/result/subtenants/subtenant/metadata_size">
			<property name="namedesc" type="hard-coded" value="The metadata capacity for the selected subtenant." />
			<property-set>properties-subtenant</property-set>
		</value>
		<value name="total_size" unit="Bytes" value="/result/subtenants/subtenant/total_size">
			<property name="namedesc" type="hard-coded" value="The total capacity of the objects plus the metadata for the selected subtenant." />
			<property-set>properties-subtenant</property-set>
		</value>
		<value name="percent_total_size" unit="%" value="/result/subtenants/subtenant/percent_total_size">
			<property name="namedesc" type="hard-coded" value="Current Utilization of subtenant in the Tenant." />
			<property-set>properties-subtenant</property-set>
		</value>
		<value name="toremove_freememory" unit="Bytes" value="/result/subtenants/subtenant/total_size">
			<property name="namedesc" type="hard-coded" value="Free capacity for the selected subtenant" />
			<property-set>properties-subtenant</property-set>
		</value>
		<value name="toremove_currentutil" unit="Bytes" value="/result/subtenants/subtenant/total_size">
			<property name="namedesc" type="hard-coded" value="Current Utilization of  subtenant" />
			<property-set>properties-subtenant</property-set>
		</value>
		
		<property-set name="properties-subtenant">
			<property name="device" type="data" value="../name" />
			<property name="stenname" type="data" value="../name" />
			<property name="stenuuid" type="data" value="../uuid" />
			<property name="stenanid" type="data" value="../id" />
			<property name="tenantid" type="data" value="../tenant_id" />
			<property name="tenantnm" type="data" value="../tenant_name" />
			<property name="devtype" type="hard-coded" value="SubTenant" />
			<property name="datagrp" type="hard-coded" value="ATMOS-SubTenant" />
		</property-set>
	</collecting-configuration>
	<collecting-configuration id="ATMOSACRT_GetAllUsers" max-threads="2" timeout="7200" variable="datagrp device parttype part name" xml-job="com.watch4net.apg.v2.collector.plugins.xmlcollector.engine.NuxXmlJob">
		<!--<for-each namespace-uri="http://www.w3.org/2005/Atom">entry</for-each>-->
		<data>
			<include-contexts>conf/context-acrt.xml</include-contexts>
			<data-accessor>com.watch4net.apg.v2.collector.plugins.outputparsing.executing.remote.soap.ChainedWebServiceRequestsExecutor</data-accessor>
			<input />
			<host>@host</host>
			<parameter name="disable-ssl-authentication"><value>true</value></parameter>
			<parameter name="executor-type"><value>CAS</value></parameter>
			<parameter name="username"><value>@username</value></parameter>
			<parameter name="password"><value>@password</value></parameter>
			<parameter name="dynamic-url"><value /></parameter>
			<parameter name="data-timeout"><value>900</value></parameter>
			<parameter name="connection-timeout"><value>900</value></parameter>
			<parameter name="output-folder"><value>tmp</value></parameter>
			<parameter name="request-1">
				<!-- The file to send to the web service -->
				<value />
				<!-- The XSL file to use to transform the response into the second request -->
				<value>conf/GetTenantId.xslt</value>
				<!-- The error handling mode (either strict or lenient) -->
				<value>strict</value>
				<!-- The URL of the web service -->
				<value>http://(host)/capacity/latest/tenants [G]</value>
				<value />
			</parameter>
			<parameter name="request-2">
				<!-- The file to send to the web service -->
				<value />
				<!-- The XSL file to use to transform the response into the second request -->
				<value>conf/GetSubTenantId.xslt</value>
				<!-- The error handling mode (either strict or lenient) -->
				<value>strict</value>
				<!-- The URL of the web service -->
				<value>http://(host)/capacity/latest/subtenants?~DYNAMIC_URL~ [G]</value>
				<value />
			</parameter>
			<parameter name="request-3">
				<!-- The file to send to the web service -->
				<value />
				<!-- The XSL file to use to transform the response into the second request -->
				<value />
				<!-- The error handling mode (either strict or lenient) -->
				<value>strict</value>
				<!-- The URL of the web service -->
				<value>http://(host)/capacity/latest/uids?~DYNAMIC_URL~ [G]</value>
				<value />
			</parameter>
		</data>
		<timestamp type="use-system-time" />
		<value name="num_objects" unit="nb" value="/result/uids/uid/num_objects">
			<property name="namedesc" type="hard-coded" value="The total number of objects for the selected UID" />
			<property-set>properties-user</property-set>
		</value>
		<value name="object_size_user" unit="Bytes" value="/result/uids/uid/object_size_user">
			<property name="namedesc" type="hard-coded" value="The usage from a user's perspective, which does not include the number of replicas" />
			<property-set>properties-user</property-set>
		</value>
		<value name="object_size" unit="Bytes" value="/result/uids/uid/object_size">
			<property name="namedesc" type="hard-coded" value="The capacity of the objects for the selected UID" />
			<property-set>properties-user</property-set>
		</value>
		<value name="average_object_capacity" unit="Bytes" value="/result/uids/uid/average_object_capacity">
			<property name="namedesc" type="hard-coded" value="The capacity of the objects for the selected UID" />
			<property-set>properties-user</property-set>
		</value>
		<value name="metadata_size" unit="Bytes" value="/result/uids/uid/metadata_size">
			<property name="namedesc" type="hard-coded" value="The metadata capacity for the selected UID." />
			<property-set>properties-user</property-set>
		</value>
		<value name="total_size" unit="Bytes" value="/result/uids/uid/total_size">
			<property name="namedesc" type="hard-coded" value="The total capacity of the objects plus the metadata for the selected UID." />
			<property-set>properties-user</property-set>
		</value>
		<value name="percent_total_size" unit="Bytes" value="/result/uids/uid/percent_total_size">
			<property name="namedesc" type="hard-coded" value="Current Utilization of UID in the SubTenant" />
			<property-set>properties-user</property-set>
		</value>
		<value name="toremove_freememory" unit="Bytes" value="/result/uids/uid/total_size">
			<property name="namedesc" type="hard-coded" value="Free capacity for the selected UID" />
			<property-set>properties-user</property-set>
		</value>
		<value name="toremove_currentutil" unit="Bytes" value="/result/uids/uid/total_size">
			<property name="namedesc" type="hard-coded" value="Current Utilization of  UID" />
			<property-set>properties-user</property-set>
		</value>
		
		<property-set name="properties-user">
			<property name="part" type="data" value="../name" />
			<property name="device" type="data" value="../subtenant_name" />
			<property name="userid" type="data" value="../id" />
			<property name="stenanid" type="data" value="../subtenant_id" />
			<property name="stenname" type="data" value="../subtenant_name" />
			<property name="parttype" type="hard-coded" value="UID" />
			<property name="devtype" type="hard-coded" value="SubTenant" />
			<property name="datagrp" type="hard-coded" value="ATMOS-Users" />
		</property-set>
	</collecting-configuration>
</configuration>