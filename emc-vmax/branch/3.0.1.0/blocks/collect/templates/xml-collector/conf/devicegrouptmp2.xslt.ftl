[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/mobile" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" name="xml"/>
	<xsl:param name="request"/>
	<xsl:template match="/">
		<xsl:for-each select="//ns2:deviceGroupId">
			<xsl:call-template name="w4n.makeRequests.bysymmetrixId">
				<xsl:with-param name="device" select="$request//ns2:symmetrixId"/>
				<xsl:with-param name="devicegroup" select="node()"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="w4n.makeRequests.bysymmetrixId">
		<xsl:param name="device"/>
		<xsl:param name="devicegroup"/>
		<xsl:variable name="filePath" select="'tmp/devicegrouptmp2/'"/>
		<xsl:variable name="requestFilename" select="concat($filePath, $device, $devicegroup, '.metrics.xml')"/>
		<xsl:variable name="epoch" select="current-dateTime() - xs:dateTime('1970-01-01T00:00:00+00:00')" />
[#if emcvmax??]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - ${emcvmax.perf.pollingperiod})" />
[#else]
		<xsl:variable name="startdate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch) - 3600)" />
[/#if]
		<xsl:variable name="enddate" select="floor(days-from-duration($epoch) * 3600 * 24 + hours-from-duration($epoch) * 3600 + minutes-from-duration($epoch) * 60 + seconds-from-duration($epoch))" />
		<xsl:result-document href="{$requestFilename}" format="xml">
			<deviceGroupParam xmlns:ns2="http://www.emc.com/em/2012/07/univmax/restapi/common" xmlns="http://www.emc.com/em/2012/07/univmax/restapi/performance" xmlns:ns3="http://www.emc.com/em/2012/07/univmax/restapi/config">
				<startDate>
					<xsl:copy-of select="$startdate"/>000</startDate>
				<endDate>
					<xsl:copy-of select="$enddate"/>000</endDate>
				<ns2:symmetrixId>
					<xsl:value-of select="$device"/>
				</ns2:symmetrixId>
				<ns2:deviceGroupId>
					<xsl:value-of select="$devicegroup"/>
				</ns2:deviceGroupId>
				<metrics>AVG_BE_DISK_TIME</metrics>
				<metrics>AVG_BE_REQ_TIME</metrics>
				<metrics>AVG_BE_TASK_TIME</metrics>
				<metrics>AVG_IO_SIZE_KB</metrics>  
				<metrics>AVG_READ_SIZE</metrics>
				<metrics>AVG_WRITE_SIZE</metrics>
				<metrics>BE_MB_READ_RATE</metrics>
				<metrics>BE_MB_TRANSFERED_PER_SEC</metrics>
				<metrics>BE_MB_WRITE_RATE</metrics>
				<metrics>BE_PERCENT_READ</metrics>  
				<metrics>BE_PERFETCHED_TRACK_PER_SEC</metrics>
				<metrics>BE_PERFETCHED_TRACK_USED_PER_SEC</metrics>
				<metrics>BE_PERCENT_WRITE</metrics>
				<metrics>BE_READS</metrics> 
				<metrics>BE_WRITES</metrics>             
				<metrics>HA_MB_PER_SEC</metrics> 
				<metrics>IO_DENSITY</metrics> 
				<metrics>IO_RATE</metrics>      
				<metrics>MAX_WRITE_PENDING_THRLD</metrics>  
				<metrics>MB_READ_PER_SEC</metrics>   
				<metrics>MB_WRITE_PER_SEC</metrics>   
				<metrics>PERCENT_HIT</metrics>     
				<metrics>PERCENT_MISS</metrics>         
				<metrics>PERCENT_RANDOM_IO</metrics>
				<metrics>PERCENT_RANDOM_WRITES</metrics>
				<metrics>PERCENT_RANDOM_READ_HIT</metrics>
				<metrics>PERCENT_RANDOM_READ_MISS</metrics>
				<metrics>PERCENT_RANDOM_READS</metrics> 
				<metrics>PERCENT_RANDOM_WRITE_HIT</metrics>
				<metrics>PERCENT_RANDOM_WRITE_MISS</metrics>
				<metrics>PERCENT_READ</metrics> 
				<metrics>PERCENT_READ_HIT</metrics>
				<metrics>PERCENT_READ_MISS</metrics> 
				<metrics>PERCENT_SEQ_READ_HIT</metrics>
				<metrics>PERCENT_SEQ_READ_MISS</metrics>     
				<metrics>PERCENT_SEQ_READS</metrics>
				<metrics>PERCENT_SEQ_WRITE_MISS</metrics> 
				<metrics>PERCENT_SEQ_WRITE_HIT</metrics> 
				<metrics>PERCENT_SEQ_WRITES</metrics>
				<metrics>PERCENT_WRITE</metrics>
				<metrics>PERCENT_WRITE_HIT</metrics>
				<metrics>PERCENT_WRITE_MISS</metrics>          
				<metrics>PREFETCHED_TRACK_MB_PER_SEC</metrics>
				<metrics>RANDOM_IO_PER_SEC</metrics>
				<metrics>RANDOM_READ_HIT_PER_SEC</metrics>
				<metrics>RANDOM_READ_MISS_PER_SEC</metrics>
				<metrics>RANDOM_READ_PER_SEC</metrics>
				<metrics>RANDOM_WRITE_HIT_PER_SEC</metrics>
				<metrics>RANDOM_WRITE_MISS_PER_SEC</metrics>
				<metrics>RANDOM_WRITE_PER_SEC</metrics>
				<metrics>READ_HIT_PER_SEC</metrics>
				<metrics>READ_MISS_PER_SEC</metrics>
				<metrics>READS</metrics>
				<metrics>RESPONSE_TIME</metrics>
				<metrics>SAMPLED_AVG_READ_MISS_TIME</metrics>
				<metrics>SAMPLED_AVG_RDF_WRITE_TIME</metrics>
				<metrics>SAMPLED_AVG_READ_TIME</metrics>
				<metrics>SAMPLED_AVG_WP_DISCONNECT_TIME</metrics>
				<metrics>SAMPLED_AVG_WRITE_TIME</metrics>
				<metrics>SEQ_READ_HIT_PER_SEC</metrics>
				<metrics>SEQ_READ_MISS_PER_SEC</metrics>
				<metrics>SEQ_READ_PER_SEC</metrics> 
				<metrics>SEQ_WRITE_HIT_PER_SEC</metrics>
				<metrics>SEQ_WRITE_MISS_PER_SEC</metrics>
				<metrics>SEQ_WRITE_PER_SEC</metrics>
				<metrics>WRITE_MISS_PER_SEC</metrics>
				<metrics>WRITE_HIT_PER_SEC</metrics>
				<metrics>TOTAL_MISS_PER_SEC</metrics>
				<metrics>TOTAL_HIT_PER_SEC</metrics>
				<metrics>TOTAL_BE_REQ_PER_SEC</metrics>
				<metrics>TOTAL_SEQ_IO_PER_SEC</metrics>
				<metrics>WP</metrics>
				<metrics>WRITES</metrics>
			</deviceGroupParam>
		</xsl:result-document>
	</xsl:template>
</xsl:stylesheet>