[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/mobile" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" name="xml"/>
	<xsl:param name="request"/>
	<xsl:template match="/">
		<xsl:for-each select="//ns2:diskId">
			<xsl:call-template name="w4n.makeRequests.bysymmetrixId">
				<xsl:with-param name="device" select="$request//ns2:symmetrixId"/>
				<xsl:with-param name="disk" select="node()"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="w4n.makeRequests.bysymmetrixId">
		<xsl:param name="device"/>
		<xsl:param name="disk"/>
		<xsl:variable name="filePath" select="'tmp/disktmp2/'"/>
		<xsl:variable name="requestFilename" select="concat($filePath, $device, $disk, '.metrics.xml')"/>
		<xsl:variable name="epoch" select="current-dateTime() - xs:dateTime('1970-01-01T00:00:00+00:00')" />
[#if emcvmax??]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - ${emcvmax.perf.pollingperiod})" />
[#else]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - 3600)" />
[/#if]
		<xsl:variable name="enddate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch))" />
		<xsl:result-document href="{$requestFilename}" format="xml">
			<diskParam xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/config">
				<startDate>
					<xsl:copy-of select="$startdate"/>000</startDate>
				<endDate>
					<xsl:copy-of select="$enddate"/>000</endDate>
				<ns2:symmetrixId>
					<xsl:value-of select="$device"/>
				</ns2:symmetrixId>
				<ns2:diskId>
					<xsl:value-of select="$disk"/>
				</ns2:diskId>
				<metrics>READS</metrics>
				<metrics>WRITES</metrics>
				<metrics>MB_READ_PER_SEC</metrics>
				<metrics>MB_WRITE_PER_SEC</metrics>
				<metrics>RESPONSE_TIME_READ</metrics>
				<metrics>RESPONSE_TIME_WRITE</metrics>
				<metrics>IO_RATE</metrics>
				<metrics>PERCENT_DISK_BUSY</metrics>
[#--
				<metrics>AVG_HYPER_PER_SEEK</metrics>
				<metrics>AVG_KB_PER_READ</metrics>
				<metrics>AVG_KB_PER_WRITE</metrics>
				<metrics>AVG_QUEUE_DEPTH</metrics>
				<metrics>MB_RATE</metrics>
				<metrics>PERCENT_DISK_IDLE</metrics>
				<metrics>PERCENT_FREE_CAPACITY</metrics>
				<metrics>PERCENT_USED_CAPACITY</metrics>
				<metrics>RESPONSE_TIME</metrics>
				<metrics>SCSI_COMM</metrics>
				<metrics>SEEK_DISTANCE_PER_SEC</metrics>
				<metrics>SEEKS_PER_SEC</metrics>
				<metrics>SKIP_MASK_COMMAD_PER_SEC</metrics>
				<metrics>TOTAL_DISK_CAPACITY_GB</metrics>
				<metrics>VERIFY_COMMAND_PER_SEC</metrics>
				<metrics>XOR_READ_COMMAND_PER_SEC</metrics>
				<metrics>XOR_WRITE_COMMAND_PER_SEC</metrics>
				<metrics>USED_DISK_CAPACITY_GB</metrics>
--]
			</diskParam>
		</xsl:result-document>
	</xsl:template>
</xsl:stylesheet>