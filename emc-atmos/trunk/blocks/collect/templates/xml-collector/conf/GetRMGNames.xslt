<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:a="http://www.w3.org/2005/Atom">
	<!--
XML Data to parse (result of first command)
************************************************************************************************
<?xml version="1.0" encoding="UTF-8"?>
<rmgList>
  <rmg name="rmg02">
    <name>rmg02</name>
    <location>Paris</location>
    <localTime>Thu Feb 06 12:01:48 +0000 2014</localTime>
    <nodesUp>4</nodesUp>
    <nodesDown>0</nodesDown>
    <avgLoad15>70.375</avgLoad15>
    <avgLoad5>69.125</avgLoad5>
    <avgLoad1>72.25</avgLoad1>
  </rmg>
  <rmg name="rmg01">
    <name>rmg01</name>
    <location>Cambridge</location>
    <localTime>Thu Feb 06 12:01:26 +0000 2014</localTime>
    <nodesUp>4</nodesUp>
    <nodesDown>0</nodesDown>
    <avgLoad15>345.25</avgLoad15>
    <avgLoad5>330.25</avgLoad5>
    <avgLoad1>336.25</avgLoad1>
  </rmg>
</rmgList>
************************************************************************************************
Output of the Translation:
************************************************
rmg/rmg01 rmg/rmg02
************************************************
-->
	<xsl:output method="text"/>
	<xsl:template match="/">
		<xsl:for-each select="/rmgList/rmg">
        rmgs/<xsl:value-of select="name"/>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
