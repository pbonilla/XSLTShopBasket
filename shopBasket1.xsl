<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:prd="http://www.aspnl.com/xmlns/products"
    exclude-result-prefixes="xs" version="2.0">

    <!--<xsl:variable name="productsDoc" xpath-default-namespace="http://www.aspnl.com/xmlns/products" select="document('products.xml')"/>-->

    <xsl:variable name="products" select="/*/prd:products"/>

    <xsl:template match="/">
            <xsl:element namespace="xmlns:shop=http://www.aspnl.com/xmlns/shop" name="shop:basket">
                <xsl:namespace name="prd" select="'http://www.aspnl.com/xmlns/products'"/>
                <xsl:apply-templates select="root"/>
            </xsl:element>
    </xsl:template>

    <xsl:template match="root">
        <xsl:apply-templates select="updates"/>
    </xsl:template>
    

    <xsl:template name="prodAttr">
        <xsl:for-each select="@*">
            <xsl:copy/>
        </xsl:for-each>
    </xsl:template>



    <xsl:template match="updates" name="test">     
        <xsl:param name="idProd">1</xsl:param>
        <xsl:variable name="prodCounter" select="count($products/prd:product)"/>
        <xsl:choose>
            <xsl:when test="$idProd &lt;= $prodCounter">
                <xsl:if test="count(child::*[@ID=$idProd])>0">
                    <xsl:choose>
                        <xsl:when test="child::*[@ID=$idProd and name()='delete']"/>
                        <xsl:when test="child::*[@ID=$idProd and name()='update'][last()]">
                            <xsl:variable name="quantity"
                                select="child::*[@ID=$idProd and name()='update'][1]/@quantity"/>
                            <xsl:apply-templates select="$products/*[@prd:ID = $idProd]">
                                <xsl:with-param name="quantity">
                                    <xsl:value-of select="$quantity"/>
                                </xsl:with-param>
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:when test="child::*[@ID=$idProd and name()='add']">
                            <xsl:variable name="quantity"
                                select="child::*[@ID=$idProd and name()='add'][1]/@quantity"/>
                            <xsl:apply-templates select="$products/*[@prd:ID = $idProd]">
                                <xsl:with-param name="quantity">
                                    <xsl:value-of select="$quantity"/>
                                </xsl:with-param>
                            </xsl:apply-templates>
                        </xsl:when>
                    </xsl:choose>
                </xsl:if>
                <xsl:call-template name="test">
                    <xsl:with-param name="idProd">
                        <xsl:value-of select="$idProd+1"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="prd:product">
        <xsl:param name="quantity">0</xsl:param>
        <xsl:copy>
            <xsl:call-template name="prodAttr"/>
            <xsl:attribute name="quantity">
                <xsl:value-of select="$quantity"/>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>
<!--
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>-->
</xsl:stylesheet>
