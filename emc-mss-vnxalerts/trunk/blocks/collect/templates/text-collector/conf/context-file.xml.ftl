[#ftl]
[#setting url_escaping_charset="UTF-8"]
<?xml version="1.0" encoding="UTF-8"?>
<execution-contexts xmlns="http://www.watch4net.com/OutputParsingLibrary"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.watch4net.com/OutputParsingLibrary contextdefinition.xsd ">
[#if vnx??]
	[#list vnx as vnx]
	[#if vnx.type == 'unified' || vnx.type == 'file']
	[#assign escapeurl=vnx.file.username /]
	<contexts name="VNX${vnx_index}">
[#if vnx.type == 'unified']
		<properties name="sstype">Unified</properties>
[#elseif vnx.type == 'block']
		<properties name="sstype">Block</properties>
[#elseif vnx.type == 'file']
		<properties name="sstype">File</properties>
[/#if]
		<properties name="deviceid">${vnx_index}</properties>
		<properties name="id">${vnx_index}</properties>
		<properties name="friendlyname">${vnx.friendlyname}</properties>
		<properties name="csprimary">${vnx.file.csprimary}</properties>
[#if vnx.file.cssecondary??]
		<properties name="cssecondary">${vnx.file.cssecondary}</properties>
[#else]
[#-- MAV: let set the secondary back on primary... not super good, but at least contexts will work --]
		<properties name="cssecondary">${vnx.file.csprimary}</properties>
[/#if]
		<properties name="fileusername">${vnx.file.username}</properties>
		<properties name="fileurlusername">${escapeurl?url}</properties>
		<properties name="filepassword">${vnx.file.password}</properties>
	</contexts>
	[/#if]
	[/#list]
[/#if]
</execution-contexts>