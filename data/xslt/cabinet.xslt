<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://univ-grenoble-alpes/fr/l3miage/medical">

    <!-- Variable pour charger les actes depuis le fichier actes.xml -->
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <xsl:variable name="actes" select="document('../xml/acte.xml')"/>
    <xsl:variable name="Intervenant" select="'001'"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Liste des visites</title>
                <link rel="stylesheet" href="../css/cabinet.css"/>
                <script type="text/javascript" src="../js/facture.js"></script>
            </head>
            <body>
                <!-- En-tête de la page -->
                <header>
                    <h1>CONSULTATION DU JOUR (Fiche Infirmier)</h1>
                    <p>
                        Bonjour
                        <strong>
                            <xsl:value-of select="xs:cabinet/xs:infirmiers/xs:infirmier[@id=$Intervenant]/xs:prenom"/>
                        </strong>,
                        aujourd'hui vous avez
                        <strong>
                            <xsl:value-of select="count(xs:cabinet/xs:patients/xs:patient/xs:visite[@intervenant=$Intervenant])"/>
                        </strong> patients.
                    </p>
                    <!-- Image de l'infirmier -->
                    <div class="header-photo">
                        <xsl:if test="xs:cabinet/xs:infirmiers/xs:infirmier[@id=$Intervenant]/xs:photo">
                            <img src="{xs:cabinet/xs:infirmiers/xs:infirmier[@id=$Intervenant]/xs:photo}" alt="Photo de l'infirmier"/>
                        </xsl:if>
                    </div>
                </header>

                <p>Voici la liste des visites prévues :</p>
                <table>
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Adresse</th>
                            <th>Date de la visite</th>
                            <th>Soins à effectuer</th>
                            <th>Facture</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="xs:cabinet/xs:patients/xs:patient[xs:visite[@intervenant=$Intervenant]]">
                            <!-- Trier les patients par date de visite -->
                            <xsl:sort select="xs:visite/@date" order="ascending" data-type="text"/>
                            <tr>
                                <!-- Nom du patient -->
                                <td><xsl:value-of select="xs:nom"/></td>

                                <!-- Prénom du patient -->
                                <td><xsl:value-of select="xs:prenom"/></td>

                                <!-- Adresse du patient -->
                                <td>
                                    <xsl:if test="xs:adresse/xs:numéro">
                                        <xsl:value-of select="concat(xs:adresse/xs:numéro, ' ', xs:adresse/xs:rue)"/>
                                        <br/>
                                    </xsl:if>
                                    <xsl:value-of select="xs:adresse/xs:codepostal"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="xs:adresse/xs:ville"/>
                                </td>

                                <!-- Date de la visite -->
                                <td>
                                    <xsl:value-of select="xs:visite/@date"/>
                                </td>

                                <!-- Liste des soins à effectuer -->
                                <td>
                                    <xsl:for-each select="xs:visite/xs:acte">
                                        <xsl:variable name="acteDescription" select="$actes//acte[@id=current()/@id]"/>
                                        <xsl:if test="$acteDescription">
                                            • <xsl:value-of select="$acteDescription/text()"/>
                                            <br/>
                                        </xsl:if>
                                    </xsl:for-each>
                                </td>

                                <!-- Bouton pour facture -->
                                <td>
                                    <xsl:element name="button">
                                        <xsl:attribute name="onclick">
                                            <xsl:value-of select="concat('openFacture(', xs:prenom, ', ', xs:nom, ', ', 
                                                 concat(xs:visite/xs:acte, ' '), ')')"/>
                                        </xsl:attribute>
                                        Facture
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
