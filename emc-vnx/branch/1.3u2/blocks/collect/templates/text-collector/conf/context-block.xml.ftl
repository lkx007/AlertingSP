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
[#if vnx.block.password??]
		<properties name="password">${vnx.block.password}</properties>
[/#if]
[#if apg.os == 'windows']
  [#if naviseccli.path??]
    [#if vnx.block.use_secfile]
      [#if vnx.block.secfilepath??]
		<properties name="command">"${naviseccli.path?rtf}" -secfilepath "${vnx.block.secfilepath?rtf}"</properties>
      [#else]
		<properties name="command">"${naviseccli.path?rtf}"</properties>
      [/#if]
    [#else]
		<properties name="command">"${naviseccli.path?rtf}" -User ${vnx.block.username} -Password @password -Scope ${vnx.block.userscope}</properties>
    [/#if]
  [#else]
    [#if vnx.block.use_secfile]
      [#if vnx.block.secfilepath??]
		<properties name="command">"C:\\Program Files (x86)\\EMC\\Navisphere CLI\\NaviSECCli.exe" -secfilepath "${vnx.block.secfilepath?rtf}"</properties>
      [#else]
		<properties name="command">"C:\\Program Files (x86)\\EMC\\Navisphere CLI\\NaviSECCli.exe"</properties>
      [/#if]
    [#else]
		<properties name="command">"C:\\Program Files (x86)\\EMC\\Navisphere CLI\\NaviSECCli.exe" -User ${vnx.block.username} -Password @password -Scope ${vnx.block.userscope}</properties>
    [/#if]
  [/#if]
[#else]
[#-- linux or solaris --]
  [#if naviseccli.path??]
  [#assign escapedpath = naviseccli.path?rtf]
    [#if vnx.block.use_secfile]
      [#if vnx.block.secfilepath??]
		<properties name="command">${escapedpath} -secfilepath "${vnx.block.secfilepath}"</properties>
      [#else]
		<properties name="command">${escapedpath}</properties>
      [/#if]
    [#else]
		<properties name="command">${escapedpath} -User ${vnx.block.username} -Password @password -Scope ${vnx.block.userscope}</properties>
    [/#if]
  [#else]
    [#if vnx.block.use_secfile]
      [#if vnx.block.secfilepath??]
		<properties name="command">/opt/Navisphere/bin/naviseccli -secfilepath "${vnx.block.secfilepath}"</properties>
      [#else]
		<properties name="command">/opt/Navisphere/bin/naviseccli</properties>
      [/#if]
    [#else]
		<properties name="command">/opt/Navisphere/bin/naviseccli -User ${vnx.block.username} -Password @password -Scope ${vnx.block.userscope}</properties>
    [/#if]
  [/#if]
[/#if]
	</contexts>
[/#if]
[/#list]
</execution-contexts>