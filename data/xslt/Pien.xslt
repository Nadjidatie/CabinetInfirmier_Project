<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://univ-grenoble-alpes/fr/l3miage/medical"
                xmlns:ac="http://univ-grenoble-alpes.fr/l3miage/actes">

    <xsl:output method="html" indent="yes"/>
    <xsl:param name="patient" select="Pien"/>
    <xsl:variable name="patientDocs" select="document('../xml/Pien.xml', /)/patient"/>
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="//xs:patient/xs:nom"/></title>
                <link rel="stylesheet" href="../css/Pien.css"/>
            </head>
            <body>
                <header>
                    <h1>LISTE D'INFORMATION <xsl:value-of select="//xs:patient/xs:nom"/></h1>
                </header>
                <section id="identite">
                    <div>
                        <strong>Nom</strong> : <xsl:value-of select="$patientDocs/nom"/> <br/>
                        <strong>Prenom</strong> : <xsl:value-of select="$patientDocs/prenom"/> <br/>
                        <strong>Sexe</strong> : <xsl:value-of select="$patientDocs/patient/sexe"/> <br/>
                        <strong>Nom</strong> : <xsl:value-of select="$patientDocs/naissance"/> <br/>
                        <strong>NumeroSS</strong> : <xsl:value-of select="$patientDocs/numeroSS"/> <br/>
                    </div>
                </section>
                <section id="coordonnées">
                    <div>
                        <strong>Adresse</strong> : <xsl:value-of select="$patientDocs/adresse"/> <br/>
                    </div>
                </section>
                <section id="visite">
                    <div>
                        <strong>Date de Visite</strong> : <xsl:value-of select="$patientDocs/visite/@date"/> <br/>
                        <div>
                            <strong>Intervenant</strong> :  <xsl:value-of select="$patientDocs/intervenant"/> <br/>
                            <strong>Acte</strong> : <xsl:value-of select="$patientDocs/xs:acte"/> <br/>
                        </div>
                    </div>

                </section>

                <footer>

                </footer>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
