<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:template name="head">
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
                    <!-- AFN CODE -->
                    <xsl:choose>
                        <xsl:when test="(notification_data/user_for_printing/user_group = 'AFNUSER') or (notification_data/user/user_group = 'AFNUSER') or (notification_data/request/user_group = 'AFNUSER') or (notification_data/user_for_printing/user_group = 'TUGUSER') or (notification_data/user/user_group = 'TUGUSER') or (notification_data/request/user_group = 'TUGUSER')">
                            <!-- AFN VERSION 1.8 -->
                            <img src="https://ocul.on.ca/omni/images/omni_logo_for_letters.jpg" alt="Omni logo"/>
                            <!-- END OF AFN VERSION 1.8 -->
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- AFN TODO -->
                            <!-- AFN VERSION 1.8 -->
                            <img style="width: 140px; height: auto;" src="https://www.yorku.ca/wp-content/themes/york2020/images/yorku-logo.jpg" alt="York University Logo"/>
                            <!-- END OF AFN VERSION 1.8 -->
                            <!-- END OF AFN TODO -->
                        </xsl:otherwise>                
                    </xsl:choose>
                    <!-- END OF AFN CODE -->
               </div>
        </div>
        </td>
    </tr>
<!-- END OF LOGO INSERT -->
    <tr>

  <xsl:for-each select="notification_data/general_data">
     <td>
        <xsl:choose>            
            <xsl:when test="letter_type = 'SavedSearchesLetter' ">
                <h1>New Results for Your Saved Search</h1>
            </xsl:when>
            <xsl:otherwise>         
                <h1><xsl:value-of select="letter_name"/></h1>
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

</xsl:stylesheet>