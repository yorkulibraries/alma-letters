<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template name="salutation">

</xsl:template>
<xsl:template name="lastFooter">
<table> 
<xsl:attribute name="style"> 
<xsl:call-template name="footerTableStyleCss" />  
</xsl:attribute> 
<tr> 
<p>For inquiries regarding UIT borrowed laptops, please email <a href="mailto:AskIT@yorku.ca">AskIT@yorku.ca</a>.</p>
<p>For information about your loans, please check your account in <a href="https://ocul-yor.primo.exlibrisgroup.com/discovery/login?vid=01OCUL_YOR:YOR_DEFAULT">Omni</a>. If you have questions or need assistance, please contact us: <a href="mailto:askusyul@yorku.ca"> York University Libraries </a>(askusyul@yorku.ca) | 416-736-5181. For Osgoode-related inquiries, please contact <a href="mailto:library@osgoode.yorku.ca"> library@osgoode.yorku.ca</a> | 416-736-5206. </p> 
</tr> 
</table> 
</xsl:template> 

<xsl:template name="contactUs">
    <table align="left">
    <tr>
    <td align="left">
    <a>
                        <xsl:attribute name="href">
                          @@email_contact_us@@
                        </xsl:attribute>
                        @@contact_us@@
                    </a>
    </td>
</tr>
    </table>
</xsl:template>
<xsl:template name="myAccount">
    <table align="left">
    <tr>
    <td align="left">
    <a>
                        <xsl:attribute name="href">
                          @@email_my_account@@
                        </xsl:attribute>
                        @@my_account@@
                    </a>
    </td>
</tr>
    </table>
</xsl:template>



</xsl:stylesheet>
