[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<config xmlns="http://www.watch4net.com/APG/Collecting" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.watch4net.com/APG/Collecting collecting.xsd ">
	<connectors>
		<connector enabled="true" name="Backend" type="Socket-Connector" config="conf/socketconnector.xml" />
		<connector enabled="false" name="File" type="File-Connector" config="conf/file-connector.xml" />
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
		
		<filter enabled="true" name="ATMOS-BLOCK-RAW-VHF" next="DataEnrichment" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/variable-handling-filter.xml" />
		<filter enabled="true" name="ATMOS-B2GB-ICF" next="ATMOS-BLOCK-RAW-VHF" config="Inline-Calculation-Filter/${module['inline-calculation-filter'].instance}/conf/inline-calculation-filter.xml" />
		<filter enabled="true" name="ATMOS-CRF" next="ATMOS-B2GB-ICF" config="Cross-Referencing-Filter/${module['cross-referencing-filter'].instance}/conf/cross-referencing-filter.xml"/>
	</filters>
	
	<collectors>
		<collector enabled="true" name="ACRT" next="ATMOS-CRF" config="XML-Collector/${module['xml-collector'].instance}/conf/xmlcollector-atmos-acrt.xml" />
		<collector enabled="true" name="SYSMGMNT" next="ATMOS-CRF" config="XML-Collector/${module['xml-collector'].instance}/conf/xmlcollector-sysmgmnt.xml" />
	</collectors>
</config>