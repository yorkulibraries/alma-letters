<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />

<!-- START AFN-VERSION 1.11 START Test if it's an EMAIL partner, if so send return letter, otherwise we'll terminate -->
<xsl:variable name="is_email_partner">
	<xsl:if test="(notification_data/user_for_printing/user_group = 'NZILLUSER') or (notification_data/user/user_group = 'NZILLUSER') or (notification_data/request/user_group = 'NZILLUSER')">	
		TRUE		
	</xsl:if>
</xsl:variable>
<!-- END AFN-VERSION 1.11 Test if it's an EMAIL partner if so send return letter, otherwise we'll terminate -->

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
		
		<!-- START AFN-VERSION 1.11 -->
		<!-- AFN CODE -->
		<p>
			@@inform_returned_items@@<xsl:call-template name="AFNOrgName" />.
		</p>

		<p>
			<b>@@loans@@</b>
		</p>

		<xsl:choose>
			<!-- START Test if it's NOT an EMAIL partner, if so terminate letter -->
			<xsl:when test="(string-length($is_email_partner) = 0)">
				<xsl:message terminate="yes">user group is NOT an EMAIL ILL PARTNER - TERMINATE </xsl:message>
			</xsl:when>
			<!-- END Test if it's an EMAIL partner, if so terminate letter -->		
		</xsl:choose>		
		<!-- END AFN-VERSION 1.11 -->

        	<table cellspacing="0" cellpadding="5" border="0">
				<!-- START AFN-VERSION 1.11 removed the <tr> tag (first row) of table containing the h tag. Moved to paragraph above-->
				<!-- Same with the second tr row with loans label -->
				<!-- END AFN-VERSION 1.11 -->
				
              	<xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
					<tr>
						<td>
							<table cellpadding="5" class="listing">
								<xsl:attribute name="style">
									<xsl:call-template name="mainTableStyleCss" />
								</xsl:attribute>
								<tr align="center" bgcolor="#f5f5f5">
									<td colspan="6">
										<h3><xsl:value-of select="organization_unit/name" /></h3>
									</td>
								</tr>
								<tr>
									<th>@@title@@</th>									
									<th>@@author@@</th>
									<th>@@due_date@@</th>
									<th>@@return_date@@</th>
									<th>@@fine@@</th>
									<th>@@library@@</th>
								</tr>

								<xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display/item_loan">
									<tr>
										<td><xsl:value-of select="title"/></td>										
										<td><xsl:value-of select="author"/></td>
										<td><xsl:value-of select="new_due_date_str"/></td>
										<td><xsl:value-of select="return_date_str"/></td>
										<td><xsl:value-of select="normalized_fine"/></td>
										<td><xsl:value-of select="library_name"/></td>
									</tr>
								</xsl:for-each>
							</table>
						</td>
					</tr>
					<hr/><br/>
				</xsl:for-each>
				<br />
				<br />
			</table>

			<table>
				<tr><td>@@sincerely@@</td></tr>
				<tr><td>@@department@@</td></tr>
			</table>

	  		</div>
        </div>
        <!-- footer.xsl -->        
		<!-- START AFN-VERSION 1.11 -->
		<!-- AFN CODE -->
		<!-- AFN footer template options from footer.xsl -->
        <xsl:call-template name="AFNLastFooter" />        
        
		<xsl:choose>			
			<!-- Show an institution account link if NOT an email partner -->
			<xsl:when test="(string-length($is_email_partner) = 0)">				
				<xsl:call-template name="myAccount" />						
			</xsl:when>					
		</xsl:choose>				
		<!-- END AFN-VERSION 1.11 -->
        
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
