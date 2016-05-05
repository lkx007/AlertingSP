[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/mobile" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" name="xml"/>
	<xsl:template match="/">
		<xsl:for-each select="//ns2:symmetrixId">
			<xsl:call-template name="w4n.makeRequests.bysymmetrixId">
				<xsl:with-param name="device" select="node()"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="w4n.makeRequests.bysymmetrixId">
		<xsl:param name="device"/>
		<xsl:variable name="filePath" select="'tmp/arraymetricstmp/'"/>
		<xsl:variable name="requestFilename" select="concat($filePath, $device, '.metrics.xml')"/>
		<xsl:variable name="epoch" select="current-dateTime() - xs:dateTime('1970-01-01T00:00:00+00:00')" />
[#if emcvmax??]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - ${emcvmax.perf.pollingperiod})" />
[#else]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - 3600)" />
[/#if]
		<xsl:variable name="enddate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch))" />
		<xsl:result-document href="{$requestFilename}" format="xml">
			<arrayParam xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/config">
				<startDate>
					<xsl:copy-of select="$startdate"/>000</startDate>
				<endDate>
					<xsl:copy-of select="$enddate"/>000</endDate>
				<ns2:symmetrixId>
					<xsl:value-of select="$device"/>
				</ns2:symmetrixId>
				<metrics>READS</metrics>
				<metrics>WRITES</metrics>
				<metrics>MB_READ_PER_SEC</metrics>
				<metrics>MB_WRITE_PER_SEC</metrics>
				<metrics>TOTAL_CACHE_UTILIZATION</metrics>
				<metrics>SYS_WRITE_PENDING_EVENT_PER_SEC</metrics>
				<metrics>WP</metrics>
				<metrics>READ_MISS_PER_SEC</metrics>
				<metrics>IO_RATE</metrics>
[#--
				<metrics>AVG_LRU0_FALL_THRU_TIME</metrics>
				<metrics>BE_IOS_PER_SEC</metrics>
				<metrics>BE_READS</metrics>
				<metrics>BE_WRITES</metrics>
				<metrics>DESTAGED_TRACKS_PER_SEC</metrics>
				<metrics>DEV_WRITE_PENDING_EVENT_PER_SEC</metrics>
				<metrics>FE_READ_REQS_PER_SEC</metrics>
				<metrics>FE_WRITE_REQS_PER_SEC</metrics>
				<metrics>HA_MB_PER_SEC</metrics>
				<metrics>HIT_PER_SEC</metrics>
				<metrics>PERCENT_HIT</metrics>
				<metrics>PERCENT_READ</metrics>
				<metrics>PERCENT_WRITE</metrics>
				<metrics>PREFETCHED_TRACK_PER_SEC</metrics>
				<metrics>READ_HIT_PER_SEC</metrics>
				<metrics>REQUEST_PER_SEC</metrics>
				<metrics>RESPONSE_TIME_READ</metrics>
				<metrics>RESPONSE_TIME_WRITE</metrics>
				<metrics>TOTAL_BE_REQ_PER_SEC</metrics>
				<metrics>WP_LIMIT</metrics>
				<metrics>WRITE_HIT_PER_SEC</metrics>
				<metrics>WRITE_MISS_PER_SEC</metrics>
				<metrics>VFC_DEDUP_HITS</metrics>
				<metrics>VFC_DEDUP_READS</metrics>
				<metrics>VFC_DEDUP_WRITES</metrics>
				<metrics>VFC_IOS</metrics>
				<metrics>VFC_PER_READS</metrics>
				<metrics>VFC_PER_WRITES</metrics>
				<metrics>VFC_PER_READ_HITS</metrics>
				<metrics>VFC_READ_HITS</metrics>
				<metrics>VFC_READS</metrics>
				<metrics>VFC_SKIPPED_IOS</metrics>
				<metrics>VFC_WRITE_HITS</metrics>
				<metrics>VFC_WRITES</metrics>
--]
			</arrayParam>
		</xsl:result-document>
	</xsl:template>
</xsl:stylesheet>