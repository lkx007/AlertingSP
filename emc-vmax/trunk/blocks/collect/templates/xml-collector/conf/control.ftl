<#if vmax??>
<#list vmax as vmaxarray>
	<#assign serialnb = vmaxarray.serialnb?string>
	<@process path="GetStatisticsCollection-Array.request.ftl" output="GetStatisticsCollection-Array-${serialnb}.request" encoding="UTF-8" />
	<@process path="GetStatisticsCollection-Volumes.request.ftl" output="GetStatisticsCollection-Volumes-${serialnb}.request" encoding="UTF-8" />
</#list>
</#if>
<@process path="*.*" />
<@process path="requests/*.*" />
