[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
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
		<filter enabled="true" name="DataEnrichment" next="FailOver IgnoreErrors" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter.xml" />

		<filter enabled="true" name="VMAX_VHF" next="DataEnrichment" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-vmax1.xml" />
		<filter enabled="true" name="VMAX_VOF1" next="VMAX_VHF" config="Value-Offset-Filter/${module['value-offset-filter'].instance}/conf/vof-vmax1.xml" />
		<filter enabled="true" name="VMAX_PTF1" next="VMAX_VOF1" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/ptf-vmax1.xml" />
		<filter enabled="true" name="VMAX_CR1F" next="VMAX_PTF1" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/crf-vmax1.xml" />
	</filters>
	<collectors>
		<collector enabled="true" name="vmax-topo" next="VMAX_CR1F" config="XML-Collector/${module['xml-collector'].instance}/conf/xmlcollector-vmax-topo.xml" />
		[#if emcvmax??]
		<collector enabled="true" name="vmax-perf" next="VMAX_CR1F" config="XML-Collector/${module['xml-collector'].instance}/conf/xmlcollector-vmax-perf.xml" />
		[/#if]
	</collectors>
</config>