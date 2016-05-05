[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<execution-contexts xmlns="http://www.watch4net.com/XMLCollector"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.watch4net.com/XMLCollector contextdefinition.xsd ">
[#if emcvmax??]
	[#list emcvmax.unisphere as unisphere]
	<contexts name="UNISPHERE${unisphere_index}">
		<properties name="host">${unisphere.host}</properties>
		<properties name="username">${unisphere.username}</properties>
		<properties name="password">${unisphere.password}</properties>
	</contexts>
	[/#list]
[/#if]
</execution-contexts>