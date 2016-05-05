[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<!--
* Copyright (c) 2013 EMC Corporation
* All Rights Reserved
*
* This software contains the intellectual property of EMC Corporation
* or is licensed to EMC Corporation from third parties.  Use of this
* software and the intellectual property contained therein is expressly
* limited to the terms and conditions of the License Agreement under which
* it is provided by or on behalf of EMC.
-->
<processing-manager xmlns="http://www.watch4net.com/Events/DefaultProcessingManager" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.watch4net.com/Events/DefaultProcessingManager DefaultProcessingManager.xsd ">
	<processing-element name="NASUsers-Event" config="Generic-Live-Writer/${module['generic-live-writer'].instance}/conf/GLW-NASUsers-Event.xml" />
	<processing-element name="NASUsers-TS2Event" config="Generic-Event-Listener/${module['generic-event-listener'].instance}/conf/GEL-NASUsers-TS2Event.xml" nasdata="NASUsers-Event[data]" />
</processing-manager>