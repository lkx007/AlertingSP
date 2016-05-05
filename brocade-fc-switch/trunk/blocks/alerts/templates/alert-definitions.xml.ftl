[#ftl]
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<AlertingConfig xmlns="http://www.watch4net.com/Alerting">
    <definition-list enabled="false" name="Brocade FC Switch/CreditLost-Trigger">
        <description>This alarm triggers if CreditLost metric is &gt;0 for more than 10 Mins</description>
        <entry-point-list>633084896057809</entry-point-list>
    </definition-list>
    <definition-list enabled="${brocade.alerts.portlinkutilization.enable?string}" name="Brocade FC Switch/Brocade Switch Port link Utilization">
        <description>Generate threshold based alert for Brocade Switch currentUtilization Alert Definition</description>
        <entry-point-list>1381945439672</entry-point-list>
    </definition-list>
    <entry-point-list id="633084896057809">
        <name>CreditLost</name>
        <class>com.watch4net.alerting.operation.FilteredEntryPoint</class>
        <filter>name=='CreditLost'</filter>
        <description>Filter on CreditLost metric</description>
        <operation-list from="output" to="entry">633084896093637</operation-list>
    </entry-point-list>
    <entry-point-list id="1381945439672">
        <name>CurrentUtilization Entry</name>
        <class>com.watch4net.alerting.operation.FilteredEntryPoint</class>
        <filter>adapterName=='APG Values Socket Listener' &amp; name=='CurrentUtilization' &amp; devtype=='FabricSwitch' &amp; (parttype=='Interface' | parttype=='Port') &amp; iftype=='fibreChannel'</filter>
        <description>Currentutilization entry point</description>
        <operation-list to="entry" from="output">1386069904108</operation-list>
    </entry-point-list>
    <operation-list id="1386069904108">
        <name>BrocadeSpecificFilter</name>
        <class>com.watch4net.alerting.operation.comparator.StringComparatorOperation</class>
        <description>BrocadeSpecificFilter</description>
        <param-list name="stateless">true</param-list>
        <param-list name="field">pollgrp</param-list>
        <param-list name="compare-to">BROCADE_FCSWITCH_PORT</param-list>
        <param-list name="comparator">contains</param-list>
        <operation-list to="entry" from="true">1382012624376</operation-list>
    </operation-list>
    <operation-list id="633084896093637">
        <name>10 mins Average Calculator</name>
        <class>com.watch4net.alerting.operation.window.HistoryOperation</class>
        <description>Average calculator</description>
        <param-list name="wait-for-period">true</param-list>
        <param-list name="time-range">10</param-list>
        <param-list name="output">avg</param-list>
        <param-list name="buffer-mgmt">sliding</param-list>
        <operation-list from="output" to="entry">633084896109002</operation-list>
    </operation-list>
    <operation-list id="633084896109002">
        <name>&gt;0</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Average comparator</description>
        <param-list name="stateless">false</param-list>
        <param-list name="comparator">0</param-list>
        <param-list name="operator">&gt;</param-list>
        <action-list from="true" to="entry">1369322656079</action-list>
        <action-list from="false" to="entry">1369322821631</action-list>
    </operation-list>
    <operation-list id="1382012624376">
        <name>CurrentUtilization lower threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger MINOR severity alert. Default value is 85.</description>
        <param-list name="stateless">true</param-list>
        <param-list name="comparator">85</param-list>
        <param-list name="operator">&gt;=</param-list>
        <operation-list to="entry" from="true">1382012859307</operation-list>
    </operation-list>
    <operation-list id="1382012859307">
        <name>CurrentUtilization upper threshold check</name>
        <class>com.watch4net.alerting.operation.comparator.ConstantComparatorOperation</class>
        <description>Set the value to trigger CRITICAL severity alert. Default value is 90.</description>
        <param-list name="stateless">true</param-list>
        <param-list name="comparator">90</param-list>
        <param-list name="operator">&gt;=</param-list>
        <action-list to="entry" from="true">1381945919373</action-list>
        <action-list to="entry" from="false">1382012653294</action-list>
    </operation-list>
    <action-list id="1369322656079">
        <name>Notify</name>
        <class>com.watch4net.alerting.action.MailAction</class>
        <param-list name="to">${brocade.alerts.defaultrecipient}</param-list>
        <param-list name="subject">Brocade CreditLost - Notify</param-list>
        <param-list name="message">On PROP.'device' / PROP.'parttype' / PROP.'part' the transmit credit has reached zero VALUE times last ten minutes.</param-list>
    </action-list>
    <action-list id="1369322821631">
        <name>Clear</name>
        <class>com.watch4net.alerting.action.MailAction</class>
        <param-list name="to">${brocade.alerts.defaultrecipient}</param-list>
        <param-list name="subject">Brocade CreditLost - Clear</param-list>
        <param-list name="message">On PROP.'device' / PROP.'parttype' / PROP.'part' the transmit credit is back to normal.</param-list>
    </action-list>
	<action-list id="1381945919373">
         <name>CurrentUtilization CRITICAL alert trap</name>
         <class>com.watch4net.alerting.action.SNMPTrapAction</class>
         <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
         <param-list name="host">localhost</param-list>
         <param-list name="port">2041</param-list>
         <param-list name="community">public</param-list>
         <param-list name="generic">6</param-list>
         <param-list name="specific">1</param-list>
         <param-list name="trap-content">PROP.'ip',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,critical,Switch port Link utilization for port PROP.'part' is at VALUE %,Brocade,TMST,Performance</param-list>
     </action-list>
     <action-list id="1382012653294">
         <name>CurrentUtilization MINOR alert trap</name>
         <class>com.watch4net.alerting.action.SNMPTrapAction</class>
         <description>To generate alert and display in All Alerts report, leave this component settings unchanged.</description>
         <param-list name="host">localhost</param-list>
         <param-list name="port">2041</param-list>
         <param-list name="community">public</param-list>
         <param-list name="generic">6</param-list>
         <param-list name="specific">1</param-list>
        <param-list name="trap-content">PROP.'ip',PROP.'devtype',PROP.'part',PROP.'parttype',PROP.'name',VALUE,warning,Switch port Link utilization for port PROP.'part' is at VALUE %,Brocade,TMST,Performance</param-list>
    </action-list>
</AlertingConfig>
