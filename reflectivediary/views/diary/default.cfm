<cfimport prefix="bs" taglib="/cfBootstrap/tag" />

<cfoutput>
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<h1 class="pull-left">Reflective Diary</h1>

			<a href="#rc.event.add#" style="margin-top:20px;" id="btnProductAdd" name="btnProductAdd" type="button" class="pull-right btn btn-success"><i class="icon-plus icon-white"></i> Add Diary Date</a>
		</div>
	</div>

	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<table id="diaryListing" class="table table-striped table-bordered table-condensed">
				<tbody></tbody>
			</table>
		</div>
	</div>
</cfoutput>