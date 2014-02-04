<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:prd="http://www.aspnl.com/xmlns/products"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:variable name="updatesDoc" select="document('updates.xml')"></xsl:variable>
    
    <xsl:template match="/">    
        <xsl:element namespace="xmlns:shop=http://www.aspnl.com/xmlns/shop" name="shop:basket">
            <xsl:namespace name="prd" select="'http://www.aspnl.com/xmlns/products'"></xsl:namespace>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="prd:product">
        <xsl:variable name="idProd" select="@prd:ID"/>
        <xsl:variable name="nUpdates" select="count($updatesDoc/*/*[@ID = $idProd])"/>
        <xsl:choose>
            <xsl:when test="$nUpdates &gt; 0">
                <xsl:choose>
                    <xsl:when test="count($updatesDoc/*/*[@ID = $idProd and name()='delete']) &gt; 0"/>
                    <xsl:when test="count($updatesDoc/*/*[@ID = $idProd and name()='update']) &gt; 0">
                        <xsl:copy>
                            <xsl:call-template name="prodAttr"/>
                            <xsl:attribute name="quantity">
                                <xsl:value-of select="$updatesDoc/*/*[@ID = $idProd and name()='update'][last()]/@quantity"></xsl:value-of>
                            </xsl:attribute>
                        </xsl:copy>
                    </xsl:when>
                    <xsl:when test="count($updatesDoc/*/*[@ID = $idProd and name()='add']) &gt; 0">
                        <xsl:copy>
                            <xsl:call-template name="prodAttr"/>
                            <xsl:attribute name="quantity">
                                <xsl:value-of select="count($updatesDoc/*/*[@ID = $idProd and name()='add'])"></xsl:value-of>
                            </xsl:attribute>
                        </xsl:copy> 
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!--<xsl:copy>
                    <xsl:call-template name="prodAttr"/>
                    <xsl:attribute name="quantity" select="0"/>
                </xsl:copy> -->      
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template> 
    
    <xsl:template name="prodAttr">
        <xsl:for-each select="@*">
            <xsl:copy/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="prd:products">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>