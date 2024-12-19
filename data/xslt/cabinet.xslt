<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://univ-grenoble-alpes/fr/l3miage/medical">
    <!-- Variable pour charger les actes depuis le fichier actes.xml -->

    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:variable name="Intervenant" select="'001'"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Liste des visites</title>
                <link rel="stylesheet" href="../css/cabinet.css"/>
            </head>
            <body>
                <h1>CONSULTATION DU JOUR</h1>
                <p> <xsl:value-of select="concat('Bonjour ', 
                    xs:cabinet/xs:infirmiers/xs:infirmier[@id=$Intervenant]/xs:prenom)"/>
                    , aujourd'hui vous avez
                    <xsl:value-of select="count(xs:cabinet/xs:patients/xs:patient/xs:visite[@intervenant=$Intervenant])"/> patients. </p>
                <p>Voici la liste des visites prévues aujourd’hui :</p>

                <table>
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Adresse</th>
                        <th>Soins à effectuer</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Liste des patients triés par ordre de visite -->
                    <xsl:for-each select="xs:cabinet/xs:patients/xs:patient[xs:visite]">
                        <!-- Trier les patients par date de visite -->
                        <xsl:sort select="xs:visite/@date" order="ascending" data-type="text"/>

                        <tr>
                            <!-- Nom du patient -->
                            <td><xsl:value-of select="xs:nom"/></td>

                            <!-- Prénom du patient -->
                            <td><xsl:value-of select="xs:prenom"/></td>

                            <!-- Adresse du patient -->
                            <td>
                                <xsl:value-of select="concat(xs:adresse/xs:numéro, ' ', xs:adresse/xs:rue)"/>
                                <br/>
                                <xsl:value-of select="xs:adresse/xs:codepostal"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="xs:adresse/xs:ville"/>
                            </td>

                            <!-- Liste des soins à effectuer -->
                            <td>
                                <xsl:for-each select="xs:visite/xs:acte">
                                    <div>
                                        <!-- Récupération du libellé de l'acte correspondant -->
                                        
                                    </div>
                                </xsl:for-each>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
                </table>
                <xsl:for-each select="xs:visite/xs:soin">
                             <!--   <li>
                                    <!- Récupération du libellé de l'acte correspondant -
                                    <xsl:value-of select="$actes[@code=current()/@code]/act:libelle"/>
                                </li> -->
                            </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
