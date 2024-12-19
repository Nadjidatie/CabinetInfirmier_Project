<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://univ-grenoble-alpes/fr/l3miage/medical">

    <xsl:variable name="Intervenant" select="'001'"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Cabinet d'infirmière</title>
            </head>
            <body>
                <h1>CONSULTATION</h1>
                Bonjour <xsl:value-of select="//xs:infirmiers/xs:infirmier[@intervenant=$Intervenant]", aujourd'hui vous avez
                <xsl:value-of select="count(xs:cabinet/xs:patients/xs:patient/xs:visite[@intervenant=$Intervenant])"/> patients.
                <br/>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Sexe</th>
                            <th>Date de naissance</th>
                            <th>Numéro</th>
                            <th>Visite</th>
                            <th>Date de visite</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="xs:cabinet/xs:patients/xs:patient[xs:visite[@intervenant=$Intervenant]]">
                            <tr>
                                <td><xsl:value-of select="//xs:nom"/></td>
                                <td><xsl:value-of select="//xs:prenom"/></td>
                                <td><xsl:value-of select="//xs:sexe"/></td>
                                <td><xsl:value-of select="//xs:date_naissance"/></td>
                                <td><xsl:value-of select="//xs:numéro"/></td>
                                <td><xsl:value-of select="//xs:visite/@type"/></td>
                                <td><xsl:value-of select="//xs:visite/@date"/></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
                <button onclick="window.open('CabinetInfirmier/data/html/cv.html', '_blank');">FACTURES</button>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
