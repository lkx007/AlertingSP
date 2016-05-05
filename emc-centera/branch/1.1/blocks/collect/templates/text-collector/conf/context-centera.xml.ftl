[#ftl]
[#setting url_escaping_charset="UTF-8"]
<?xml version="1.0" encoding="UTF-8"?>
<execution-contexts xmlns="http://www.watch4net.com/OutputParsingLibrary"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.watch4net.com/OutputParsingLibrary contextdefinition.xsd ">
[#list emccentera.centera as centera]
	<contexts name="CENTERA${centera_index}">
		<properties name="friendlyname">${centera.friendlyname}</properties>
		<properties name="host">${centera.host}</properties>
		<properties name="username">${centera.username}</properties>
		<properties name="password">${centera.password}</properties>
[#if apg.os == 'windows']
  [#if emccentera.centeracli.path??]        
		<properties name="clipath">${emccentera.centeracli.path?rtf}</properties>  
  [#else]
		<properties name="clipath">C:\\Program Files (x86)\\EMC\\Centera\\4_2\\SystemOperator\\lib</properties>
  [/#if]
[#else]
[#-- solaris --]
  [#if emccentera.centeracli.path??]        
		<properties name="clipath">${emccentera.centeracli.path?rtf}</properties>  
  [#else]
		<properties name="clipath">/opt/Centera_SDK/lib</properties>
  [/#if]
[/#if]
	</contexts>
[/#list]
</execution-contexts>