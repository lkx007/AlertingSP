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
		<connector enabled="true" name="CC-Storage-TS2Event" type="Socket-Connector" config="conf/storage-ts2event.xml" />
		[#-- File must be present, and set to false, as we send to dev null some metrics we dont really need --]
		<connector enabled="false" name="File" type="File-Connector" config="conf/file-connector.xml" />
	</connectors>
	<filters>
[#if storage.failover]
		<filter enabled="true" name="FailOver" next="Backend" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
		<filter enabled="true" name="FailOverEvents" next="CC-Storage-TS2Event" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-event.xml" />
[#else]
		<filter enabled="skip" name="FailOver" next="Backend" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
		<filter enabled="skip" name="FailOverEvents" next="CC-Storage-TS2Event" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-event.xml" />
[/#if]
		<filter enabled="true" name="IgnoreErrors" next="Alerting" type="Ignore-Errors-Filter" config="Collector-Manager/${module['collector-manager'].instance}/" />
		<filter enabled="true" name="DataEnrichment" next="FailOver IgnoreErrors" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter.xml" />

		<filter enabled="true" name="VNX-BAH" next="DataEnrichment" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/variable-handling-filter-blocker.xml" />
		<filter enabled="true" name="VNX-CRF" next="VNX-BAH" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/cross-referencing-filter-vnxblock.xml" />
		<filter enabled="true" name="VNX-ICF" next="VNX-CRF" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/inline-calculation-filter-vnxblock.xml" />
		<filter enabled="true" name="VNX-VOF" next="VNX-ICF" config="Value-Offset-Filter/${module['value-offset-filter'].instance}/conf/value-offset-filter-vnxblock.xml" />
		<filter enabled="true" name="VNX-PCF" next="VNX-VOF" config="Property-Concat-Filter/${module['property-concat-filter'].instance}/conf/property-concat-filter-vnxblock.xml" />
		<filter enabled="true" name="VNX-VHF" next="VNX-PCF" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/variable-handling-filter-vnxblock.xml" />
		<filter enabled="true" name="VNX-PTF" next="VNX-VHF" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter-vnxblock.xml" />
		<filter enabled="true" name="VNX-SAF" next="VNX-PTF" config="Spatial-Aggregation-Filter/${module['spatial-aggregation-filter'].instance}/conf/saf-vnxblock.xml" />

		<filter enabled="true" name="vnxfile5" next="DataEnrichment" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vnxfile5.xml" />
		<filter enabled="true" name="vnxfile4" next="FailOverEvents" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vnxfile4.xml" />
		<filter enabled="true" name="vnxfile2" next="vnxfile4 vnxfile5" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/vnxfile2.xml" />
	</filters>
	<collectors>
[#assign blockenabled="false" /]
[#assign fileenabled="false" /]
[#list vnx as vnx]
	[#if vnx.type == 'block' || vnx.type == 'unified']
		[#assign blockenabled="true" /]
	[/#if]
	[#if vnx.type == 'file' || vnx.type == 'unified']
		[#assign fileenabled="true" /]
	[/#if]
[/#list]
		<!-- Block -->
		<collector enabled="${blockenabled}" name="VNXBlock" next="VNX-SAF" config="Text-Collector/${module['text-collector'].instance}/conf/textoutputcollector-vnxblock.xml" />

		<!-- File -->
		[#-- TODO and FIXME MAV FME api cant even respond in 60mins, this needs deeper work...
		<collector enabled="false" name="XML-API-60min" next="vnxfile2" config="XML-Collector/${module['xml-collector'].instance}/conf/vnxfile60.xml" />
		 --]
		<collector enabled="${fileenabled}" name="XML-API-5min" next="vnxfile2" config="XML-Collector/${module['xml-collector'].instance}/conf/vnxfile.xml" />
		<collector enabled="${fileenabled}" name="Parsing" next="vnxfile2" config="Text-Collector/${module['text-collector'].instance}/conf/textcollector-process-vnxfile-data.xml" />
		<collector enabled="${fileenabled}" name="LowInterval" next="vnxfile2" config="Text-Collector/${module['text-collector'].instance}/conf/textcollector-process-vnxfile-lowinterval.xml" />
		<collector enabled="${fileenabled}" name="Collection-60min" next="File" config="Text-Collector/${module['text-collector'].instance}/conf/textcollector-run-vnxfile-collection-60min.xml" />
		<collector enabled="${fileenabled}" name="Collection-5min" next="File" config="Text-Collector/${module['text-collector'].instance}/conf/textcollector-run-vnxfile-collection-5min.xml" />
	</collectors>
</config>