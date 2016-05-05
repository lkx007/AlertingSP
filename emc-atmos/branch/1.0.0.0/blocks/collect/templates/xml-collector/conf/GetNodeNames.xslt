<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:a="http://www.w3.org/2005/Atom">
	<!--
XML Data to parse (result of first command)
************************************************************************************************
<?xml version="1.0" encoding="UTF-8"?>
<nodeList>
    <node location="Cambridge" up="true" name="rmg01-is1-004" mgmtIp="10.6.145.156"></node>
    <node location="Cambridge" up="true" name="rmg01-is1-003" mgmtIp="10.6.145.155"></node>
    <node location="Cambridge" up="true" name="rmg01-is1-002" mgmtIp="10.6.145.154"></node>
    <node location="Cambridge" up="true" name="rmg01-is1-001" mgmtIp="10.6.145.153"></node>
</nodeList>
************************************************************************************************
Output of the Translation:
************************************************
rmgs/rmg01/nodes/rmg01-is1-004 rmgs/rmg01/nodes/rmg01-is1-003 rmgs/rmg01/nodes/rmg01-is1-002 rmgs/rmg01/nodes/rmg01-is1-001
************************************************
-->
	<xsl:output method="text"/>
	<xsl:template match="/">
		<xsl:for-each select="/nodeList/node">
        rmgs/<xsl:value-of select="substring-before(@name,'-')"/>/nodes/<xsl:value-of select="@name"/>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
