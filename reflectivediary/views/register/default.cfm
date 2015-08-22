<cfimport prefix="bs" taglib="/cfBootstrap/tag" />

<cfoutput>
	<bs:row>
		<bs:col span="4" offset="4">
			<h1>Register</h1>

			#view('common/validationResult')#
		</bs:col>
	</bs:row>

	<bs:row>
		<bs:col>
			<bs:form name="registerForm" class="span4 offset4 well small-well" action="#buildURL('register.registerAction')#">
				<bs:input name="emailAddress" type="text" placeholder="Email address" value="#rc.emailAddress#">

				<div class="pull-right">
					<bs:button name="submitForm" type="submit" class="btn-success" value="Register">
				</div>
			</bs:form>
		</bs:col>
	</bs:row>
</cfoutput>