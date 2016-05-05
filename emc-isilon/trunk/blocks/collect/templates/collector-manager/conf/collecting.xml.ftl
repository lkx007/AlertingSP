[#ftl]
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
<config xmlns="http://www.watch4net.com/APG/Collecting" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.watch4net.com/APG/Collecting collecting.xsd ">
	<connectors>
		<connector enabled="true" name="Backend" type="Socket-Connector" config="conf/socketconnector.xml" />
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

		<filter enabled="true" name="ISILON-PTF1" next="FailOver IgnoreErrors" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/ptf-isilon.xml" />
		<filter enabled="true" name="ISILON-ICF1" next="ISILON-PTF1" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/icf-isilon.xml" />
		<filter enabled="true" name="ISILON-VHF1" next="ISILON-ICF1" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-isilon.xml" />
		<filter enabled="true" name="ISILON-CRF1" next="ISILON-VHF1" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/isilon1.xml" />
	</filters>
	<collectors>
[#if emcisilon.system??]
		<collector enabled="true" name="Isilon-Capacity" next="ISILON-CRF1" config="XML-Collector/${module['xml-collector'].instance}/conf/isilon-capacity.xml" />
		<collector enabled="true" name="Isilon-Performance" next="ISILON-CRF1" config="XML-Collector/${module['xml-collector'].instance}/conf/isilon-performance.xml" />
[#else]
		<collector enabled="false" name="Isilon-Capacity" next="ISILON-CRF1" config="XML-Collector/${module['xml-collector'].instance}/conf/isilon-capacity.xml" />
		<collector enabled="false" name="Isilon-Performance" next="ISILON-CRF1" config="XML-Collector/${module['xml-collector'].instance}/conf/isilon-performance.xml" />
[/#if]
	</collectors>
</config>