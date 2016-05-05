[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<execution-contexts xmlns="http://www.watch4net.com/XMLCollector"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.watch4net.com/XMLCollector contextdefinition.xsd ">
[#if smi??]
    [#assign host = smi.host]
    [#if smi.port??]
        [#assign port = smi.port]
    [#else]
        [#if smi.usesecure]
            [#assign port = "5989"]
        [#else]    
            [#assign port = "5988"]
        [/#if]
    [/#if]

    [#if smi.usesecure]
        [#assign protocol = "https"]
    [#else]
        [#assign protocol = "http"]
    [/#if]
    <contexts name="SMI">
        <properties name="host">${host}</properties>
        <properties name="port">${port}</properties>
        <properties name="url">${protocol}://${host}:${port}/cimom</properties>
        <properties name="username">${smi.username}</properties>
        <properties name="password">${smi.password}</properties>
    </contexts>
[/#if]
</execution-contexts>