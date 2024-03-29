<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<!-- START AFN-VERSION 1.8 START Test if it's an EMAIL partner, if so terminate letter -->
<xsl:variable name="is_email_partner">
    <xsl:if test="(notification_data/user_for_printing/user_group = 'NZILLUSER') or (notification_data/user/user_group = 'NZILLUSER') or (notification_data/request/user_group = 'NZILLUSER')"> 
        TRUE        
    </xsl:if>
</xsl:variable>
<!-- END AFN-VERSION 1.8 Test if it's an EMAIL partner, if so terminate letter -->

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
                        <!-- START AFN-VERSION 1.8 Test if it's an EMAIL partner, if so terminate letter -->
                        <xsl:when test="(string-length($is_email_partner) > 0)">
                            <xsl:message terminate="yes">user group is an EMAIL ILL PARTNER - TERMINATE </xsl:message>
                        </xsl:when>
                        <!-- END AFN-VERSION 1.8 Test if it's an EMAIL partner, if so terminate letter -->

                        <!-- AFN test (is_afn_patron) defined in footer.xsl -->
                        <xsl:when test="(string-length($is_afn_patron) > 0)">
                            <!-- handle AFN supported languages (is_preferred_lang_fr) defined in footer.xsl-->
                            <xsl:choose>
                                <xsl:when test="(string-length($is_preferred_lang_fr) > 0)">
                                    <!-- handle AFN language fr -->
                                    <table cellspacing="0" cellpadding="5" border="0">
                                        <tr>
                                            <td>
                                                <!-- AFN VERSION 1.6 changed some french text -->
                                                <!-- START AFN-VERSION 1.10 -->
                                                Le document suivant de [<xsl:call-template name="AFNOrgName" />] - <xsl:value-of select="notification_data/phys_item_display/owning_library_name"/>, que vous avez demandé le <xsl:value-of select="notification_data/request/create_date"/> peut être récupéré à <b><xsl:value-of select="notification_data/request/assigned_unit_name"/></b>
                                                <!-- END AFN-VERSION 1.10 -->                                                
                                            </td>
                                        </tr>

                                        <xsl:if test="notification_data/request/work_flow_entity/expiration_date">
                                            <tr>
                                                <td>
                                                    <br/>
                                                    <!-- AFN VERSION 1.6 changed some french text -->
                                                    Le document sera conservé pour vous jusqu'au <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>
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
                                                <!-- AFN VERSION 1.6 changed some french text -->
                                                Pour connaitre les heures de service et des informations liées à la récupération de documents veuillez consulter ci-dessus la page web de la bibliothèque.
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
                                                <!-- START AFN-VERSION 1.10 -->
                                                The following item from [<xsl:call-template name="AFNOrgName" />] - <xsl:value-of select="notification_data/phys_item_display/owning_library_name"/>, which you requested on <xsl:value-of select="notification_data/request/create_date"/> can be picked up at <b><xsl:value-of select="notification_data/request/assigned_unit_name"/></b>
                                                <!-- END AFN-VERSION 1.10 -->                                               
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

