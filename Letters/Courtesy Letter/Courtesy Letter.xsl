<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />

  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="generalStyle" />
      </head>
      <body>
        <xsl:attribute name="style">
          <xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
        </xsl:attribute>

        <xsl:call-template name="head" /><!-- header.xsl -->
        <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

        <br />
        <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->


        <div class="messageArea">
          <div class="messageBody">
            
            <!-- AFN CODE -->
            <xsl:choose>                        
                <!-- AFN test (is_afn_patron) defined in footer.xsl -->
                <xsl:when test="(string-length($is_afn_patron) > 0)">   
                    <!-- handle AFN supported languages (is_preferred_lang_fr) defined in footer.xsl-->
                    <xsl:choose>
                        <xsl:when test="(string-length($is_preferred_lang_fr) > 0)">
                            <!-- handle AFN default language fr -->
                            <table cellspacing="0" cellpadding="5" border="0">
                                <tr>
                                    <td>
                                        <!-- AFN VERSION 1.6 changed some french text -->
                                        Le(s) document(s) suivant(s) de <xsl:value-of select="notification_data/item_loans/item_loan/library_name"/> arrive(nt) à échéance. Veuillez retourner le(s) document(s) à votre bibliothèque, ou pour un renouvellement:
                                    </td>
                                </tr>

                                <tr>                                    
                                    <td>
                                        <!-- use a template from footer.xml with AFN conditional link logic. displays as 1. LINK  -->
                                        <xsl:call-template name="AFNVisitLoansLink" />
                                    </td>
                                </tr>                               
                            
                                <tr>
                                    <td>
                                        <!-- AFN VERSION 1.6 changed some french text -->
                                        2. Cliquez sur <xsl:value-of select="notification_data/item_loans/item_loan/library_name"/> à la gauche et renouvelez le(s).
                                    </td>
                                </tr>                                                               
                            
                                <tr>
                                    <td>
                                        <table cellpadding="5" class="listing">
                                            <xsl:attribute name="style">
                                                <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
                                            </xsl:attribute>
                                            <tr>
                                                <!-- AFN OFFICIAL TRANSLATION COMING AFN-TRANSLATE -->
                                                <!--
                                                <th>Title</th>
                                                <th>Description</th>
                                                <th>Author</th>
                                                <th>Due Date</th>
                                                <th>Library</th>
                                                -->
                                                <th>Titre</th>
                                                <!-- AFN VERSION 1.6 changed some french text -->
                                                <th>Description</th>
                                                <th>Auteur</th>
                                                <!-- AFN VERSION 1.6 changed some french text -->
                                                <th>Date de retour</th>
                                                <th>Bibliothèque</th>
                                            </tr>

                                            <xsl:for-each select="notification_data/item_loans/item_loan">
                                            <tr>
                                                <td><xsl:value-of select="title"/></td>
                                                <td><xsl:value-of select="description"/></td>
                                                <td><xsl:value-of select="author"/></td>
                                                <td><xsl:value-of select="due_date"/></td>
                                                <td><xsl:value-of select="library_name"/></td>

                                            </tr>
                                            </xsl:for-each>

                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </xsl:when> 
                        <xsl:otherwise>                                                     
                            <!-- handle AFN default language en -->
                            <table cellspacing="0" cellpadding="5" border="0">                              
                                <tr>
                                    <td>                                        
                                        The following item(s) from <xsl:value-of select="notification_data/item_loans/item_loan/library_name"/> are coming due. Please return the item(s) to your library, or, to renew them:                                       
                                    </td>
                                </tr>

                                <tr>                                    
                                    <td>
                                        <!-- use a template from footer.xml with AFN conditional link logic. displays as 1. LINK  -->
                                        <xsl:call-template name="AFNVisitLoansLink" />
                                    </td>
                                </tr>                               
                            
                                <tr>
                                    <td>                                        
                                        2. Click the <xsl:value-of select="notification_data/item_loans/item_loan/library_name"/> option along the left and renew items
                                    </td>
                                </tr>                               

                                <tr>
                                    <td>
                                        <table cellpadding="5" class="listing">
                                            <xsl:attribute name="style">
                                                <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
                                            </xsl:attribute>
                                            <tr>
                                                <th>Title</th>
                                                <th>Description</th>
                                                <th>Author</th>
                                                <th>Due Date</th>
                                                <th>Library</th>
                                            </tr>

                                            <xsl:for-each select="notification_data/item_loans/item_loan">
                                            <tr>
                                                <td><xsl:value-of select="title"/></td>
                                                <td><xsl:value-of select="description"/></td>
                                                <td><xsl:value-of select="author"/></td>
                                                <td><xsl:value-of select="due_date"/></td>
                                                <td><xsl:value-of select="library_name"/></td>

                                            </tr>
                                            </xsl:for-each>

                                        </table>
                                    </td>
                                </tr>
                            </table>

                        </xsl:otherwise>
                    </xsl:choose>                                                                                                                   
                </xsl:when>
                <xsl:otherwise>         
                    <!-- AFN TODO -->
                    <!-- handle local institution on hold (ie. PUT YOUR EXISTING HOLD LETTER INFO HERE between the xsl:otherwise tag)-->                        
                    <table cellspacing="0" cellpadding="5" border="0">
                    <tr>
                        <td>
                            
                            <!-- short_loans_msg is: The following item(s) are coming due. Please return the item(s) to your home library or renew them online at -->                           
                            <b>@@short_loans_message@@ <a href="https://ocul-yor.primo.exlibrisgroup.com/discovery/account?vid=01OCUL_YOR:YOR_DEFAULT">your account</a></b>
                            <br/><br/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>@@loans@@</b>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <table cellpadding="5" class="listing">
                                <xsl:attribute name="style">
                                    <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
                                </xsl:attribute>
                                <tr>
                                    <th>@@title@@</th>
                                    <th>@@description@@</th>
                                    <th>@@author@@</th>
                                    <th>@@due_date@@</th>
                                    <th>@@library@@</th>
                                </tr>

                                <xsl:for-each select="notification_data/item_loans/item_loan">
                                <tr>
                                    <td><xsl:value-of select="title"/></td>
                                    <td><xsl:value-of select="description"/></td>
                                    <td><xsl:value-of select="author"/></td>
                                    <td><xsl:value-of select="due_date"/></td>
                                    <td><xsl:value-of select="library_name"/></td>

                                </tr>
                                </xsl:for-each>

                            </table>
                        </td>
                    </tr>
                    </table>
                    
                    <!-- END OF AFN TODO -->
                </xsl:otherwise>
            </xsl:choose>           
            <!-- END OF AFN CODE -->
            
          </div>
        </div>

        <!-- AFN TODO -->       
        <xsl:call-template name="AFNLastFooter" /> 
        <xsl:call-template name="AFNAccount" />
        <!-- END OF AFN TODO -->                    
        
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
