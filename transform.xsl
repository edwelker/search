<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0" xml:space="default">
    
    <xsl:key name="y" match="resource" use="title"/>
    
    <xsl:template match="/">
        <menu>
            <categories>
                    <xsl:apply-templates select="//category"/>
            </categories>
            
            <xsl:variable name="x" select="//resource[not(parent::category/@url = primary-category)][title=following::title]/title"/>
            <xsl:variable name="num" select="count(//resource[generate-id(.)=generate-id(key('y', title)[1])])"/>
            <resources count="{$num}">
                <xsl:copy-of select="//resource[generate-id(.)=generate-id(key('y', title)[1])]"/>        
            </resources>
        </menu>
    </xsl:template>

    <xsl:template match='category'>
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*">
        <xsl:element name="{name()}">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="@name">
        <title>
            <xsl:value-of select="."/>
        </title>
    </xsl:template>
    
    
</xsl:stylesheet>
