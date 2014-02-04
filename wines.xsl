<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:element name="html">
            <xsl:element name="head"/>
            <xsl:element name="body">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>        
    </xsl:template>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="wines">
        <xsl:param name="order" select="'ascending'"/>
        <xsl:param name="criteria" select="'country'"/>
        <xsl:element name="table">
            <xsl:element name="tr">
                <xsl:element name="th">
                    <xsl:text>name</xsl:text>
                </xsl:element>
                <xsl:for-each select="child::wine[1]/@*">
                    <xsl:element name="th">
                        <xsl:value-of select="name()"/>
                    </xsl:element>
                </xsl:for-each>    
            </xsl:element>
            <xsl:apply-templates>
                <xsl:sort select="attribute::*[name()=$criteria]" order="{$order}"/>    
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="wine">
        <xsl:element name="tr">
            <xsl:element name="td">
                <xsl:value-of select="."/>
            </xsl:element>
            <xsl:for-each select="@*">
                <xsl:element name="td">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>