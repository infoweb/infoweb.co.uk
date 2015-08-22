<cfimport prefix="bs" taglib="/cfBootstrap/tag" />

<cfoutput>
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<h1>Reflection</h1>

			#view('common/validationResult')#
		</div>
	</div>

	<form name="reflectionForm" action="#rc.event.action#" method="post">
		<div class="row">
			<div class="col-md-8 col-md-offset-2 well small-well">
				<div class="row">
					<div class="col-xs-3">
						<div class="form-group">
							<label for="when">When</label>
							<input type="date" name="when" id="when" class="form-control" value="#rc.when#">
						</div>
					</div>

					<div class="col-xs-2 pull-right">
						<div class="form-group">
							<label for="duration">How long</label>
							<input type="time" name="duration" id="duration" class="form-control" value="#rc.duration#">
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label for="reflection">Reflection</label>
							<textarea id="reflection" name="reflection" class="form-control" rows="15">#rc.reflection#</textarea>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="pull-right">
					<a href="#rc.event.cancel#" name="" id="" type="button" class="btn btn-link">cancel</a>
					<button id="submitForm" name="submitForm" type="submit" class="btn btn-success">#rc.event.submitLabel#</button>
				</div>
			</div>
		</div>
	</form>
</cfoutput>