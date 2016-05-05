[#ftl]
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<AlertingConfig xmlns="http://www.watch4net.com/Alerting">
    <definition-list enabled="${emcvnx.alerts.sputilization.enable?string}" name="EMC VNX/VNX Block SP Utilization">
        <description>Generate threshold based alert for VNX Block SP Utilization</description>
        <entry-point-list>1383144233605</entry-point-list>
    </definition-list>
    <definition-list enabled="${emcvnx.alerts.dirtypagesutilization.enable?string}" name="EMC VNX/VNX Block Dirty Pages">
        <description>Generate threshold based alert for VNX Block Dirty Pages</description>
        <entry-point-list>799868494989360</entry-point-list>
    </definition-list>
    <entry-point-list id="1383144233605">
        <name>SP Utilization Entry</name>
        <class>com.watch4net.alerting.operation.FilteredEntryPoint</class>
        <filter>adapterName=='APG Values Socket Listener' &amp; parttype=='Controller' &amp; datagrp=='VNXBlock-SP-Cache' &amp; name=='CurrentUtilization'</filter>
        <description>SP utilization entry point</description>
        <operation-list to="entry" from="output">1383144307988</operation-list>
    </entry-point-list>
    <entry-point-list id="799868494989360">
        <name>Dirty pages Entry</name>
        <class>com.watch4net.alerting.operation.FilteredEntryPoint</class>
        <filter>adapterName=='APG Values Socket Listener' &amp; parttype=='Controller' &amp; datagrp=='VNXBlock-SP-Cache' &amp; name=='CacheDirtyPages'</filter>
        <description>Dirty Pages entry point</description>
        <operation-list to="entry" from="output">799868495018156</operation-list>
    </entry-point-list>
    <operation-list id="1383144307988">
        <name>SP Utilization lower threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger MINOR severity alert. Default value is 85.</description>
        <param-list name="stateless">false</param-list>
        <param-list name="comparator">85</param-list>
        <param-list name="operator">&gt;=</param-list>
        <operation-list to="entry" from="true">1383144520433</operation-list>
    </operation-list>
    <operation-list id="1383144520433">
        <name>SP Utilization upper threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger CRITICAL severity alert. Default value is 90.</description>
        <param-list name="stateless">false</param-list>
        <param-list name="comparator">90</param-list>
        <param-list name="operator">&gt;=</param-list>
        <action-list to="entry" from="true">1383144738127</action-list>
        <action-list to="entry" from="false">1383146321065</action-list>
    </operation-list>
    <operation-list id="799868495018156">
        <name>Dirty Pages lower threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger MINOR severity alert. Default value is 90.</description>
        <param-list name="stateless">false</param-list>
        <param-list name="comparator">90</param-list>
        <param-list name="operator">&gt;=</param-list>
        <operation-list to="entry" from="true">799868495034646</operation-list>
    </operation-list>
    <operation-list id="799868495034646">
        <name>Dirty Pages upper threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger CRITICAL severity alert. Default value is 95.</description>
        <param-list name="stateless">false</param-list>
        <param-list name="comparator">95</param-list>
        <param-list name="operator">&gt;=</param-list>
        <action-list to="entry" from="true">799868495046142</action-list>
        <action-list to="entry" from="false">799868495057719</action-list>
    </operation-list>
    <action-list id="1383144738127">
        <name>SP CRITICAL alert trap</name>
        <class>com.watch4net.alerting.action.SNMPTrapAction</class>
        <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
        <param-list name="host">localhost</param-list>
        <param-list name="port">2041</param-list>
        <param-list name="community">public</param-list>
        <param-list name="generic">6</param-list>
        <param-list name="specific">1</param-list>
        <param-list name="trap-content">PROP.'device',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,critical,Storage Processor Utilization for PROP.'part' is at VALUE%,VNXBlock-Collector,TMST,Performance</param-list>
    </action-list>
    <action-list id="1383146321065">
        <name>SP MINOR alert trap</name>
        <class>com.watch4net.alerting.action.SNMPTrapAction</class>
        <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
        <param-list name="host">localhost</param-list>
        <param-list name="port">2041</param-list>
        <param-list name="community">public</param-list>
        <param-list name="generic">6</param-list>
        <param-list name="specific">1</param-list>
        <param-list name="trap-content">PROP.'device',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,warning,Storage Processor Utilization for PROP.'part' is at VALUE%,VNXBlock-Collector,TMST,Performance</param-list>
    </action-list>
    <action-list id="799868495046142">
        <name>Dirty Pages CRITICAL alert trap</name>
        <class>com.watch4net.alerting.action.SNMPTrapAction</class>
        <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
        <param-list name="host">localhost</param-list>
        <param-list name="port">2041</param-list>
        <param-list name="community">public</param-list>
        <param-list name="generic">6</param-list>
        <param-list name="specific">1</param-list>
        <param-list name="trap-content">PROP.'device',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,critical,Storage Processor dirty pages for PROP.'part' is at VALUE%,VNXBlock-Collector,TMST,Performance</param-list>
    </action-list>
    <action-list id="799868495057719">
        <name>Dirty Pages MINOR alert trap</name>
        <class>com.watch4net.alerting.action.SNMPTrapAction</class>
        <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
        <param-list name="host">localhost</param-list>
        <param-list name="port">2041</param-list>
        <param-list name="community">public</param-list>
        <param-list name="generic">6</param-list>
        <param-list name="specific">1</param-list>
        <param-list name="trap-content">PROP.'device',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,warning,Storage Processor dirty pages for PROP.'part' is at VALUE%,VNXBlock-Collector,TMST,Performance</param-list>
    </action-list>
</AlertingConfig>