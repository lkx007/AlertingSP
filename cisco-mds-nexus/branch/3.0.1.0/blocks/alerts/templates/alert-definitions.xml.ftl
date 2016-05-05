[#ftl]
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<AlertingConfig xmlns="http://www.watch4net.com/Alerting">
    <definition-list enabled="${alerts.portlinkutilization.enable?string}" name="Cisco MDS Nexus/Cisco Switch Port Link Utilization">
        <description>Generate threshold based alert for Cisco Switch Port link Utilization</description>
        <entry-point-list>1383027617934</entry-point-list>
    </definition-list>
    <entry-point-list id="1383027617934">
        <name>CurrentUtilization Entry</name>
        <class>com.watch4net.alerting.operation.FilteredEntryPoint</class>
        <filter>adapterName=='APG Values Socket Listener' &amp; datagrp=='GENERIC-INTERFACES' &amp; pollgrp='%CISCO-MDS-NEXUS-PORTS%' &amp; name=='CurrentUtilization'</filter>
		<description>Currentutilization entry point</description>
        <operation-list to="entry" from="output">1383028116831</operation-list>
    </entry-point-list>

    <operation-list id="1383028116831">
        <name>CurrentUtilization lower threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger MINOR severity alert. Default value is 85.</description>
        <param-list name="stateless">true</param-list>
        <param-list name="comparator">85</param-list>
        <param-list name="operator">&gt;=</param-list>
        <operation-list to="entry" from="true">1383028138471</operation-list>
    </operation-list>
    <operation-list id="1383028138471">
        <name>CurrentUtilization upper threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger CRITICAL severity alert. Default value is 90.</description>
        <param-list name="stateless">true</param-list>
        <param-list name="comparator">90</param-list>
        <param-list name="operator">&gt;=</param-list>
        <action-list to="entry" from="true">1383028191410</action-list>
        <action-list to="entry" from="false">1383028211653</action-list>
    </operation-list>

    <action-list id="1383028191410">
        <name>CurrentUtilization CRITICAL alert trap</name>
        <class>com.watch4net.alerting.action.SNMPTrapAction</class>
        <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
        <param-list name="host">localhost</param-list>
        <param-list name="port">2041</param-list>
        <param-list name="community">public</param-list>
        <param-list name="generic">6</param-list>
        <param-list name="specific">1</param-list>
        <param-list name="trap-content">PROP.'device',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,critical,Switch port Link utilization for port PROP.'part' is at VALUE %,Cisco,TMST,Performance</param-list>
    </action-list>
    <action-list id="1383028211653">
        <name>CurrentUtilization MINOR alert trap</name>
        <class>com.watch4net.alerting.action.SNMPTrapAction</class>
        <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
        <param-list name="host">localhost</param-list>
        <param-list name="port">2041</param-list>
        <param-list name="community">public</param-list>
        <param-list name="generic">6</param-list>
        <param-list name="specific">1</param-list>
        <param-list name="trap-content">PROP.'device',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,warning,Switch port Link utilization for port PROP.'part' is at VALUE %,Cisco,TMST,Performance</param-list>
    </action-list>
</AlertingConfig>