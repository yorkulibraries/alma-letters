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
                <xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
            </xsl:attribute>

            <xsl:call-template name="head" /> <!-- header.xsl -->
            <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

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
                                    <!-- handle AFN language fr -->
                                    <table cellspacing="0" cellpadding="5" border="0">
                                        <tr>
                                            <td>
                                                L'élément suivant de <xsl:value-of select="notification_data/phys_item_display/owning_library_name"/>, que vous avez demandé sur <xsl:value-of select="notification_data/request/create_date"/> peut être récupéré à <b><xsl:value-of select="notification_data/request/delivery_address"/></b>
                                            </td>
                                        </tr>

                                        <xsl:if test="notification_data/request/work_flow_entity/expiration_date">
                                            <tr>
                                                <td>
                                                    <br/>
                                                    L'article sera conservé pour vous jusqu'au <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <tr>
                                            <td>
                                                <br/>
                                                <xsl:call-template name="recordTitle" /> <!-- recordTitle.xsl -->
                                            </td>
                                        </tr>

                                        <!-- If notes exist, then we'll display the notes lable and the note -->
                                        <xsl:if test="notification_data/request/system_notes !='' ">
                                            <tr>
                                                <td>
                                                    <br/>
                                                    <b>NOTES qui peuvent affecter le prêt:</b>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td><xsl:value-of select="notification_data/request/system_notes"/></td>
                                            </tr>

                                        <!-- AFN-VERSION 1.2 moved /xsl:if closing tag below system_notes tr -->
                                        </xsl:if>                                       
                                            <tr>
                                                <td>
                                                    <br/>      
                                                    <!-- AFN-VERSION 1.1 -->
                                                    Pour connaitre les heures de service et les informations sur le ramassage, veuillez consulter la page web de la bibliothèque sur le ramassage, donnée ci-dessus.
                                                    <br/>
                                                </td>
                                            </tr>

                                    </table>                                
                                </xsl:when> 
                                <xsl:otherwise>
                                    <!-- handle AFN language default english 'en' -->
                                    <table cellspacing="0" cellpadding="5" border="0">
                                        <tr>
                                            <td>
                                                The following item from <xsl:value-of select="notification_data/phys_item_display/owning_library_name"/>, which you requested on <xsl:value-of select="notification_data/request/create_date"/> can be picked up at <b><xsl:value-of select="notification_data/request/delivery_address"/></b>
                                            </td>
                                        </tr>

                                        <xsl:if test="notification_data/request/work_flow_entity/expiration_date">
                                            
                                            <tr>
                                                <td>
                                                    <br/>
                                                    The item will be held for you until <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        
                                        <tr>                                        
                                            <td>
                                                <br/>
                                                <xsl:call-template name="recordTitle" /> <!-- recordTitle.xsl -->
                                            </td>
                                        </tr>

                                        <!-- If notes exist, then we'll display the notes lable and the note -->
                                        <xsl:if test="notification_data/request/system_notes !='' ">                                            
                                            <tr>
                                                <td>
                                                    <br/>    
                                                    <b>NOTES that may affect loan:</b>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td><xsl:value-of select="notification_data/request/system_notes"/></td>
                                            </tr>
                                        </xsl:if>   
                                        
                                        <tr>                                                                                                                                
                                            <td>
                                                <br/>                                                
                                                Please check the website at the pickup library indicated above for service hours and pickup information.
                                                <br/>
                                            </td>
                                        </tr>
                                                                            
                                    </table>
                                </xsl:otherwise>
                            </xsl:choose>                                                                                                                   
                        </xsl:when>
                        <xsl:otherwise>         
                            <!-- AFN TODO -->
                            <!-- handle local institution on hold (ie. PUT YOUR EXISTING HOLD LETTER INFO HERE between the xsl:otherwise tag)-->
                            <xsl:call-template name="org_yul_locker_pickup" />
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

    <xsl:template name="org_yul_locker_pickup">
        <xsl:choose>
            <xsl:when test="/notification_data/request/calculated_destination_name = 'Osgoode Hall Law School Library' ">

                <h2>Osgoode Curbside Pickup</h2>

                <p><i><xsl:call-template name="recordTitle" /></i></p>

                <p>Your curbside request has been processed. Please book a 15-minute pickup window now by visiting <a href="https://rooms.osgoode.yorku.ca/reserve/osgoodecurbside" target="_blank"> https://rooms.osgoode.yorku.ca/reserve/osgoodecurbside</a>. <span style="font-weight:bold">If you have requested more than one book on the same day and have already booked a pickup window, you do not need to book another one.</span></p>

                <h2>Information</h2>

                <ul><li>Pickup location: Osgoode Hall Law School, main entrance (east side).</li>

                <li> When you arrive, call the Osgoode Library circulation desk (416-736-5206) and await further instructions.</li>

                <li>Please arrive promptly with your YUcard or library courtesy card</li>

                <li>Curbside Pickup at Osgoode is available Mondays to Fridays, 10:00am – 4:45pm and is subject to change without notice</li>

                <li>Return Osgoode books to the law library's outdoor book return bin located at the southwest entrance of Osgoode Hall Law School</li>

                <li>Questions? library@osgoode.yorku.ca</li></ul>

                <h2>Health &amp; Safety</h2>

                <ul>
                <li><a href="https://yorku.ubixhealth.com/login" target="_blank">YU Screen</a>. If you are sick, do not visit campus</li>

                <li>Maintain a physical distance of 2m (6 feet) from others</li>

                <li>Practice frequent hand hygiene</li>

                <li>Practice respiratory etiquette by coughing and sneezing into your sleeve</li>

                <li>Wear a face and nose covering while on campus</li>
                </ul>
                
            </xsl:when>


            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Glendon') ">

                        <p><b>(English follows)</b></p>
                        <p><b>Document demandé de la bibliothèque est disponible pour la collecte</b></p>

                        <p>Le document suivant, que vous avez demandé le <xsl:value-of select="notification_data/request/create_date"/> peut être ramassé aux <a href="https://researchguides.library.yorku.ca/servicescovid19/collecte">casiers de Glendon</a>.</p>

                        <p>Le document sera disponible jusqu’au <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/></p>

                        <p><b>Disponible pour la collecte</b></p>
                        <p><i><xsl:call-template name="recordTitle" /></i></p>

                        <p><a href="https://ocul-yor.primo.exlibrisgroup.com/discovery/account?vid=01OCUL_YOR:YOR_DEFAULT&amp;lang=fr">Connecter à mon compte</a></p>

                        <xsl:call-template name="york_lastFooter_fr"/>

                        <hr/>

                        <p><b>Requested Library Item is Available for Pickup</b></p>

                        <p>The following item, which you requested on <xsl:value-of select="notification_data/request/create_date"/> can be picked up at the <a href="https://researchguides.library.yorku.ca/covid19services/locker"><xsl:value-of select="/notification_data/request/calculated_destination_name"/></a>.</p>

                        <xsl:call-template name="york_on_hold_shelf_english_common"/>


                    </xsl:when>
                    <xsl:otherwise>

                        <p>The following item, which you requested on <xsl:value-of select="notification_data/request/create_date"/> can be picked up at the <a href="https://researchguides.library.yorku.ca/covid19services/locker"><xsl:value-of select="/notification_data/request/calculated_destination_name"/></a>.</p>

                        <xsl:call-template name="york_on_hold_shelf_english_common"/>
                        
                    </xsl:otherwise>
                </xsl:choose>


            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="york_on_hold_shelf_english_common">
        <p>The item will be held for you until <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/></p>

        <p><b>Available for Pickup</b></p>
        <p><i><xsl:call-template name="recordTitle" /></i></p>

        <p><a href="https://ocul-yor.primo.exlibrisgroup.com/discovery/account?vid=01OCUL_YOR:YOR_DEFAULT&amp;lang=en">Login to My Account</a></p>

        <xsl:call-template name="york_lastFooter"/>
    </xsl:template>
</xsl:stylesheet>
