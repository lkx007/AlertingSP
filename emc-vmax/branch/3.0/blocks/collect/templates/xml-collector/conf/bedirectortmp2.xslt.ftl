[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/mobile" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" name="xml"/>
	<xsl:param name="request"/>
	<xsl:template match="/">
		<xsl:for-each select="//ns2:directorId">
			<xsl:call-template name="w4n.makeRequests.bysymmetrixId">
				<xsl:with-param name="device" select="$request//ns2:symmetrixId"/>
				<xsl:with-param name="director" select="node()"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="w4n.makeRequests.bysymmetrixId">
		<xsl:param name="device"/>
		<xsl:param name="director"/>
		<xsl:variable name="filePath" select="'tmp/bedirectortmp2/'"/>
		<xsl:variable name="requestFilename" select="concat($filePath, $device, $director, '.metrics.xml')"/>
		<xsl:variable name="epoch" select="current-dateTime() - xs:dateTime('1970-01-01T00:00:00+00:00')" />
[#if emcvmax??]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - ${emcvmax.perf.pollingperiod})" />
[#else]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - 3600)" />
[/#if]
		<xsl:variable name="enddate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch))" />
		<xsl:result-document href="{$requestFilename}" format="xml">
			<beDirectorParam xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/config">
				<startDate>
					<xsl:copy-of select="$startdate"/>000</startDate>
				<endDate>
					<xsl:copy-of select="$enddate"/>000</endDate>
				<ns2:symmetrixId>
					<xsl:value-of select="$device"/>
				</ns2:symmetrixId>
				<ns2:directorId>
					<xsl:value-of select="$director"/>
				</ns2:directorId>
				<metrics>PERCENT_BUSY</metrics>
				<metrics>IO_RATE</metrics>
				<metrics>READS</metrics>
				<metrics>WRITES</metrics>
				<metrics>MB_READ_PER_SEC</metrics>
				<metrics>MB_WRITE_PER_SEC</metrics>
				<metrics>REQUEST_PER_SEC</metrics>
[#--
				<metrics>AVR_TIME_PER_SYSCALL</metrics>
				<metrics>CLONE_COPY_READ</metrics>
				<metrics>CLONE_COPY_WRITE</metrics>
				<metrics>COPY_ON_FIRST_ACCESS</metrics>
				<metrics>MB_RATE</metrics>
				<metrics>OPTIMIZED_WRITE</metrics>
				<metrics>PERCENT_IDLE</metrics>
				<metrics>PERCENT_READ</metrics>
				<metrics>PERCENT_WRITE</metrics>
				<metrics>PHCO_REBUILD_COPY</metrics>
				<metrics>PHCO_REBUILD_READ</metrics>
				<metrics>PORT_0_AVG_REQ_SIZE_KB</metrics>
				<metrics>PORT_0_IO_PER_SEC</metrics>
				<metrics>PORT_0_MB_PER_SEC</metrics>
				<metrics>PORT_0_SPEED_GBITS_PER_SEC</metrics>
				<metrics>PORT_0_UTILIZATION</metrics>
				<metrics>PORT_1_AVG_REQ_SIZE_KB</metrics>
				<metrics>PORT_1_IO_PER_SEC</metrics>
				<metrics>PORT_1_MB_PER_SEC</metrics>
				<metrics>PORT_1_SPEED_GBITS_PER_SEC</metrics>
				<metrics>PORT_1_UTILIZATION</metrics>
				<metrics>PREFETCHED_TRACK_PER_SEC</metrics>
				<metrics>SYSCALL_COUNT_PER_SEC</metrics>
				<metrics>SYSCALL_RDF_DIR_COUNT_PER_SEC</metrics>
				<metrics>SYSCALL_REMOTE_DIR_COUNT_PER_SEC</metrics>
				<metrics>VLUN_MIG_WRITE</metrics>
				<metrics>VLUN_MIG_READ</metrics>
				<metrics>COMP_READS</metrics>
				<metrics>COMP_WRITES</metrics>
				<metrics>COMP_MB_READ_PER_SEC</metrics>
				<metrics>COMP_MB_WRITE_PER_SEC</metrics>
				<metrics>COMP_REQUESTS</metrics>
				<metrics>COMP_MB_RATE</metrics>
				<metrics>PERCENT_COMP_READS</metrics>
				<metrics>PERCENT_COMP_WRITES</metrics>
				<metrics>PERCENT_COMP_REQUESTS</metrics>
				<metrics>PERCENT_COMP_MB_READ</metrics>
				<metrics>PERCENT_COMP_MB_WRITTEN</metrics>
				<metrics>PERCENT_COMP_MB</metrics>
--]
			</beDirectorParam>
		</xsl:result-document>
	</xsl:template>
</xsl:stylesheet>