<cfform action="#xfa.formAction#" method="post" name="forAccountGroup" id="forAccountGroup">	<cfoutput><input name="pkiAccountGroupID" type="hidden" value="#rstAccountGroup.pkiAccountGroupID#"></cfoutput>	<table border="0" align="center" cellpadding="5" cellspacing="1">		<tr align="center">			<td colspan="2"><h2><cfoutput>#fusebox.fuseaction#</cfoutput> Group Account</h2></td>	 </tr>		<tr>			<td nowrap>Account Group</td>			<td>				<cfinput name="strAccountGroup" 					type="text" id="strAccountGroup" value="#rstAccountGroup.strAccountGroup#" 					required="yes" message="Aa account group name is required.">			</td>		</tr>		<tr align="center">			<td colspan="2">				<input name="btnCancel" type="button" id="btnCancel" value="Cancel">				&nbsp;				<input name="btnAccept" type="submit" id="btnAccept" value="Accept">			</td>		</tr>	</table></cfform>