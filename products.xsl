<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:prd="http://www.aspnl.com/xmlns/products"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        <xsl:element name="html">
            <xsl:element name="head"/>
            <xsl:element name="body">
                <xsl:element name="H1"> Products</xsl:element>
                <xsl:apply-templates/>
                <xsl:element name="input">
                    <xsl:attribute name="type">button</xsl:attribute>
                    <xsl:attribute name="value">Show Basket</xsl:attribute>
                    <xsl:attribute name="onClick">showBasket()</xsl:attribute>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="prd:products">
        <xsl:element name="table">
            <xsl:element name="tr">
                <xsl:element name="th">ID</xsl:element>
                <xsl:element name="th">Description</xsl:element>
                <xsl:element name="th">Price</xsl:element>
                <xsl:element name="th"/>
            </xsl:element>
            <xsl:apply-templates/>
        </xsl:element>
        
    </xsl:template>
    
    <xsl:template match="prd:product">
        <xsl:element name="tr">
            <xsl:element name="td"><xsl:value-of select="@prd:ID"/></xsl:element>
            <xsl:element name="td"><xsl:value-of select="@prd:description"/></xsl:element>
            <xsl:element name="td"><xsl:value-of select="@prd:price"/></xsl:element>
            <xsl:element name="td">
                <xsl:element name="button">Add to Cart</xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>