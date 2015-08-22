<cfimport prefix="bs" taglib="/cfBootstrap/tag" />

<cfoutput>
	<div class="row">
		<div class="col-xs-4 col-xs-offset-4">
			<h1>Account</h1>

			#view('common/validationResult')#
		</div>
	</div>

	<form name="accountForm" action="buildURL('account.updateAction')" class="" method="post">
		<div class="row">
			<div class="col-xs-12 well small-well">
				<div class="row">
					<div class="col-xs-4">
						<div class="form-group">
							<label for="forename">Given forename</label>
							<input  id="forename" name="forename" type="text" class="form-control" value="#rc.forename#" />
						</div>
					</div>

					<div class="col-xs-4">
						<div class="form-group">
							<label for="surname">Family surname</label>
							<input  id="surname" name="surname" type="text" class="form-control" value="#rc.surname#" />
						</div>
					</div>

					<div class="col-xs-4">
						<div class="form-group">
							<label for="emailAddress">Email address</label>
							<input  id="emailAddress" name="emailAddress" type="email" class="form-control" value="#rc.emailAddress#" />
						</div>
					</div>
				</div>


				<div class="row">
					<div class="col-xs-4">
						<div class="form-group">
							<label for="currentPassword">Current password</label>
							<input  id="currentPassword" name="currentPassword" type="password" class="form-control" />
						</div>
					</div>

					<div class="col-xs-4">
						<div class="form-group">
							<label for="newPassword">New password</label>
							<input  id="newPassword" name="newPassword" type="password" class="form-control" />
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12">
				<div class="pull-right">
					<a href="#rc.event.cancel#" name="" id="" type="button" class="btn btn-link">cancel</a>
					<button id="submitForm" name="submitForm" type="submit" class="btn btn-success">#rc.event.submitLabel#</button>
				</div>
			</div>
		</div>
	</form>
</cfoutput>