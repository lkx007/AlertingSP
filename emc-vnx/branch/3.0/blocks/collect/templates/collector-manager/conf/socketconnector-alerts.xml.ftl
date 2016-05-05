[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE config SYSTEM "socketconnector.dtd" >
<config>
	<host>${alertconsolidation.host}</host>
	<port>${alertconsolidation.port}</port>
	<buffer-size>32768</buffer-size>
	<retry-count>1</retry-count>
	<retry-timeout>5000</retry-timeout>
	<connect-timeout>60000</connect-timeout>
	<write-timeout>5000</write-timeout>
</config>