[#ftl]
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<AlertingConfig xmlns="http://www.watch4net.com/Alerting">
    <definition-list enabled="${emcvmax.alerts.directorutilization.enable?string}" name="EMC VMAX/VMAX Front-End Director Utilization">
        <description>Generate threshold based alert for VMAX Front-End Director Utilization</description>
        <entry-point-list>1382613682528</entry-point-list>
    </definition-list>
    <definition-list enabled="${emcvmax.alerts.directorportutilization.enable?string}" name="EMC VMAX/VMAX Front-End Director Port Utilization">
        <description>Generate threshold based alert for VMAX Front-End Director Port Utilization</description>
        <entry-point-list>1382617014971</entry-point-list>
    </definition-list>
    <entry-point-list id="1382613682528">
        <name>Director CurrentUtilization Entry</name>
        <class>com.watch4net.alerting.operation.FilteredEntryPoint</class>
        <filter>adapterName=='APG Values Socket Listener' &amp; partgrp=='Front-End' &amp; parttype=='Controller' &amp; name=='CurrentUtilization'</filter>
        <description>Current utilization entry point for director</description>
        <operation-list to="entry" from="output">1382613793193</operation-list>
    </entry-point-list>
    <entry-point-list id="1382617014971">
        <name>Director Port CurrentUtilization Entry</name>
        <class>com.watch4net.alerting.operation.FilteredEntryPoint</class>
        <filter>adapterName=='APG Values Socket Listener' &amp; partgrp=='Front-End' &amp; parttype=='Port' &amp; name=='CurrentUtilization'</filter>
        <description>Current utilization entry point for director port</description>
        <operation-list to="entry" from="output">1382617058523</operation-list>
    </entry-point-list>
    <operation-list id="1382613793193">
        <name>Director Utilization lower threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger MINOR severity alert. Default value is 85.</description>
        <param-list name="stateless">true</param-list>
        <param-list name="comparator">85</param-list>
        <param-list name="operator">&gt;=</param-list>
        <operation-list to="entry" from="true">1382613829356</operation-list>
    </operation-list>
    <operation-list id="1382613829356">
        <name>Director Utilization upper threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger CRITICAL severity alert. Default value is 90.</description>
        <param-list name="stateless">true</param-list>
        <param-list name="comparator">90</param-list>
        <param-list name="operator">&gt;=</param-list>
        <action-list to="entry" from="true">1382614475601</action-list>
        <action-list to="entry" from="false">1382614404769</action-list>
    </operation-list>
    <operation-list id="1382617058523">
        <name>Director Port Utilization lower threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger MINOR severity alert. Default value is 85.</description>
        <param-list name="stateless">false</param-list>
        <param-list name="comparator">85</param-list>
        <param-list name="operator">&gt;=</param-list>
        <operation-list to="entry" from="true">1382617110756</operation-list>
    </operation-list>
    <operation-list id="1382617110756">
        <name>Director Port Utilization upper threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger CRITICAL severity alert. Default value is 90.</description>
        <param-list name="stateless">false</param-list>
        <param-list name="comparator">90</param-list>
        <param-list name="operator">&gt;=</param-list>
        <action-list to="entry" from="true">1382617513320</action-list>
        <action-list to="entry" from="false">1382617489798</action-list>
    </operation-list>

    <action-list id="1382614475601">
        <name>Director CRITICAL alert trap</name>
        <class>com.watch4net.alerting.action.SNMPTrapAction</class>
        <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
        <param-list name="host">localhost</param-list>
        <param-list name="port">2041</param-list>
        <param-list name="community">public</param-list>
        <param-list name="generic">6</param-list>
        <param-list name="specific">1</param-list>
        <param-list name="trap-content">PROP.'device',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,critical,Symmetrix Host Director utilization for Director PROP.'part' is at VALUE%,VMAX,TMST,Performance</param-list>
    </action-list>
    <action-list id="1382614404769">
        <name>Director MINOR alert trap</name>
        <class>com.watch4net.alerting.action.SNMPTrapAction</class>
        <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
        <param-list name="host">localhost</param-list>
        <param-list name="port">2041</param-list>
        <param-list name="community">public</param-list>
        <param-list name="generic">6</param-list>
        <param-list name="specific">1</param-list>
        <param-list name="trap-content">PROP.'device',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,warning,Symmetrix Host Director utilization for Director PROP.'part' is at VALUE%,VMAX,TMST,Performance</param-list>
    </action-list>
    <action-list id="1382617513320">
        <name>Director port CRITICAL alert trap</name>
        <class>com.watch4net.alerting.action.SNMPTrapAction</class>
        <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
        <param-list name="host">localhost</param-list>
        <param-list name="port">2041</param-list>
        <param-list name="community">public</param-list>
        <param-list name="generic">6</param-list>
        <param-list name="specific">1</param-list>
        <param-list name="trap-content">PROP.'device',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,critical,Symmetrix port utilization for port PROP.'part' is at VALUE%,VMAX,TMST,Performance</param-list>
    </action-list>
    <action-list id="1382617489798">
        <name>Director port MINOR alert trap</name>
        <class>com.watch4net.alerting.action.SNMPTrapAction</class>
        <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
        <param-list name="host">localhost</param-list>
        <param-list name="port">2041</param-list>
        <param-list name="community">public</param-list>
        <param-list name="generic">6</param-list>
        <param-list name="specific">1</param-list>
        <param-list name="trap-content">PROP.'device',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,warning,Symmetrix port utilization for port PROP.'part' is at VALUE%,VMAX,TMST,Performance</param-list>
    </action-list>
</AlertingConfig>