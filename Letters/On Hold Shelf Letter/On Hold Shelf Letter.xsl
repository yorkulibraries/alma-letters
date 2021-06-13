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

                                            <tr>
                                                <td>
                                                    <br/>      
                                                    <!-- AFN-VERSION 1.1 -->
                                                    Pour connaitre les heures de service et les informations sur le ramassage, veuillez consulter la page web de la bibliothèque sur le ramassage, donnée ci-dessus.
                                                    <br/>
                                                </td>
                                            </tr>

                                        </xsl:if>                                       
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


<xsl:template name="on_hold_shelf_head">
    <table cellspacing="0" cellpadding="5" border="0">
        <xsl:attribute name="style">
            <xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
        </xsl:attribute>
        <!-- LOGO INSERT -->
        <tr>
        <xsl:attribute name="style">
            <xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
        </xsl:attribute>
            <td colspan="2">
            <div id="mailHeader">
                  <div id="logoContainer" class="alignLeft">
                        <img src="cid:logo.jpg" alt="logo"/>
                   </div>
            </div>
            </td>
        </tr>
    <!-- END OF LOGO INSERT -->
        <tr>

      <xsl:for-each select="notification_data/general_data">
         <td>
    <xsl:choose>
    <xsl:when test="/notification_data/organization_unit/name = 'Osgoode Hall Law School Library' ">
            <h1>Osgoode Curbside Pickup</h1>
    </xsl:when>
    <xsl:otherwise>
        <xsl:choose>
        <xsl:when test="/notification_data/request/calculated_destination_name = 'Leslie Frost Library - Frost Circulation' ">
            <h1>Demande de ramassage de livres dans les casiers de la bibliothèque « Hold 'n Go » / Libraries’ Hold ‘n Go Locker Pickup Request </h1>
        </xsl:when>
        <xsl:otherwise>
            <h1>Libraries’ Hold ‘n Go Locker Pickup Request </h1>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:otherwise>
    </xsl:choose>
        </td>
        <td align="right">
            <xsl:value-of select="current_date"/>
        </td>
      </xsl:for-each>

    </tr>
    </table>


    </xsl:template>

    <xsl:template name="org_yul_locker_pickup">
        <xsl:choose>
            <xsl:when test="/notification_data/organization_unit/name = 'Osgoode Hall Law School Library' ">

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
                <li><a href="https://www.library.yorku.ca/covid-self-screen.pdf" target="_blank"> Self-screen!</a> If you are sick, do not visit campus</li>

                <li>Maintain a physical distance of 2m (6 feet) from others</li>

                <li>Practice frequent hand hygiene</li>

                <li>Practice respiratory etiquette by coughing and sneezing into your sleeve</li>

                <li>Wear a face and nose covering while on campus</li>
                </ul>
                
            </xsl:when>


            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="/notification_data/request/calculated_destination_name = 'Leslie Frost Library - Frost Circulation' ">

                        <p><strong>(English follows)</strong></p>
                        <p><strong>Livres disponibles pour le ramassage dans nos casiers « Hold'n Go ».</strong></p>

                        <p>Un ou plusieurs des livres que vous avez demandés auprès des bibliothèques YorkU peuvent être récupérés dans les casiers de la bibliothèque Frost « Hold'n Go ». Les casiers se trouvent dans le Centre d'excellence du campus de Glendon. Vos articles seront conservés pendant seulement 5 jours ouvrables. </p>

                        <img alt="Hold 'n Go Lockers" src="https://www.library.yorku.ca/frost-lockers.png"/>

                        <p>Le Centre d'Excellence sera ouvert de 12h à 17h, du lundi au vendredi.</p>

                        <p>Veuillez apporter votre carte YU. Si vous n’avez pas de carte YU, rendez-vous au <a href="https://www.yorku.ca/yucard/">bureau de la carte YU</a>.</p>

                        <p>Pour les personnes ayant des problèmes d'accessibilité, veuillez nous contacter pour vous assurer que nous pouvons soutenir votre utilisation de nos ressources et installations - <a href="mailto:askusyul@yorku.ca">askusyul@yorku.ca</a> </p>

                        <p><strong>Les articles disponibles pour le ramassage</strong></p>

                        <p><i><xsl:call-template name="recordTitle" /></i></p>

                        <p><strong>Santé et sécurité</strong></p>

                        <p>Toute personne fréquentant le campus doit remplir la <a href="https://yubettertogether.info.yorku.ca/appendix-a/">liste de contôle</a></p>

                        <p>Si vous répondez OUI à l'une des questions, <u>vous ne devez pas vous rendre</u> sur aucun campus / emplacement de York. </p>

                        <p>Pendant votre séjour sur le campus, vous devrez:</p>
                        <ul>
                        <li>Maintenir une distance physique de 2 m (6 pieds) entre vous. </li>
                        <li>Pratiquer une hygiène des mains fréquente. </li>
                        <li>Pratiquer l'étiquette respiratoire en toussant et en éternuant dans votre manche. </li>
                        <li>Porter un couvre-visage non médical qui couvre la bouche et le nez. </li>
                        </ul>

                        <p>Cordialement,</p>

                        <p>Bibliothèques de York </p>
                    
                        <p>Pour les questions concernant les ordinateurs portables empruntés de UIT, veuillez contacter <a href="mailto:AskIT@yorku.ca">AskIT@yorku.ca</a>.</p>
                    
                        <p>Pour plus d'informations sur vos demandes, veuillez vérifier votre compte dans <a href="https://ocul-yor.primo.exlibrisgroup.com/discovery/login?vid=01OCUL_YOR:YOR_DEFAULT">Omni</a>. Si vous avez des questions ou avez besoin d'aide, veuillez nous contacter : <a href="mailto:askusyul@yorku.ca">Bibliothèques de l'Université York</a> (askusyul@yorku.ca) | 416-736-5181. Pour toute demande relative à Osgoode, veuillez contacter <a href="mailto:library@osgoode.yorku.ca">library@osgoode.yorku.ca</a> | 416-736-5206. </p>

                        <hr/>

                        <p><strong>Books Available for Pickup at our Hold 'n Go Lockers</strong></p>

                        <p>One or more of the books you requested are available for pick up at the YorkU Libraries’ Frost Hold ‘n Go Lockers. The lockers are located in the Centre of Excellence, Glendon Campus. Your items will be held for 5 business days only. </p>

                        <img alt="Hold 'n Go Lockers" src="https://www.library.yorku.ca/frost-lockers.png"/>

                        <p>The Centre of Excellence will be open from 12pm to 5pm, Monday to Friday.</p>

                        <p>Please bring your YU card. If you don’t have a YU-card, visit the <a href="https://www.yorku.ca/yucard/">YU-Card Office</a>.</p>

                        <p>For more information on how to access the Hold 'n Go Lockers, please click on <a href=" https://researchguides.library.yorku.ca/covid19services/curbside#LockerInstructions">this link</a>. Those with accessibility issues may wish to contact us to ensure we can support your use of our resources and facilities. York University Libraries (<a href="mailto:askusyul@yorku.ca">askusyul@yorku.ca</a>) | 416-736-5181</p>

                        <p><strong>The Book(s) Available for Pickup </strong></p>

                        <p><i><xsl:call-template name="recordTitle" /></i></p>

                        <p><strong>Health and Safety</strong></p>

                        <p>Everyone attending campus must complete the <a href="https://yubettertogether.info.yorku.ca/appendix-a/">screening checklist</a>. If you answer YES to any one of the questions, you are not to attend any York campus/location.</p>

                        <p>While on campus, you are expected to:</p>
                        <ul>
                        <li>Maintain a physical distance of 2m (6 feet) from others</li>
                        <li>Practice frequent hand hygiene </li>
                        <li>Practice respiratory etiquette by coughing and sneezing into your sleeve</li>
                        <li>Wear a non-medical face and nose covering</li>
                        </ul>

                        <p>Kind regards,</p>

                        <p>York Libraries</p>

                    </xsl:when>
                    <xsl:otherwise>

                        <p><strong>Books Available for Pickup at our Hold 'n Go Lockers</strong></p>


                        <p>One or more of the books you requested are available for pick up at the YorkU Libraries' Keele Hold 'n Go Lockers, your items will be held for 3 business days only. The lockers are located outside the Scott Library doors, in Central Square. </p>

                        <img alt="Hold 'n Go Lockers" src="https://www.library.yorku.ca/scott-lockers.png"/>

                        <p>Central Square will be open from 8am to 7pm, Monday to Friday. and can be accessed by the side doors at the Vari Hall entrance. Please bring your YU card. If you don’t have a YU-card, please email askusyul@yorku.ca or call 416-736-5181 to receive a barcode number that will open your locker. </p>

                        <p>For more information on how to access the Hold 'n Go Lockers, please click on <a href=" https://researchguides.library.yorku.ca/covid19services/curbside#LockerInstructions">this link</a>. Those with accessibility issues may wish to contact us to ensure we can support your use of our resources and facilities. York University Libraries (<a href="mailto:askusyul@yorku.ca">askusyul@yorku.ca</a>) | 416-736-5181</p>

                        <p><strong>The Book(s) Available for Pickup </strong></p>

                        <p><i><xsl:call-template name="recordTitle" /></i></p>

                        <p><strong>Health and Safety</strong></p>

                        <p>Everyone attending campus must complete the <a href="https://yubettertogether.info.yorku.ca/appendix-a/">screening checklist</a>. If you answer YES to any one of the questions, you are not to attend any York campus/location.</p>

                        <p>While on campus, you are expected to:</p>
                        <ul>
                        <li>Maintain a physical distance of 2m (6 feet) from others</li>
                        <li>Practice frequent hand hygiene </li>
                        <li>Practice respiratory etiquette by coughing and sneezing into your sleeve</li>
                        <li>Wear a non-medical face and nose covering</li>
                        </ul>

                        <p>Kind regards,</p>

                        <p>York Libraries</p>
                        
                    </xsl:otherwise>
                </xsl:choose>


            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
