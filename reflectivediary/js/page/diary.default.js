(function() {
	$.extend($.fn.dataTable.defaults, {
		 "bLengthChange": false
	});

	$('#diaryListing').dataTable({"bStateSave": false
		,"bServerSide": true
		,"iDisplayLength": 8
		,"sDom": "<'row'<'col-md-12'l><'col-md-12'>r>t<'row'<'col-md-4'i><'col-md-8'p>>"
		,"sPaginationType": "bootstrap"
		,"sAjaxSource": "/reflectivediary/model/Reflection/ReflectionService.cfc?method=getAjaxReflections"

		,"aoColumns": [{"mDataProp": "when", "sTitle": "When", "sClass": "update", "bSortable": true}
			,{"mDataProp": "reflection", "sTitle": "Reflection", "sClass": "update", "sWidth": "100%", "bSortable": false}
			,{"mDataProp": "duration", "sTitle": "How&nbsp;Long", "sClass": "update", "bSortable": false}
			,{"mDataProp": "archive", "sTitle": "&nbsp;", "sClass": "nonbreak", "bSortable": false}
		 ]

		 ,"aaSorting": [
		 	[1, 'asc']
		]

		,"fnServerParams": function(aoData) {
			aoData.push({"name": "active", "value": "true"});
			aoData.push({"name": "sortOrder", "value": "when DESC, dateCreated DESC"});
		}

		,"fnServerData": function (sSource, aoData, fnCallback) {
			$.ajax(
				{"dataType": "json"
					,"type": "POST"
					,"url": sSource
					,"data": aoData
					,"success": fnCallback}
			);
		}
	});

// update record
	$(document).on('click', '#diaryListing tbody tr td.update', function(e) {
		var recordID = $(this).closest("tr").attr('id');

		window.location = '/reflectivediary/index.cfm?action=diary.update&id=' + recordID;
	});

// archive record
	$(document).on('click', '#diaryListing tbody tr td button.archiveRecord', function(e) {
		var recordID = $(this).attr('data-id');

		if (confirm("Are you sure you want to archive this record?")) {
			window.location = '/reflectivediary/index.cfm?action=diary.archiveAction&id=' + recordID;
		}
	});
})();