<#list vnx as vnx>
<@process path="collect-VNX_ID.sh" output="collect-${vnx_index}.sh" encoding="UTF-8" />
<@process path="fs_dedupe-VNX_ID.sh" output="fs_dedupe-${vnx_index}.sh" encoding="UTF-8" />
</#list>
<@process path="context-block.xml.ftl" />
<@process path="context-file.xml.ftl" />
<@process path="*.xml" />
<@process path="*.pl" />
<@process path="*.sh" />