[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<configuration xmlns="http://www.watch4net.com/Events/GenericLiveWriter" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.watch4net.com/Events/GenericLiveWriter GenericLiveWriter.xsd ">
	<datasource url="jdbc:mysql://${event.database.host}:${event.database.port}/${event.database.schema}?autoReconnect=true&amp;autoReconnectForPools=true"
		username="${event.database.username}" password="${event.database.password}" driverClassName="com.mysql.jdbc.Driver" poolPreparedStatements="true"
		testOnBorrow="false" testOnReturn="false" testWhileIdle="true" timeBetweenEvictionRunsMillis="10000" validationQuery="SELECT 1" validationQueryTimeout="5"
		connectionProperties="cachePrepStmts=false;useServerPrepStmts=true;maintainTimeStats=false;dontTrackOpenResources=true;enableQueryTimeouts=false;processEscapeCodesForPrepStmts=false;jdbcCompliantTruncation=false;" />
	<expiration field="RV_Timestamp" period="1d" timeout="35d" unit="s"/>
	<personality xsi:type="mysql" table="nasusers" />
	<mapping>
		<key field="RV_Timestamp" name="Timestamp" field-type="OCCURRENCE" data-type="LONG" xsi:type="DefaultFieldMapping" />
		<key field="RV_Variable" name="Variable" field-type="DEFINITION" data-type="STRING" xsi:type="DefaultFieldMapping" />
		<field field="CONNECTIONID" name="ConnectionID" xsi:type="CustomFieldMapping" helper-class="com.watch4net.events.common.processing.database.mapping.IdGeneratorMapper" />
		<field field="device" name="Container" data-type="STRING" xsi:type="DefaultFieldMapping" />
		<field field="client" name="Client" data-type="STRING" xsi:type="DefaultFieldMapping" />
		<field field="user" name="User" data-type="STRING" xsi:type="DefaultFieldMapping" />
		<field field="server" name="Server" data-type="STRING" xsi:type="DefaultFieldMapping" />
		<field field="protocol" name="Protocol" data-type="STRING" xsi:type="DefaultFieldMapping" />
		<field field="tcalls" name="TotalCalls" data-type="LONG" xsi:type="DefaultFieldMapping" />
		<field field="wcalls" name="WriteCalls" data-type="LONG" xsi:type="DefaultFieldMapping" />
		<field field="rcalls" name="ReadCalls" data-type="LONG" xsi:type="DefaultFieldMapping" />
		<field field="scalls" name="SuspectCalls" data-type="LONG" xsi:type="DefaultFieldMapping" />
		<field field="tbytes" name="TotalBytes" data-type="LONG" xsi:type="DefaultFieldMapping" />
		<field field="wbytes" name="WriteBytes" data-type="LONG" xsi:type="DefaultFieldMapping" />
		<field field="rbytes" name="ReadBytes" data-type="LONG" xsi:type="DefaultFieldMapping" />
		<field field="avgtime" name="AverageTime" data-type="LONG" xsi:type="DefaultFieldMapping" />
		<field field="serialnb" name="serialnb" data-type="STRING" xsi:type="DefaultFieldMapping" />
	</mapping>
</configuration>