<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://univ-grenoble-alpes/fr/l3miage/medical"
                xmlns:ac="http://univ-grenoble-alpes.fr/l3miage/actes">
    
    <xsl:output method="xml" indent="yes"/>

    <xsl:variable name="actes" select="document('../xml/acte.xml')"/>
    <xsl:param name="destinedName" select="'Pien'"/>

    <xsl:template match="/">
        <patient>
            <xsl:apply-templates select="//xs:patients/xs:patient[xs:nom = $destinedName]"/>
            <xsl:apply-templates select="//xs:patients/xs:patient/xs:adresse[../xs:nom = $destinedName]"/>
            <xsl:apply-templates select="//xs:patients/xs:patient/xs:visite[../xs:nom = $destinedName]"/>
        </patient>
    </xsl:template>


    <xsl:template match="xs:patient">
        <nom><xsl:value-of select="xs:nom"/></nom>
        <prenom><xsl:value-of select="xs:prenom"/></prenom>
        <sexe><xsl:value-of select="xs:sexe"/></sexe>
        <naissance><xsl:value-of select="xs:naissance"/></naissance>
        <numero><xsl:value-of select="xs:numero"/></numero>
    </xsl:template>

    <xsl:template match="xs:visite">
        <!-- la date de la visite -->
        <xsl:variable name="date" select="@date"/>

        <xsl:variable name="intervenant" select="@intervenant"/>

        <visite date="{$date}" 
            intervenant ="{$intervenant}">
            
            <!-- les actes associés à la visite -->
            <xsl:for-each select="xs:acte">
                <acte id="{@id}" type="{@type}" cle="{@cle}" coef="{@coef}">
                    <!-- le texte de l'acte depuis le fichier des actes -->
                    <xsl:value-of select="$actes/ac:acte[@id = current()/@id]/text()"/> <!-- ????????? -->
                </acte>
            </xsl:for-each>
        </visite>
    </xsl:template>

    <xsl:template match="xs:adresse">
        <adresse>
            <rue><xsl:value-of select="xs:rue"/></rue>
            <codePostal><xsl:value-of select="xs:codePostal"/></codePostal>
            <ville><xsl:value-of select="xs:ville"/></ville>
        </adresse>
    </xsl:template>
    

   <xsl:template match="ac:actes">
        <xsl:value-of select="ac:acte"/>
    </xsl:template> 

</xsl:stylesheet>