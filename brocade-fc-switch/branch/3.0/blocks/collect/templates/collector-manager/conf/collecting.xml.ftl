[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<config xmlns="http://www.watch4net.com/APG/Collecting" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.watch4net.com/APG/Collecting collecting.xsd ">
	<connectors>
		<connector enabled="true" name="Backend" type="Socket-Connector" config="conf/socketconnector.xml" />
	
[#if use_topo]
		<connector enabled="true" name="TopoBackend" type="Socket-Connector" config="conf/topoconnector.xml" />
[#else]
		<connector enabled="false" name="TopoBackend" type="Socket-Connector" config="conf/topoconnector.xml" />
[/#if]	
	</connectors>
	<filters>
[#if storage.failover]	
		<filter enabled="true" name="FailOver" next="Backend" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
[#else]
		<filter enabled="skip" name="FailOver" next="Backend" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
[/#if]	
[#if passive_discovery.brocade_zones]
		<filter enabled="true" name="User_Defined_Group_Management" next="FailOver TopoBackend" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/PTF-Group-Tagging.xml" />
		<filter enabled="true" name="PTF-LunWWN-Accessor" next="User_Defined_Group_Management" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/PTF-passivehost-lunwwn.xml" />
		<filter enabled="true" name="VHF-PassiveHost" next="PTF-LunWWN-Accessor" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-mds-discovery.xml" />
[#else]
		<filter enabled="true" name="User_Defined_Group_Management" next="FailOver TopoBackend" config="Property-Tagging-Filter/${module['property-tagging-filter'].instance}/conf/PTF-Group-Tagging.xml" />
		<filter enabled="skip" name="VHF-PassiveHost" next="User_Defined_Group_Management" config="Variable-Handling-Filter/${module['variable-handling-filter'].instance}/conf/vhf-mds-discovery.xml" />
[/#if]			
	</filters>
	<collectors>

		<collector enabled="true" name="brocade-fc-switch-smicollect" next="VHF-PassiveHost" config="XML-Collector/${module['xml-collector'].instance}/conf/xmlcollector-brocade-zoning.xml" />
	
	</collectors>
</config>