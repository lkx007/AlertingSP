[#ftl]
[#setting url_escaping_charset="UTF-8"]
<?xml version="1.0" encoding="UTF-8"?>
<execution-contexts xmlns="http://www.watch4net.com/OutputParsingLibrary"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.watch4net.com/OutputParsingLibrary contextdefinition.xsd ">
[#list vnx as vnx]
[#if vnx.type == 'unified' || vnx.type == 'block']
	<contexts name="VNX${vnx_index}">
		<properties name="friendlyname">${vnx.friendlyname}</properties>
		<properties name="spa">${vnx.block.spa}</properties>
		<properties name="spb">${vnx.block.spb}</properties>
		<properties name="blockserial">${vnx.block.serial}</properties>
		<properties name="userscope">${vnx.block.userscope}</properties>
		<properties name="blockusername">${vnx.block.username}</properties>
		<properties name="blockpassword">${vnx.block.password}</properties>
[#if apg.os == 'windows']
[#if vnx.block.naviseccli.path??]
		<properties name="navisecclipath">"${vnx.block.naviseccli.path}"</properties>
[#else]
		<properties name="navisecclipath">"C:\\Program Files (x86)\\EMC\\Navisphere CLI\\NaviSECCli.exe"</properties>
[/#if]
[#else]
[#-- linux or solaris --]
[#if vnx.block.naviseccli.path??]
[#assign escapedpath = vnx.block.naviseccli.path?rtf]
		<properties name="navisecclipath">${escapedpath}</properties>
[#else]
		<properties name="navisecclipath">/opt/Navisphere/bin/naviseccli</properties>
[/#if]
[/#if]
	</contexts>
[/#if]
[/#list]
</execution-contexts>