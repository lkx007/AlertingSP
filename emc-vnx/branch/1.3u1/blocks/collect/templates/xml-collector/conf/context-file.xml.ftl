[#ftl]
[#setting url_escaping_charset="UTF-8"]
<?xml version="1.0" encoding="UTF-8"?>
<execution-contexts xmlns="http://www.watch4net.com/XMLCollector"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.watch4net.com/XMLCollector contextdefinition.xsd ">
[#list vnx as vnx]
[#if vnx.type == 'unified' || vnx.type == 'file']
[#assign escapeurl=vnx.file.username /]
	<contexts name="VNX${vnx_index}">
		<properties name="friendlyname">${vnx.friendlyname}</properties>
		<properties name="csprimary">${vnx.file.csprimary}</properties>
		<properties name="fileserial">${vnx.file.serial}</properties>
		<properties name="fileusername">${vnx.file.username}</properties>
		<properties name="fileurlusername">${escapeurl?url}</properties>
		<properties name="filepassword">${vnx.file.password}</properties>
	</contexts>
[/#if]
[/#list]
</execution-contexts>