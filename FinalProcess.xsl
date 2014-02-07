<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:prd="http://www.aspnl.com/xmlns/products"
    xmlns:shop="http://www.aspnl.com/xmlns/shop" exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="/">
        <xsl:element name="html">
            <xsl:element name="head"/>
            <xsl:element name="body">
                <xsl:element name="H1">Basket</xsl:element>
                <xsl:element name="table">
                    <xsl:element name="tr">
                        <xsl:element name="th">Quantity</xsl:element>
                        <xsl:element name="th">ID</xsl:element>
                        <xsl:element name="th">Price</xsl:element>
                        <xsl:element name="th">Product Total</xsl:element>
                        <xsl:element name="th">Delete</xsl:element>
                        <xsl:element name="th">Update</xsl:element>
                    </xsl:element>
                    <xsl:call-template name="rowsOfProducts"/>
                </xsl:element>
                <xsl:element name="div">
                    <xsl:element name="button">
                        <xsl:attribute name="onclick">selectBasket()</xsl:attribute>
                        Update Basket
                    </xsl:element>    
                </xsl:element>
                <xsl:element name="a">
                    <xsl:attribute name="href" select="'main.html'"></xsl:attribute>
                    See products
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template name="rowsOfProducts">
        <xsl:for-each select="//prd:product">
            <xsl:element name="tr">
                <xsl:element name="td">
                    <xsl:element name="input">
                        <xsl:attribute name="type" select="'text'"/>
                        <xsl:attribute name="value">
                            <xsl:value-of select="@quantity"/>
                        </xsl:attribute>
                        <xsl:attribute name="id"><xsl:value-of select="concat('input',@prd:ID)"/></xsl:attribute> 
                    </xsl:element>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:value-of select="@prd:price"/>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:value-of select="@prd:description"/>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:value-of select="number(@quantity)*number(@prd:price)"/>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:element name="button">
                        <xsl:attribute name="onclick">deleteProduct(<xsl:value-of select="@prd:ID"></xsl:value-of>)</xsl:attribute>
                        Delete
                    </xsl:element>  
                </xsl:element>
                <xsl:element name="td">
                    <xsl:element name="button">
                        <xsl:attribute name="onclick">updateProduct(<xsl:value-of select="@prd:ID"></xsl:value-of>)</xsl:attribute>
                        Update
                    </xsl:element>
                </xsl:element>
            </xsl:element>  
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
