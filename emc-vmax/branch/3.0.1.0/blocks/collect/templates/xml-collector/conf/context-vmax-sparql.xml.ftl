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
<execution-contexts xmlns="http://www.watch4net.com/XMLCollector"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.watch4net.com/XMLCollector contextdefinition.xsd ">
<contexts name="VMAX">
[#if use_topo]
	<properties name="hostport">${topologyservice.host}:${topologyservice.gateway.port}</properties>
	<properties name="username">${topologyservice.gateway.username}</properties>
	<properties name="password">${topologyservice.gateway.password}</properties>
[#else]
	<properties name="hostport">localhost:48443</properties>
	<properties name="username">admin</properties>
	<properties name="password">changeme</properties>
[/#if]
</contexts>
</execution-contexts>