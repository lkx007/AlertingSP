[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<execution-contexts xmlns="http://www.watch4net.com/XMLCollector"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.watch4net.com/XMLCollector contextdefinition.xsd ">
[#list smiprovider as smiprovider]
	<contexts name="SMIP${smiprovider_index}">
		<properties name="host">${smiprovider.host}</properties>
		<properties name="username">${smiprovider.username}</properties>
		<properties name="password">${smiprovider.password}</properties>		
		[#if smiprovider.usesecure && !smiprovider.port??]
			<properties name="connectionstring">https://${smiprovider.host}:5989</properties>
		[#elseif smiprovider.usesecure && smiprovider.port??]
			<properties name="connectionstring">https://${smiprovider.host}:${smiprovider.port}</properties>
		[#elseif !smiprovider.usesecure && smiprovider.port??]
			<properties name="connectionstring">http://${smiprovider.host}:${smiprovider.port}</properties>
		[#elseif !smiprovider.usesecure && !smiprovider.port??]
			<properties name="connectionstring">http://${smiprovider.host}:5988</properties>		
		[/#if]	        	
	</contexts>
[/#list]
</execution-contexts>