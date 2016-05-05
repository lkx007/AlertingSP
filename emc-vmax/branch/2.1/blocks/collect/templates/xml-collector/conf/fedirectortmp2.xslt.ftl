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
		<xsl:variable name="filePath" select="'tmp/fedirectortmp2/'"/>
		<xsl:variable name="requestFilename" select="concat($filePath, $device, $director, '.metrics.xml')"/>
		<xsl:variable name="epoch" select="current-dateTime() - xs:dateTime('1970-01-01T00:00:00+00:00')" />
[#if emcvmax??]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - ${emcvmax.perf.pollingperiod})" />
[#else]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - 3600)" />
[/#if]
		<xsl:variable name="enddate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch))" />
		<xsl:result-document href="{$requestFilename}" format="xml">
			<feDirectorParam xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/config">
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
				<metrics>PERCENT_READ_HIT</metrics>
				<metrics>READ_MISS_PER_SEC</metrics>
				<metrics>IO_RATE</metrics>
				<metrics>READS</metrics>
				<metrics>WRITES</metrics>
				<metrics>HA_MB_PER_SEC</metrics>
				<metrics>SYS_WRITE_PENDING_EVENT_PER_SEC</metrics>
				<metrics>DEV_WRITE_PENDING_EVENT_PER_SEC</metrics>
				<metrics>REQUEST_PER_SEC</metrics>
[#--
				<metrics>AVG_QUEUE_DEPTH_RANGE_4</metrics>
				<metrics>AVG_QUEUE_DEPTH_RANGE_3</metrics>
				<metrics>AVG_QUEUE_DEPTH_RANGE_2</metrics>
				<metrics>AVG_QUEUE_DEPTH_RANGE_1</metrics>
				<metrics>AVG_QUEUE_DEPTH_RANGE_0</metrics>
				<metrics>PORT_0_IO_PER_SEC</metrics>
				<metrics>AVG_WRITE_RT_4_TO_8</metrics>
				<metrics>AVR_TIME_PER_SYSCALL</metrics>
				<metrics>PORT_0_UTILIZATION</metrics>
				<metrics>READ_RT_COUNT_RANGE_OVER_64</metrics>
				<metrics>READ_HIT_PER_SEC</metrics>
				<metrics>PORT_1_MBYTES_WRITTEN_PER_SEC</metrics>
				<metrics>PORT_1_MBYTES_READ_PER_SEC</metrics>
				<metrics>HIT_PER_SEC</metrics>
				<metrics>WRITE_MISS_PER_SEC</metrics>
				<metrics>WRITE_RT_COUNT_RANGE_OVER_64</metrics>
				<metrics>READ_RT_COUNT_RANGE_16_TO_32</metrics>
				<metrics>WRITE_RT_COUNT_RANGE_0_TO_1</metrics>
				<metrics>READ_RT_COUNT_RANGE_4_TO_8</metrics>
				<metrics>AVG_READ_RT_0_TO_1</metrics>
				<metrics>SYSCALL_COUNT_PER_SEC</metrics>
				<metrics>PORT_1_AVG_REQ_SIZE_KB</metrics>
				<metrics>PORT_1_MB_PER_SEC</metrics>
				<metrics>AVG_READ_RT_16_TO_32</metrics>
				<metrics>PORT_1_IO_PER_SEC</metrics>
				<metrics>AVG_READ_RT_OVER_64</metrics>
				<metrics>READ_RT_COUNT_RANGE_32_TO_64</metrics>
				<metrics>WRITE_RT_COUNT_RANGE_1_TO_2</metrics>
				<metrics>AVG_READ_RT_1_TO_2</metrics>
				<metrics>SYSCALL_REMOTE_DIR_COUNT_PER_SEC</metrics>
				<metrics>AVG_WRITE_RT_8_TO_16</metrics>
				<metrics>SYSCALL_RDF_DIR_COUNT_PER_SEC</metrics>
				<metrics>PORT_0_MBYTES_WRITTEN_PER_SEC</metrics>
				<metrics>AVG_READ_RT_32_TO_64</metrics>
				<metrics>PORT_0_AVG_REQ_SIZE_KB</metrics>
				<metrics>READ_RT_COUNT_RANGE_8_TO_16</metrics>
				<metrics>WRITE_RT_COUNT_RANGE_16_TO_32</metrics>
				<metrics>PORT_1_UTILIZATION</metrics>
				<metrics>AVG_WRITE_RT_0_TO_1</metrics>
				<metrics>PORT_0_MBYTES_READ_PER_SEC</metrics>
				<metrics>WRITE_RT_COUNT_RANGE_2_TO_4</metrics>
				<metrics>PERCENT_WRITE</metrics>
				<metrics>TOTAL_READ_COUNT</metrics>
				<metrics>AVG_READ_RT_2_TO_4</metrics>
				<metrics>WRITE_RT_COUNT_RANGE_8_TO_16</metrics>
				<metrics>RESPONSE_TIME_WRITE</metrics>
				<metrics>RESPONSE_TIME_READ</metrics>
				<metrics>WRITE_HIT_PER_SEC</metrics>
				<metrics>WRITE_RT_COUNT_RANGE_32_TO_64</metrics>
				<metrics>READ_RT_COUNT_RANGE_0_TO_1</metrics>
				<metrics>TOTAL_WRITE_COUNT</metrics>
				<metrics>AVG_WRITE_RT_1_TO_2</metrics>
				<metrics>QUEUE_DEPTH_COUNT_RANGE_9</metrics>
				<metrics>QUEUE_DEPTH_COUNT_RANGE_8</metrics>
				<metrics>QUEUE_DEPTH_COUNT_RANGE_7</metrics>
				<metrics>QUEUE_DEPTH_COUNT_RANGE_6</metrics>
				<metrics>QUEUE_DEPTH_COUNT_RANGE_5</metrics>
				<metrics>QUEUE_DEPTH_COUNT_RANGE_4</metrics>
				<metrics>QUEUE_DEPTH_COUNT_RANGE_3</metrics>
				<metrics>QUEUE_DEPTH_COUNT_RANGE_2</metrics>
				<metrics>QUEUE_DEPTH_COUNT_RANGE_1</metrics>
				<metrics>QUEUE_DEPTH_COUNT_RANGE_0</metrics>
				<metrics>AVG_READ_RT_8_TO_16</metrics>
				<metrics>PORT_1_SPEED_GBITS_PER_SEC</metrics>
				<metrics>PERCENT_READ</metrics>
				<metrics>MISS_PER_SEC</metrics>
				<metrics>PERCENT_IDLE</metrics>
				<metrics>READ_RT_COUNT_RANGE_1_TO_2</metrics>
				<metrics>PERCENT_WRITE_HIT</metrics>
				<metrics>AVG_WRITE_RT_2_TO_4</metrics>
				<metrics>AVG_WRITE_RT_16_TO_32</metrics>
				<metrics>WRITE_RT_COUNT_RANGE_4_TO_8</metrics>
				<metrics>PERCENT_HIT</metrics>
				<metrics>AVG_READ_RT_4_TO_8</metrics>
				<metrics>SLOT_COLLISION_PER_SEC</metrics>
				<metrics>READ_RT_COUNT_RANGE_2_TO_4</metrics>
				<metrics>AVG_WRITE_RT_32_TO_64</metrics>
				<metrics>AVG_WRITE_RT_OVER_64</metrics>
				<metrics>PORT_0_SPEED_GBITS_PER_SEC</metrics>
				<metrics>AVG_QUEUE_DEPTH_RANGE_9</metrics>
				<metrics>AVG_QUEUE_DEPTH_RANGE_8</metrics>
				<metrics>AVG_QUEUE_DEPTH_RANGE_7</metrics>
				<metrics>AVG_QUEUE_DEPTH_RANGE_6</metrics>
				<metrics>AVG_QUEUE_DEPTH_RANGE_5</metrics>
				<metrics>PORT_0_MB_PER_SEC</metrics>
				<metrics>QUOTA_AVG_DELAYED_TIME</metrics>
				<metrics>QUOTA_DELAYED_IOS</metrics>
				<metrics>QUOTA_DELAYED_TIME</metrics>
				<metrics>QUOTA_IO_RATE</metrics>
				<metrics>QUOTA_MB_RATE</metrics>
				<metrics>QUOTA_PERCENT_DELAYED_IOS</metrics>
--]
			</feDirectorParam>
		</xsl:result-document>
	</xsl:template>
</xsl:stylesheet>