[#ftl]
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<AlertingConfig xmlns="http://www.watch4net.com/Alerting">
    <definition-list enabled="false" name="Brocade FC Switch/CreditLost-Trigger">
        <description>This alarm triggers if CreditLost metric is &gt;0 for more than 10 Mins</description>
        <entry-point-list>633084896057809</entry-point-list>
    </definition-list>
    <entry-point-list id="633084896057809">
        <name>CreditLost</name>
        <class>com.watch4net.alerting.operation.FilteredEntryPoint</class>
        <filter>name=='CreditLost'</filter>
        <description>Filter on CreditLost metric</description>
        <operation-list from="output" to="entry">633084896093637</operation-list>
    </entry-point-list>
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
</AlertingConfig>