<!-- YORK stuff -->
    <xsl:template name="org_yul_locker_pickup">
        <xsl:choose>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'THIS IS DISABLED AND SHOULD NOT MATCH')">

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
                    <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Glendon') or contains(/notification_data/request/calculated_destination_name, 'Frost')">

                        <p><b>(English follows)</b></p>
                        <p><b>Document demandé de la bibliothèque est disponible pour la collecte</b></p>

                        <p>Le document suivant, que vous avez demandé le <xsl:value-of select="notification_data/request/create_date"/> peut être ramassé aux <xsl:call-template name="york_formatted_pickup_location_fr"/>.</p>

                        <p>Le document sera disponible jusqu’au <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/></p>

                        <p><b>Disponible pour la collecte</b></p>
                        <p><i><xsl:call-template name="recordTitle" /></i></p>

                        <p><a href="https://ocul-yor.primo.exlibrisgroup.com/discovery/account?vid=01OCUL_YOR:YOR_DEFAULT&amp;lang=fr">Connecter à mon compte</a></p>

                        <xsl:call-template name="york_lastFooter_fr"/>

                        <hr/>

                        <p><b>Requested Library Item is Available for Pickup</b></p>


                        <xsl:call-template name="york_on_hold_shelf_english_common"/>


                    </xsl:when>
                    <xsl:otherwise>

                        <xsl:call-template name="york_on_hold_shelf_english_common"/>
                        
                    </xsl:otherwise>
                </xsl:choose>


            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="york_on_hold_shelf_english_common">
        <p>The following item, which you requested on <xsl:value-of select="notification_data/request/create_date"/> can be picked up at the <xsl:call-template name="york_formatted_pickup_location"/>.</p>

        <p>The item will be held for you until <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/></p>

        <p><b>Available for Pickup</b></p>
        <p><i><xsl:call-template name="recordTitle" /></i></p>

        <p><a href="https://ocul-yor.primo.exlibrisgroup.com/discovery/account?vid=01OCUL_YOR:YOR_DEFAULT&amp;lang=en">Login to My Account</a></p>

        <xsl:call-template name="york_lastFooter"/>
    </xsl:template>

    <xsl:template name="york_formatted_pickup_location">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:call-template name="york_pickup_location_link"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="contains(/notification_data/request/calculated_destination_name, ' - ')">
                    <xsl:value-of select="substring-before(/notification_data/request/calculated_destination_name,' - ')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="/notification_data/request/calculated_destination_name"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

    <xsl:template name="york_formatted_pickup_location_fr">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:call-template name="york_pickup_location_link_fr"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="contains(/notification_data/request/calculated_destination_name, ' - ')">
                    <xsl:value-of select="substring-before(/notification_data/request/calculated_destination_name,' - ')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="/notification_data/request/calculated_destination_name"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

    <xsl:template name="york_pickup_location_link">
        <xsl:choose>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Osgoode')">
                <xsl:value-of select="'https://www.osgoode.yorku.ca/library/libraryservices/covid-19-osgoode-library-faq/'"/>
            </xsl:when>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Glendon')">
                <xsl:value-of select="'https://researchguides.library.yorku.ca/covid19services/locker#s-lib-ctab-16191987-2'"/>
            </xsl:when>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Frost')">
                <xsl:value-of select="'https://researchguides.library.yorku.ca/covid19services/locker#s-lib-ctab-16191987-3'"/>
            </xsl:when>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Steacie')">
                <xsl:value-of select="'https://researchguides.library.yorku.ca/covid19services/locker#s-lib-ctab-16191987-3'"/>
            </xsl:when>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Scott')">
                <xsl:value-of select="'https://researchguides.library.yorku.ca/covid19services/locker#s-lib-ctab-16191987-3'"/>
            </xsl:when>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Bronfman')">
                <xsl:value-of select="'https://researchguides.library.yorku.ca/covid19services/locker#s-lib-ctab-16191987-3'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'https://researchguides.library.yorku.ca/covid19services/locker'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="york_pickup_location_link_fr">
        <xsl:choose>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Osgoode')">
                <xsl:value-of select="'https://www.osgoode.yorku.ca/library/libraryservices/covid-19-osgoode-library-faq/'"/>
            </xsl:when>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Glendon')">
                <xsl:value-of select="'https://researchguides.library.yorku.ca/servicescovid19/collecte#s-lib-ctab-16192952-2'"/>
            </xsl:when>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Frost')">
                <xsl:value-of select="'https://researchguides.library.yorku.ca/servicescovid19/collecte#s-lib-ctab-16192952-3'"/>
            </xsl:when>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Steacie')">
                <xsl:value-of select="'https://researchguides.library.yorku.ca/covid19services/locker#s-lib-ctab-16191987-3'"/>
            </xsl:when>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Scott')">
                <xsl:value-of select="'https://researchguides.library.yorku.ca/covid19services/locker#s-lib-ctab-16191987-3'"/>
            </xsl:when>
            <xsl:when test="contains(/notification_data/request/calculated_destination_name, 'Bronfman')">
                <xsl:value-of select="'https://researchguides.library.yorku.ca/covid19services/locker#s-lib-ctab-16191987-3'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'https://researchguides.library.yorku.ca/covid19services/locker'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

<!-- END of YORK stuff -->

</xsl:stylesheet>
