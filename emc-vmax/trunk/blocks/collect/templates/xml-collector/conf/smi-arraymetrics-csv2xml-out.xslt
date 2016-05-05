<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" name="xml" />
    <xsl:param name="request"/>
    <xsl:variable name="outputPath" select="'tmp/smi-arraymetricsout/'"/>
    <xsl:variable name="outputFilename" select="concat( $outputPath, 'array-', string(number(current-dateTime())), '.out.xml' )"/>
    
    <xsl:template match="/CIM/MESSAGE/SIMPLERSP/METHODRESPONSE/PARAMVALUE/VALUE.ARRAY/VALUE">
        <xsl:result-document href="{$outputFilename}" format="xml">
            <STATS>
                    <STAT>
                        <Array>
                            <xsl:value-of select="substring-after(substring-before(.,'+Array'),'SYMM+')"/>
                        </Array>

                        <!-- Array performance metrics
                             InstanceID, 1
                             ElementType, 2
                             StatisticTime, 3
                             TotalIOs, 4
                             KBytesTransferred, 5 
                             ReadIOs, 6
                             ReadHitIOs, 7 
                             KBytesRead, 8
                             WriteIOs, 9
                             WriteHitIOs,10 
                             KBytesWritten, 11 
                             EMCTotalHitIOs, 12
                             EMCWriteKBytesFlushed, 13 
                             EMCMaxKBPendingFlush, 14
                             EMCDeferredWriteIOs, 15
                             EMCDelayedDFWIOs, 16
                             EMCKBPendingFormat, 17
                             EMCKBPendingFlush, 18
                             EMCKBPrefetched, 19
                             EMCNumFreePermacacheSlots, 20 
                             EMCNumUsedPermacacheSlots, 21
                             EMCSequentialReadIOs, 22
                             EMCLRUTotalIOs, 23
                             EMCLRUReadIOs, 24
                             EMCLRUWriteIOs, 25
                             EMCLRUTotalHitIOs, 26 
                             EMCLRULocks 27 -->
                        <InstanceID>
                            <xsl:value-of select="tokenize(., ';')[1]"/>
                        </InstanceID>
                        <ElementType>
                            <xsl:value-of select="tokenize(., ';')[2]"/>
                        </ElementType>
                        <StatisticTime>
                            <xsl:value-of select="tokenize(., ';')[3]"/>
                        </StatisticTime> 
                        <TotalIOs>
                            <xsl:value-of select="tokenize(., ';')[4]"/>
                        </TotalIOs>
                        <KBytesTransferred>
                            <xsl:value-of select="tokenize(., ';')[5]"/>
                        </KBytesTransferred>
                        <ReadIOs>
                            <xsl:value-of select="tokenize(., ';')[6]"/>
                        </ReadIOs>
                        <ReadHitIOs>
                            <xsl:value-of select="tokenize(., ';')[7]"/>
                        </ReadHitIOs>
                        <KBytesRead>
                            <xsl:value-of select="tokenize(., ';')[8]"/>
                        </KBytesRead>
                        <WriteIOs>
                            <xsl:value-of select="tokenize(., ';')[9]"/>
                        </WriteIOs>
                        <WriteHitIOs>
                            <xsl:value-of select="tokenize(., ';')[10]"/>
                        </WriteHitIOs>
                        <KBytesWritten>
                            <xsl:value-of select="tokenize(., ';')[11]"/>
                        </KBytesWritten>
                        <EMCTotalHitIOs>
                            <xsl:value-of select="tokenize(., ';')[12]"/>
                        </EMCTotalHitIOs>
                        <EMCWriteKBytesFlushed>
                            <xsl:value-of select="tokenize(., ';')[13]"/>
                        </EMCWriteKBytesFlushed>
                        <EMCMaxKBPendingFlush>
                            <xsl:value-of select="tokenize(., ';')[14]"/>
                        </EMCMaxKBPendingFlush>
                        <EMCDeferredWriteIOs>
                            <xsl:value-of select="tokenize(., ';')[15]"/>
                        </EMCDeferredWriteIOs>
                        <EMCDelayedDFWIOs>
                            <xsl:value-of select="tokenize(., ';')[16]"/>
                        </EMCDelayedDFWIOs>
                        <EMCKBPendingFormat>
                            <xsl:value-of select="tokenize(., ';')[17]"/>
                        </EMCKBPendingFormat>
                        <EMCKBPendingFlush>
                            <xsl:value-of select="tokenize(., ';')[18]"/>
                        </EMCKBPendingFlush>
                        <EMCKBPrefetched>
                            <xsl:value-of select="tokenize(., ';')[19]"/>
                        </EMCKBPrefetched>
                        <EMCNumFreePermacacheSlots>
                            <xsl:value-of select="tokenize(., ';')[20]"/>
                        </EMCNumFreePermacacheSlots>
                        <EMCNumUsedPermacacheSlots>
                            <xsl:value-of select="tokenize(., ';')[21]"/>
                        </EMCNumUsedPermacacheSlots>
                        <EMCSequentialReadIOs>
                            <xsl:value-of select="tokenize(., ';')[22]"/>
                        </EMCSequentialReadIOs>
                        <EMCLRUTotalIOs>
                            <xsl:value-of select="tokenize(., ';')[23]"/>
                        </EMCLRUTotalIOs>
                        <EMCLRUReadIOs>
                            <xsl:value-of select="tokenize(., ';')[24]"/>
                        </EMCLRUReadIOs>
                        <EMCLRUWriteIOs>
                            <xsl:value-of select="tokenize(., ';')[25]"/>
                        </EMCLRUWriteIOs>
                        <EMCLRUTotalHitIOs>
                            <xsl:value-of select="tokenize(., ';')[26]"/>
                        </EMCLRUTotalHitIOs>
                        <EMCLRULocks>
                            <xsl:value-of select="tokenize(., ';')[27]"/>
                        </EMCLRULocks>
                    </STAT>
            </STATS>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="text()|@*">
        <xsl:apply-templates />
    </xsl:template>
</xsl:stylesheet>
