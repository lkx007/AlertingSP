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
		<xsl:variable name="filePath" select="'tmp/rdfdirectortmp2/'"/>
		<xsl:variable name="requestFilename" select="concat($filePath, $device, $director, '.metrics.xml')"/>
		<xsl:variable name="epoch" select="current-dateTime() - xs:dateTime('1970-01-01T00:00:00+00:00')" />
[#if emcvmax??]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - ${emcvmax.perf.pollingperiod})" />
[#else]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - 3600)" />
[/#if]
		<xsl:variable name="enddate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch))" />
		<xsl:result-document href="{$requestFilename}" format="xml">
			<rdfDirectorParam xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/config">
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
				<metrics>REQUEST_PER_SEC</metrics>
				<metrics>MB_READ_PER_SEC</metrics>
				<metrics>MB_WRITE_PER_SEC</metrics>
				<metrics>AVG_IO_SERVICE_TIME</metrics>
[#--
				<metrics>AVG_KB_PER_IO_REC</metrics>
				<metrics>AVG_KB_PER_IO_SENT</metrics>
				<metrics>AVR_TIME_PER_SYSCALL</metrics>
				<metrics>COPY_IO_MBYTES_PER_SEC</metrics>
				<metrics>COPY_IOS_PER_SEC</metrics>
				<metrics>COMP_MB_RATE</metrics>
				<metrics>COMP_MB_READ_PER_SEC</metrics>
				<metrics>COMP_MB_WRITE_PER_SEC</metrics>
				<metrics>MB_RATE</metrics>
				<metrics>NUM_LINKS</metrics>
				<metrics>NUM_COMP_LINKS</metrics>
				<metrics>PERCENT_IDLE</metrics>
				<metrics>PERCENT_COMP_MB</metrics>
				<metrics>PERCENT_COMP_MB_READ</metrics>
				<metrics>PERCENT_COMP_MB_WRITTEN</metrics>
				<metrics>PORT_0_SPEED_GBITS_PER_SEC</metrics>
				<metrics>PORT_0_UTILIZATION</metrics>
				<metrics>SRDFA_WRITES_PER_SEC</metrics>
				<metrics>SRDFS_WRITES_PER_SEC</metrics>
				<metrics>SRDFA_MBYTES_WRITTEN_PER_SEC</metrics>
				<metrics>SRDFS_MBYTES_WRITTEN_PER_SEC</metrics>
				<metrics>SYSCALL_COUNT_PER_SEC</metrics>
				<metrics>SYSCALL_RDF_DIR_COUNT_PER_SEC</metrics>
				<metrics>SYSCALL_REMOTE_DIR_COUNT_PER_SEC</metrics>
				<metrics>SYSCALL_TIME_PER_SEC</metrics>
				<metrics>TOTAL_RDF_READS</metrics>
				<metrics>TOTAL_RDF_WRITES</metrics>
				<metrics>WRITE_MISS_PER_SEC</metrics>
--]
			</rdfDirectorParam>
		</xsl:result-document>
	</xsl:template>
</xsl:stylesheet>