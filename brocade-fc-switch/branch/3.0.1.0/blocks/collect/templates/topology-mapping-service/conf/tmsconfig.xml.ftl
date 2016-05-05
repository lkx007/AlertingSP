[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<config>
[#if use_topo]
	<host>${topologyservice.host}</host>
	<port>${topologyservice.gateway.port}</port>
	<username>${topologyservice.gateway.username}</username>
	<password>${topologyservice.gateway.password}</password>
[#else]
	<host>localhost</host>
	<port>48443</port>
	<username>admin</username>
	<password>changeme</password>
[/#if]
</config>