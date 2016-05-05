[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE config SYSTEM "socketconnector.dtd" >
<config>
	<host>${msotsdr.timeseries.socketconnector.host}</host>
	<port>${msotsdr.timeseries.socketconnector.port}</port>
	<buffer-size>32768</buffer-size>
	[#if msotsdr.failover]
	<retry-count>0</retry-count>
	[#else]
	<retry-count>1</retry-count>
	[/#if]
	<retry-timeout>5000</retry-timeout>
	<connect-timeout>60000</connect-timeout>
	<write-timeout>5000</write-timeout>
</config>
