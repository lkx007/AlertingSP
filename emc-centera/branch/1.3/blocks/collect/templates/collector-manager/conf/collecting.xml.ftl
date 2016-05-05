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

		<filter enabled="true" name="Centera-PTF" next="DataEnrichment" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter-centera.xml" />
		<filter enabled="true" name="Centera-VHF" next="Centera-PTF" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/variable-handling-filter-centera.xml" />
		<filter enabled="true" name="Centera-CRF" next="Centera-VHF" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/cross-referencing-filter-centera.xml" />
		</filters>
	<collectors>
		<collector enabled="true" name="Centera" next="Centera-CRF" config="Text-Collector/${module['text-collector'].instance}/conf/textoutputcollector-centera.xml" />
	</collectors>
</config>