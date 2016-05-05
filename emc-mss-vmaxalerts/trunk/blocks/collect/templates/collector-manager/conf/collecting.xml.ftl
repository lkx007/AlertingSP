[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<!--
* Copyright (c) 2014 EMC Corporation
* All Rights Reserved
*
* This software contains the intellectual property of EMC Corporation
* or is licensed to EMC Corporation from third parties.  Use of this
* software and the intellectual property contained therein is expressly
* limited to the terms and conditions of the License Agreement under which
* it is provided by or on behalf of EMC.
-->
<config xmlns="http://www.watch4net.com/APG/Collecting" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.watch4net.com/APG/Collecting collecting.xsd ">
    <connectors>
        <connector enabled="true" name="Backend" type="Socket-Connector" config="conf/socketconnector.xml" />
[#if use_alert]
        <connector enabled="true" name="Alerting" type="Socket-Connector" config="conf/alertingconnector.xml" />
[#else]
        <connector enabled="false" name="Alerting" type="Socket-Connector" config="conf/alertingconnector.xml" />
[/#if]
	<connector enabled="false" name="File" type="File-Connector" config="conf/file-connector.xml" />
    </connectors>
    <filters>
[#if storage.failover]
        <filter enabled="true" name="FailOver" next="Backend Alerting File" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
[#else]
        <filter enabled="skip" name="FailOver" next="Backend Alerting File" config="FailOver-Filter/${module['failover-filter'].instance}/conf/failover-backend.xml" />
[/#if]
     </filters>
<collectors>
        <collector enabled="true" name="VMAX-CLI-ALERTS" next="FailOver" config="XML-Collector/${module['xml-collector'].instance}/conf/xmlcollector-vmax-alerts.xml" />
    </collectors>
</config>