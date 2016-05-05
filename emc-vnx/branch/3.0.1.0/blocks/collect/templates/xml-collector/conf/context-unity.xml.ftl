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
[#if vnx??]
[#list vnx as vnx]
[#if vnx.type == 'unity']
	<contexts name="VNX${vnx_index}">
		<properties name="deviceid">${vnx_index}</properties>
		<properties name="friendlyname">${vnx.friendlyname}</properties>
		<properties name="host">${vnx.unity.management}</properties>
		<properties name="username">${vnx.unity.username}</properties>
		<properties name="password">${vnx.unity.password}</properties>
	</contexts>
[/#if]
[/#list]
[/#if]
</execution-contexts>