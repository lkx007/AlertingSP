<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:a="http://www.w3.org/2005/Atom">
	<!--
XML Data to parse (result of first command)
************************************************************************************************
<?xml version="1.0" encoding="UTF-8"?>
<result>
	<num_pages>2</num_pages>
	<num_rows>25</num_rows>
	<subtenants>
		<subtenant>
			<id>18</id>
			<name>Maginatics</name>
			<uuid>bf1f98ea01b14b479621cfaaed3f1ada</uuid>
			<tag/>
			<tenant_id>2</tenant_id>
			<tenant_name>Tenant1</tenant_name>
			<num_objects>128010</num_objects>
			<object_size_user>7617761179</object_size_user>
			<object_size>22853281617</object_size>
			<average_object_capacity>178527</average_object_capacity>
			<metadata_size>548323463</metadata_size>
			<total_size>23401605080</total_size>
			<percent_total_size>42.7</percent_total_size>
			<updated_time>2013-10-14 06:58:37.512904+02</updated_time>
		</subtenant>
		<subtenant>
			<id>4</id>
			<name>Syncplicity</name>
			<uuid>718fc836f59549c3bfcf6d81b83aaad2</uuid>
			<tag/>
			<tenant_id>2</tenant_id>
			<tenant_name>Tenant1</tenant_name>
			<num_objects>18419</num_objects>
			<object_size_user>7484255356</object_size_user>
			<object_size>22452765108</object_size>
			<average_object_capacity>1219000</average_object_capacity>
			<metadata_size>75725003</metadata_size>
			<total_size>22528490111</total_size>
			<percent_total_size>41.1</percent_total_size>
			<updated_time>2013-10-14 06:58:34.892556+02</updated_time>
		</subtenant>
	</subtenants>
</result>
************************************************************************************************
Output of the Translation:
************************************************
subtenant_id=18
subtenant_id=4
************************************************
-->
	<xsl:output method="text"/>
	<xsl:template match="/">
		<xsl:for-each select="/result/subtenants/subtenant">
        subtenant_id=<xsl:value-of select="id"/>
		<!--<xsl:text>
		</xsl:text>-->
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
