<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:a="http://www.w3.org/2005/Atom">
	<!--
XML Data to parse (result of first command)
************************************************************************************************
<result>
    <tenants>
        <tenant>
            <id>2</id>
            <name>Tenant1</name>
            <uuid>97045c0bff204c9d8522ca50097fcd8b</uuid>
            <num_objects>155532</num_objects>
            <object_size_user>18041225123</object_size_user>
            <object_size>54121854598</object_size>
            <metadata_size>649325656</metadata_size>
            <total_size>54766944559</total_size>
            <updated_time>2013-10-14 06:58:40.458089+02</updated_time>
        </tenant>
    </tenants>
</result>
************************************************************************************************
Output of the Translation:
************************************************
tenant_id=2
************************************************
-->
	<xsl:output method="text"/>
	<xsl:template match="/">
		<xsl:for-each select="/result/tenants/tenant">
					tenant_id=<xsl:value-of select="id"/>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
