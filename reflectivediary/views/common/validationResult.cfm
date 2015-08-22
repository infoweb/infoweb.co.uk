<cfimport prefix="bs" taglib="/cfBootstrap/tag" />

<cfoutput>
	<cfif structKeyExists(rc, 'validationResult')>
		<div class="alert #(rc.validationResult.getIsSuccess() ? 'alert-success' : 'alert-error')#">
			<button type="button" class="close" data-dismiss="alert">&times;</button>

			<cfif rc.validationResult.getIsSuccess()>
				<h4>#rc.validationResult.getSuccessMessage()#</h4>
			<cfelse>
				<h4>Sorry, something's not right here...</h4>

				<p />

				<ul>
					<cfloop array="#rc.validationResult.getFailureMessages()#" index="errorMessage">
						<li>#errorMessage#</li>
					</cfloop>
				</ul>
			</cfif>
		</div>
	</cfif>
</cfoutput>