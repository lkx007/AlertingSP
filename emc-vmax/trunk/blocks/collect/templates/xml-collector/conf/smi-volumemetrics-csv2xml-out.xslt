<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" name="xml" />
    <xsl:param name="request"/>
    
    <xsl:variable name="outputPath" select="'tmp/smi-volumemetricsout/'"/>
    <xsl:variable name="outputFilename" select="concat( $outputPath, 'volumes-', generate-id(), '.out.xml' )"/>
    
    <xsl:template match="/CIM/MESSAGE/SIMPLERSP/METHODRESPONSE/PARAMVALUE/VALUE.ARRAY/VALUE">
        <xsl:result-document href="{$outputFilename}" format="xml">
            <STATS>
                <!-- Volume statistics
                    InstanceID, 1
                    ElementType, 2
                    StatisticTime, 3
                    TotalIOs, 4 
                    KBytesTransferred, 5
                    ReadIOs, 6
                    ReadHitIOs, 7
                    KBytesRead, 8
                    WriteIOs, 9
                    WriteHitIOs, 10
                    KBytesWritten, 11
                    EMCTotalHitIOs, 12
                    EMCMaxKBPendingFlush, 13
                    EMCKBPendingFlush, 14
                    EMCSequentialReadHitIOs, 15
                    EMCSequentialWriteHitIOs, 16
                    EMCSequentialReadIOs, 17
                    EMCSequentialWriteIOs, 18
                    EMCDAReadIOs, 19
                    EMCDAWriteIOs, 20
                    EMCKBDAPrefetched, 21
                    EMCKBDAPrefetchedUsed, 22
                    EMCKBDARead, 23
                    EMCKBDAWrite, 24
                    EMCSampledReadsTime, 25
                    EMCSampledWritesTime, 26
                    EMCSampledReads, 27
                    EMCSampledWrites, 28
                    EMCHostCacheTime, 29
                    EMCHostCacheReadHits, 30
                    EMCHostCacheWriteHits, 31
                    EMCHostCacheReadsReceived, 32
                    EMCHostCacheWritesReceived, 33
                    EMCHostCacheSkippedIOs, 34
                    EMCHostCacheDedupHits, 35
                    EMCHostCacheDedupReadsReceived, 36
                    EMCHostCacheDedupWritesReceived, 37
                    EMCHostCacheKbytesTrfdRead, 38
                    EMCHostCacheKbytesTrfdWrite, 39
                    EMCHostCacheTotalReadResponsetime, 40
                    EMCHostCacheTotalWriteResponsetime 41
                 -->
            <xsl:for-each select="tokenize(., '\n+')">
                <xsl:if test=". != ''">
                    <STAT>
                        <Array>
                            <xsl:value-of select="substring-after(substring-before(., '+Volume'), 'SYMM+')"/>
                        </Array>
                        <Volume>
                            <xsl:value-of select="substring-after(tokenize(., ';')[1], 'Volume+')"/>
                        </Volume>
                        <StatisticTime>
                            <xsl:value-of select="tokenize(., ';')[3]"/>
                        </StatisticTime>
                        <ReadIOs>
                            <xsl:value-of select="tokenize(., ';')[6]"/>
                        </ReadIOs>
                        <KBytesRead>
                            <xsl:value-of select="tokenize(., ';')[8]"/>
                        </KBytesRead>
                        <WriteIOs>
                            <xsl:value-of select="tokenize(., ';')[9]"/>
                        </WriteIOs>
                        <KBytesWritten>
                            <xsl:value-of select="tokenize(., ';')[11]"/>
                        </KBytesWritten>
                        <EMCSequentialReadIOs>
                            <xsl:value-of select="tokenize(., ';')[17]"/>
                        </EMCSequentialReadIOs>
                        <EMCSequentialWriteIOs>
                            <xsl:value-of select="tokenize(., ';')[18]"/>
                        </EMCSequentialWriteIOs>
                        <EMCSampledReadsTime>
                            <xsl:value-of select="tokenize(., ';')[25]"/>
                        </EMCSampledReadsTime>
                        <EMCSampledWritesTime>
                            <xsl:value-of select="tokenize(., ';')[26]"/>
                        </EMCSampledWritesTime>
                        <EMCSampledReads>
                            <xsl:value-of select="tokenize(., ';')[27]"/>
                        </EMCSampledReads>
                        <EMCSampledWrites>
                            <xsl:value-of select="tokenize(., ';')[28]"/>
                        </EMCSampledWrites>
                        <CSV>
                            <xsl:value-of select="."/>
                        </CSV>
                    </STAT>
                </xsl:if>
            </xsl:for-each>
            </STATS>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="text()|@*">
        <xsl:apply-templates />
    </xsl:template>
</xsl:stylesheet>
