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
            <xsl:if test="notification_data/languages/string">
                <xsl:attribute name="lang">
                    <xsl:value-of select="notification_data/languages/string"/>
                </xsl:attribute>
            </xsl:if>

            <head>
                <title>
                    <xsl:value-of select="notification_data/general_data/subject"/>
                </title>

                <xsl:call-template name="generalStyle" />
            </head>
            <body>
                <xsl:attribute name="style">
                    <xsl:call-template name="bodyStyleCss" />
                    <!-- style.xsl -->
                </xsl:attribute>
                <xsl:call-template name="head" />
                <!-- header.xsl -->             

                <div class="messageArea">
                    <div class="messageBody">

                        <!-- AFN CODE -->                       
                        <xsl:choose>                                    
                            <!-- AFN test (is_afn_patron) defined in footer.xsl -->
                            <xsl:when test="(string-length($is_afn_patron) > 0)">                           
                                <!-- handle AFN supported languages (is_preferred_lang_fr) defined in footer.xsl-->
                                <xsl:choose>
                                    <xsl:when test="(string-length($is_preferred_lang_fr) > 0)">                                
                                        <!-- handle AFN default language en -->
                                        <table role='presentation'  cellspacing="0" cellpadding="5" border="0">
                                            <tr>
                                                <td>
                                                    <!-- AFN OFFICIAL TRANSLATION COMING AFN-TRANSLATE -->
                                                    <!-- Regarding your recent library request made on -->
                                                    Concernant votre récente demande de bibliothèque effectuée le <xsl:value-of select="notification_data/request/create_date" />
                                                </td>
                                            </tr>
                                        </table>                        
                                        <br />

                                        <table role='presentation'  cellspacing="0" cellpadding="5" border="0">

                                            <xsl:attribute name="style">
                                                <xsl:call-template name="listStyleCss" />
                                                <!-- style.xsl -->
                                            </xsl:attribute>
                                            
                                            <xsl:if test="notification_data/request/display/title !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Titre: </strong>
                                                        <xsl:value-of select="notification_data/request/display/title" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="notification_data/request/display/journal_title !=''">
                                                <tr>
                                                    <td>
                                                        <!-- AFN OFFICIAL TRANSLATION COMING AFN-TRANSLATE -->
                                                        <!-- Journal Title -->
                                                        <strong> Titre de revue: </strong>
                                                        <xsl:value-of
                                                            select="notification_data/request/display/journal_title" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="notification_data/request/display/author !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Auteur: </strong>
                                                        <xsl:value-of select="notification_data/request/display/author" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="notification_data/request/display/publication_date !=''">
                                                <tr>
                                                    <td>
                                                        <!-- AFN OFFICIAL TRANSLATION COMING AFN-TRANSLATE -->
                                                        <!-- Publication Date -->
                                                        <strong> Date de publication: </strong>
                                                        <xsl:value-of
                                                            select="notification_data/request/display/publication_date" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>                           
                                            <xsl:if test="notification_data/request/display/volume !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Volume: </strong>
                                                        <xsl:value-of select="notification_data/request/display/volume" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="notification_data/request/display/issue !=''">
                                                <tr>
                                                    <td>
                                                        <!-- AFN OFFICIAL TRANSLATION COMING AFN-TRANSLATE -->
                                                        <!-- Issue -->
                                                        <strong> Fascicule: </strong>
                                                        <xsl:value-of select="notification_data/request/display/issue" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>                                                       
                                            
                                            <xsl:if test="notification_data/request/display/chapter !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Chapitre: </strong>
                                                        <xsl:value-of select="notification_data/request/display/chapter" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>

                                            <xsl:if test="notification_data/request/display/volume_bk !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Volume: </strong>
                                                        <xsl:value-of select="notification_data/request/display/volume_bk" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                                                                                                                                                                        
                                        </table>
                                        <br />
                                        
                                        <table role='presentation' >
                                            <xsl:if test="notification_data/query_note !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Note: </strong>
                                                        <xsl:value-of select="notification_data/query_note" />
                                                    </td>
                                                </tr>
                                            </xsl:if>

                                        </table>
                                        <br />      
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <!-- handle AFN default language en -->
                                        <table role='presentation'  cellspacing="0" cellpadding="5" border="0">
                                            <tr>
                                                <td>
                                                    Regarding your recent library request made on <xsl:value-of select="notification_data/request/create_date" />
                                                </td>
                                            </tr>
                                        </table>                        
                                        <br />
                                        <table role='presentation'  cellspacing="0" cellpadding="5" border="0">

                                            <xsl:attribute name="style">
                                                <xsl:call-template name="listStyleCss" />
                                                <!-- style.xsl -->
                                            </xsl:attribute>
                                            
                                            <xsl:if test="notification_data/request/display/title !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Title: </strong>
                                                        <xsl:value-of select="notification_data/request/display/title" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="notification_data/request/display/journal_title !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Journal Title: </strong>
                                                        <xsl:value-of
                                                            select="notification_data/request/display/journal_title" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="notification_data/request/display/author !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Author: </strong>
                                                        <xsl:value-of select="notification_data/request/display/author" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="notification_data/request/display/publication_date !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Publication Date: </strong>
                                                        <xsl:value-of
                                                            select="notification_data/request/display/publication_date" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>                           
                                            <xsl:if test="notification_data/request/display/volume !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Volume: </strong>
                                                        <xsl:value-of select="notification_data/request/display/volume" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="notification_data/request/display/issue !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Issue: </strong>
                                                        <xsl:value-of select="notification_data/request/display/issue" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>                                                       
                                            
                                            <xsl:if test="notification_data/request/display/chapter !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Chapter: </strong>
                                                        <xsl:value-of select="notification_data/request/display/chapter" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>

                                            <xsl:if test="notification_data/request/display/volume_bk !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Volume: </strong>
                                                        <xsl:value-of select="notification_data/request/display/volume_bk" />
                                                        <!-- recordTitle.xsl -->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                                                                                                                                                                        
                                        </table>
                                        <br />
                                        
                                        <table role='presentation' >
                                            <xsl:if test="notification_data/query_note !=''">
                                                <tr>
                                                    <td>
                                                        <strong> Note: </strong>
                                                        <xsl:value-of select="notification_data/query_note" />
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                        </table>
                                        <br />                      
                                    </xsl:otherwise>
                                </xsl:choose>                                                                                                                   
                            </xsl:when>
                            <xsl:otherwise>         
                                <!-- AFN TODO -->
                                <!-- handle local institution on hold (ie. PUT YOUR EXISTING HOLD LETTER INFO HERE between the xsl:otherwise tag)-->                        
                                <table role='presentation'  cellspacing="0" cellpadding="5" border="0">

                                    <tr>
                                        <td>
                                            @@requested@@ <xsl:value-of select="notification_data/request/create_date" />
                                        </td>

                                    </tr>
                                </table>                        
                                <br />
                                <table role='presentation'  cellspacing="0" cellpadding="5" border="0">

                                    <xsl:attribute name="style">
                                        <xsl:call-template name="listStyleCss" />
                                        <!-- style.xsl -->
                                    </xsl:attribute>

                                    
                                    <xsl:if test="notification_data/request/display/title !=''">
                                        <tr>
                                            <td>
                                                <strong> @@title@@: </strong>
                                                <xsl:value-of select="notification_data/request/display/title" />
                                                <!-- recordTitle.xsl -->
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="notification_data/request/display/journal_title !=''">
                                        <tr>
                                            <td>
                                                <strong> @@journal_title@@: </strong>
                                                <xsl:value-of
                                                    select="notification_data/request/display/journal_title" />
                                                <!-- recordTitle.xsl -->
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="notification_data/request/display/author !=''">
                                        <tr>
                                            <td>
                                                <strong> @@author@@: </strong>
                                                <xsl:value-of select="notification_data/request/display/author" />
                                                <!-- recordTitle.xsl -->
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="notification_data/request/display/publication_date !=''">
                                        <tr>
                                            <td>
                                                <strong> @@publication_date@@: </strong>
                                                <xsl:value-of
                                                    select="notification_data/request/display/publication_date" />
                                                <!-- recordTitle.xsl -->
                                            </td>
                                        </tr>
                                    </xsl:if>                           
                                    <xsl:if test="notification_data/request/display/volume !=''">
                                        <tr>
                                            <td>
                                                <strong> @@volume@@: </strong>
                                                <xsl:value-of select="notification_data/request/display/volume" />
                                                <!-- recordTitle.xsl -->
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="notification_data/request/display/issue !=''">
                                        <tr>
                                            <td>
                                                <strong> @@issue@@: </strong>
                                                <xsl:value-of select="notification_data/request/display/issue" />
                                                <!-- recordTitle.xsl -->
                                            </td>
                                        </tr>
                                    </xsl:if>                                                       
                                    
                                    <xsl:if test="notification_data/request/display/chapter !=''">
                                        <tr>
                                            <td>
                                                <strong> @@chapter@@: </strong>
                                                <xsl:value-of select="notification_data/request/display/chapter" />
                                                <!-- recordTitle.xsl -->
                                            </td>
                                        </tr>
                                    </xsl:if>

                                    <xsl:if test="notification_data/request/display/volume_bk !=''">
                                        <tr>
                                            <td>
                                                <strong> @@volume@@: </strong>
                                                <xsl:value-of select="notification_data/request/display/volume_bk" />
                                                <!-- recordTitle.xsl -->
                                            </td>
                                        </tr>
                                    </xsl:if>
                                                                                                                                                                                
                                </table>
                                <br />
                                
                                <table role='presentation' >
                                    <xsl:if test="notification_data/query_note !=''">
                                        <tr>
                                            <td>
                                                <strong> @@query_note@@: </strong>
                                                <xsl:value-of select="notification_data/query_note" />
                                            </td>
                                        </tr>
                                    </xsl:if>

                                </table>
                                <br />                              
                                <!-- END OF AFN TODO -->
                            </xsl:otherwise>
                        </xsl:choose>           
                        <!-- END OF AFN CODE -->
                    </div>
                </div>
                
                <!-- AFN TODO -->
                <!-- AFN footer template options from footer.xsl -->
                <xsl:call-template name="AFNLastFooter" />
                <xsl:call-template name="AFNAccount" />
                <!-- END OF AFN TODO -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
