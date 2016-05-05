[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<execution-contexts xmlns="http://www.watch4net.com/XMLCollector" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.watch4net.com/XMLCollector contextdefinition.xsd ">
	<contexts name="ATMOS-ACRT">
	<properties name="host">${emcatmos.crt.host}</properties>
		<!-- 
		This is a dummy username and password so it is compatible with APG XMLExecutor class. ACRT doens't have any login credentials 
		-->
		<properties name="username">username</properties>
		<properties name="password">password</properties>
	</contexts>
</execution-contexts>