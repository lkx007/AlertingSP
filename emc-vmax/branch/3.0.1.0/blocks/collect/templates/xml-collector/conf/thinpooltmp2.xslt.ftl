[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/mobile" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" name="xml"/>
	<xsl:param name="request"/>
	<xsl:template match="/">
		<xsl:for-each select="//ns2:poolId">
			<xsl:call-template name="w4n.makeRequests.bysymmetrixId">
				<xsl:with-param name="device" select="$request//ns2:symmetrixId"/>
				<xsl:with-param name="pool" select="node()"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="w4n.makeRequests.bysymmetrixId">
		<xsl:param name="device"/>
		<xsl:param name="pool"/>
		<xsl:variable name="filePath" select="'tmp/thinpooltmp2/'"/>
		<xsl:variable name="requestFilename" select="concat($filePath, $device, $pool, '.metrics.xml')"/>
		<xsl:variable name="epoch" select="current-dateTime() - xs:dateTime('1970-01-01T00:00:00+00:00')" />
[#if emcvmax??]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - ${emcvmax.perf.pollingperiod})" />
[#else]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - 3600)" />
[/#if]
		<xsl:variable name="enddate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch))" />
		<xsl:result-document href="{$requestFilename}" format="xml">
			<thinPoolParam xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/config">
				<startDate>
					<xsl:copy-of select="$startdate"/>000</startDate>
				<endDate>
					<xsl:copy-of select="$enddate"/>000</endDate>
				<ns2:symmetrixId>
					<xsl:value-of select="$device"/>
				</ns2:symmetrixId>
				<ns2:poolId>
					<xsl:value-of select="$pool"/>
				</ns2:poolId>
				<metrics>EGRESS_TRACKS</metrics>
				<metrics>INGRESS_TRACKS</metrics>
				<metrics>BE_RESPONSE_TIME</metrics>
[#--
				<metrics>ALLOCATED_POOL_CAPACITY_GB</metrics>
				<metrics>AVG_BE_DISK_TIME</metrics>
				<metrics>AVG_BE_REQ_TIME</metrics>
				<metrics>AVG_BE_TASK_TIME</metrics>
				<metrics>BE_MB_READ_RATE</metrics>
				<metrics>BE_MB_TRANSFERED_PER_SEC</metrics>
				<metrics>BE_MB_WRITE_RATE</metrics>
				<metrics>BE_PERCENT_READ</metrics>
				<metrics>BE_PERCENT_WRITE</metrics>
				<metrics>BE_READS</metrics>
				<metrics>BE_WRITES</metrics>
				<metrics>BE_RESPONSE_TIME_READ</metrics>
				<metrics>BE_RESPONSE_TIME_WRITE</metrics>
				<metrics>COMPRESSED_TRACKS</metrics>
				<metrics>ENABLED_POOL_CAPACITY_GB</metrics>
				<metrics>IO_DENSITY</metrics>
				<metrics>PERCENT_COMPRESSED_TRACKS</metrics>
				<metrics>PERCENT_USED_CAPACITY</metrics>
				<metrics>SAMPLED_AVG_RDF_WRITE_TIME</metrics>
				<metrics>SAMPLED_AVG_READ_MISS_TIME</metrics>
				<metrics>SAMPLED_AVG_WP_DISCONNECT_TIME</metrics>
				<metrics>TOTAL_BE_REQ_PER_SEC</metrics>
				<metrics>TOTAL_POOL_CAPACITY_GB</metrics>
				<metrics>USED_POOL_CAPACITY_GB</metrics>
--]
			</thinPoolParam>
		</xsl:result-document>
	</xsl:template>
</xsl:stylesheet>