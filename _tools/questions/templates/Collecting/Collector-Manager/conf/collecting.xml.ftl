[#ftl]
<?xml version="1.0" encoding="ISO-8859-15"?>
<config xmlns="http://www.watch4net.com/APG/Collecting" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/APG/Collecting collecting.xsd ">

	<!-- Connectors connect the collecting component to a specific Output. -->
	<connectors>
		<!-- This collecting component connects the collecting process to the Backend itself, using a plain text socket. -->
		<connector enabled="true" name="Backend" type="Socket-Connector" config="conf/socketconnector.xml"/>

		<!-- This collecting component connects the collecting process to the Alerting itself, using a plain text socket. -->
		<connector enabled="true" name="Alerting" type="Socket-Connector" config="conf/alertingconnector.xml"/>

		<!-- This collecting component writes every pushed data in either a file either the console. -->
		<connector enabled="false" name="File" type="File-Connector" config="conf/file-connector.xml"/>
	</connectors>

	<!-- Filters can pre-process data gathered by the collecting component. -->
	<filters>
		<!--
			The failover filter prevents any loss of data when the connection to the Backend is broken for any reason (Backend
			shutdown, Network failure, etc...)
		-->
		<filter enabled="skip" name="FailOver-Backend" next="Backend" config="FailOver-Filter/Default/conf/failover-backend.xml"/>
		<filter enabled="skip" name="FailOver-Alerting" next="Alerting" config="FailOver-Filter/Default/conf/failover-alerting.xml"/>

		<!-- This is the filter used to detect outages and send them to the Outage Manager -->
		<filter enabled="skip" name="OutageDetector" next="FailOver-Backend FailOver-Alerting File" config="Outage-Manager/Default/conf/outage-detector.xml"/>

		<!-- This is the filter used to add custom properties to raw values -->
		<filter enabled="skip" name="PropertyTaggingFilter" next="OutageDetector" config="Property-Tagging-Filter/Default/conf/property-tagging-filter.xml"/>

		<!-- This is the filter used to calculate device Availability, based on its Uptime -->
		<filter enabled="true" name="AvailabilityBasedOnSysuptime" next="PropertyTaggingFilter" config="Availability-Filter/Default/conf/availability-filter.xml"/>

		<!-- These filters are used with the "ReportPack for IPSLA" -->
		<filter enabled="true" name="HexToDecIPAdressConverter" next="AvailabilityBasedOnSysuptime" type="HexToDecIpAddressConverter" config="IP-SLA-Filter/Default/conf/hex-to-dec-ip-address-converter.xml"/>
		<filter enabled="true" name="IpSlaStatisticsTableFilter" next="HexToDecIPAdressConverter" type="IpSlaStatisticsTableFilter" config="IP-SLA-Filter/Default/conf/ipsla-statistics-table-filter.xml"/>
		<filter enabled="true" name="SaaFilter2" next="IpSlaStatisticsTableFilter" type="SaaFilter" config="IP-SLA-Filter/Default/conf/saafilter2.xml"/>
		<filter enabled="true" name="SaaFilter1" next="SaaFilter2" config="Timestamp-Sysuptime-Matching-Filter/Default/conf/ipsla-history-collection-filter.xml"/>

		<!-- This filter is used with the "ReportPack for Cisco Class-Based Qos" -->
		<filter enabled="true" name="QosIndexGenerator" next="SaaFilter1" config="Index-Generator-Filter/Default/conf/qos-index-generator.xml"/>

		<!-- These filters are used in with the "ReportPack for Servers and Network devices" -->
		<filter enabled="true" name="MapStoragePartType" next="QosIndexGenerator" config="Property-Tagging-Filter/Default/conf/mapped-storage-parttype.xml"/>
		<filter enabled="true" name="AvailabilityBandwidth" next="MapStoragePartType" config="Inline-Calculation-Filter/Default/conf/availability-bandwidth.xml"/>
		<filter enabled="true" name="HostMemory" next="AvailabilityBandwidth" config="Property-Tagging-Filter/Default/conf/memory-metric-renaming.xml"/>
		<filter enabled="true" name="ChangeBytestoKbytes" next="HostMemory" config="Value-Offset-Filter/Default/conf/changebytestokybtes.xml"/>
		<filter enabled="true" name="CalculateSize" next="ChangeBytestoKbytes" config="Value-Offset-Filter/Default/conf/calculate-size.xml"/>

		<!-- These filters are used in the property merging process between the SNMP and ICMP Collectors. -->
		<filter enabled="true" name="CrossReferencingFilter" next="CalculateSize" config="Cross-Referencing-Filter/Default/conf/cross-referencing-filter.xml"/>
		<filter enabled="true" name="UptimePassthrough" next="CrossReferencingFilter" config="Variable-Handling-Filter/Default/conf/uptime-passthrough.xml"/>
		<filter enabled="true" name="UptimeBlocker" next="CalculateSize" config="Variable-Handling-Filter/Default/conf/uptime-blocker.xml"/>
		
		<!-- These filters are required by the "ReportPack for VMWare" -->
		<filter enabled="true" name="VMWARE-VHF" next="Backend" config="Variable-Handling-Filter/Default/conf/variable-handling-filter-vmware.xml"/>
	</filters>

	<!-- Collectors gather data from different Sources. -->
	<collectors>
		<!-- This is the EMC Smarts collector. This collector automatically detects your domains and starts polling them immediately. -->
		<collector enabled="true" name="SmDiscovery" next="AvailabilityBasedOnSysuptime" type="Sm-Discovery" config="Smarts-Collector/${module.instance}/conf/sm-discovery.xml"/>

		<!-- These are manually configured EMC Smarts collectors. These collectors only target specific domains. -->
		<collector enabled="false" name="INCHARGE-AM-PM" next="AvailabilityBasedOnSysuptime" type="Sm-Collector" config="Smarts-Collector/${module.instance}/conf/smarts-pm.xml"/>
		<collector enabled="false" name="IC-ACM" next="AvailabilityBasedOnSysuptime" type="Sm-Collector" config="Smarts-Collector/${module.instance}/conf/smarts-acm2.xml"/>

		<!-- This is the SNMP collector -->
		<collector enabled="false" name="SnmpCollector" next="UptimeBlocker UptimePassthrough" config="SNMP-Collector/Default/conf/snmpcollector.xml"/>

		<!-- This is the Text collector -->
		<collector enabled="false" name="TextCollector" next="AvailabilityBasedOnSysuptime" config="Text-Collector/Default/conf/textoutputcollector.xml"/>

		<!-- This is the XML collector -->
		<collector enabled="false" name="XMLCollector" next="AvailabilityBasedOnSysuptime" config="XML-Collector/Default/conf/xmlcollector.xml"/>

		<!-- This is the ICMP collector -->
		<!-- Warning: The ICMP Collector must be run as root, see documentation for details. -->
		<collector enabled="false" name="IcmpCollector" next="CrossReferencingFilter" config="ICMP-Collector/Default/conf/icmp-collector.xml"/>

		<!-- This is the JMX collector -->
		<collector enabled="false" name="JMXCollector" next="AvailabilityBasedOnSysuptime" config="JMX-Collector/Default/conf/jmx-collector.xml"/>

		<!-- This is the SQL collector -->
		<collector enabled="false" name="SQLCollector" next="AvailabilityBasedOnSysuptime" config="SQL-Collector/Default/conf/sql-collector.xml"/>

		<!-- This is the Socket collector -->
		<collector enabled="false" name="SocketCollector" next="AvailabilityBasedOnSysuptime" type="Socket-Collector" config="conf/socketcollector.xml"/>
		
		<!-- This is the Transaction collector -->
		<collector enabled="false" name="TransactionCollector" next="AvailabilityBasedOnSysuptime" type="Transaction-Collector" config="Transaction-Collector/Default/conf/transaction-collector.xml"/>
		
		<!-- This is the VMWare collector, turn on the dedicated filters above when enabled -->
        <collector enabled="false" name="VMWareCollector" next="VMWARE-VHF" type="VMWare-Collector" config="VMWare-Collector/Default/conf/vmware-collector.xml"/>
        
		<!-- This is the APG Self-Monitoring collector for APG-Health -->
		<!-- Warning: The APG Self-Monitoring collector must be run as apg only, see documentation for details. -->
		<!-- Warning: The APG Self-Monitoring collector data must NOT pass through the Availability-Filter.  -->
		<collector enabled="true" name="APG_HEALTH" next="PropertyTaggingFilter" config="APG-Self-Monitoring-Collector/Default/conf/apg-self-monitoring-collector.xml"/>
	</collectors>

</config>