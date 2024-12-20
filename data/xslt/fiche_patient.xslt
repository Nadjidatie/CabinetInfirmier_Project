<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://univ-grenoble-alpes/fr/l3miage/medical">
    
    <xsl:output method="xml" indent="yes"/>

    <xsl:variable name="actes" select="document('../xml/acte.xml')"/>
    <xsl:param name="destinedName" select="'Oscare'"/>

    <xsl:template match="/">
        <patient>
            <xsl:apply-templates select="//xs:patients/xs:patient[xs:prenom = $destinedName]"/>
            <xsl:apply-templates select="//xs:patients/xs:patient/xs:adresse[../xs:prenom = $destinedName]"/>
            <xsl:apply-templates select="//xs:patients/xs:patient/xs:visite[../xs:prenom = $destinedName]"/>
        </patient>
    </xsl:template>


    <xsl:template match="xs:patient">
        <nom><xsl:value-of select="xs:nom"/></nom>
        <prénom><xsl:value-of select="xs:prénom"/></prénom>
        <sexe><xsl:value-of select="xs:sexe"/></sexe>
        <naissance><xsl:value-of select="xs:naissance"/></naissance>
        <numéroSS><xsl:value-of select="xs:numéro"/></numéroSS>
    </xsl:template>

    <xsl:template match="xs:adresse">
        <adresse>
            <rue><xsl:value-of select="xs:rue"/></rue>
            <codePostal><xsl:value-of select="xs:codePostal"/></codePostal>
            <ville><xsl:value-of select="xs:ville"/></ville>
        </adresse>
    </xsl:template>

    <xsl:template match="xs:visite">
        <xsl:variable name="date" select="xs:date"/>
        <visite date="{$date}">
            <xsl:variable name="idIntervenant" select="xs:intervenant"/>
            <xsl:apply-templates select="//xs:infirmiers/xs:infirmier[@id = $idIntervenant]"/>
            <xsl:variable name="idActe" select="xs:acte/@id"/>
            <!-- <acte><xsl:apply-templates select="$actes/act:actes/act:acte[@id = $idActe]"/></acte> -->
        </visite>
    </xsl:template>

    <xsl:template match="xs:infirmier">
        <intervenant>
            <nom><xsl:value-of select="xs:nom"/></nom>
            <prénom><xsl:value-of select="xs:prénom"/></prénom>
        </intervenant>
    </xsl:template>

   <!--  <xsl:template match="act:actes">
        <xsl:value-of select="act:acte"/>
    </xsl:template> -->

</xsl:stylesheet>