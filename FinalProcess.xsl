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
                    </xsl:element>
                    <xsl:call-template name="rowsOfProducts"/>
                </xsl:element>
                <xsl:element name="input">
                    <xsl:attribute name="type" select="'button'"></xsl:attribute>
                    Update Basket
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template name="rowsOfProducts">
        <xsl:for-each select="//prd:product">
            <xsl:element name="tr">
                <xsl:element name="td">
                    <xsl:element name="input">
                        <xsl:attribute name="value">
                            <xsl:value-of select="@quantity"/>
                        </xsl:attribute>
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
                    <xsl:element name="input">
                        <xsl:attribute name="type" select="'checkbox'"/>
                        <xsl:element name="br"/>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
