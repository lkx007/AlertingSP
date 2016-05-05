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
<configuration xmlns="http://www.watch4net.com/Events/GenericEventListener"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.watch4net.com/Events/GenericEventListener generic-event-listener.xsd ">
	<event-receiver xsi:type="GenericTcpSocketReceiver" encoding="UTF-8" max-threads="0">
		<data-stream>nasdata</data-stream>
		<port>${events.port}</port>
		<deserializer>
			<class>com.watch4net.events.common.serialization.RawValueDeserializer</class>
		</deserializer>
	</event-receiver>
</configuration>