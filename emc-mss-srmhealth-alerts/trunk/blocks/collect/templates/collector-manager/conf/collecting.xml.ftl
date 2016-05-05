[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<config xmlns="http://www.watch4net.com/APG/Collecting" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.watch4net.com/APG/Collecting collecting.xsd ">
	<connectors>
		<connector enabled="true" name="Alerting" type="Socket-Connector" config="conf/alertingconnector.xml" />
		<connector enabled="false" name="File" type="File-Connector" config="conf/file-connector.xml" />
	</connectors>
	<filters>
[#if msotsdr.failover]	
		<filter enabled="true" name="FailOver" next="Alerting File" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
[#else]
		<filter enabled="skip" name="FailOver" next="Alerting File" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
[/#if]	
		<filter enabled="true" name="MSS-VHF" next="FailOver" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/VHF-C.xml" />
		<filter enabled="true" name="DataEnrichment" next="MSS-VHF" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/property-tagging-filter.xml" />
	</filters>
	<collectors>
		<collector enabled="true" name="socket-collector" next="DataEnrichment" type="Socket-Collector" config="conf/socketcollector.xml" />
	</collectors>
</config>
