component accessors='true' extends='model.abstract.BaseService' {
	property name='ReflectionGateway' setter='true' getter='false';

	public Reflection function new() {
		return variables.ReflectionGateway.newReflection();
	}

	public Reflection function add(required struct entityProperties) {
		var Reflection = variables.ReflectionGateway.newReflection();

		populate(Reflection, arguments.entityProperties);

		transaction {
			variables.ReflectionGateway.saveReflection(Reflection);
		}

		return Reflection;
	}

	public Reflection function update(required struct entityProperties) {
		var Reflection = variables.ReflectionGateway.getReflection(arguments.entityProperties.id);

		populate(Reflection, arguments.entityProperties);

		transaction {
			variables.ReflectionGateway.saveReflection(Reflection);
		}

		return Reflection;
	}

	public Reflection function get(required any id) {
		return variables.ReflectionGateway.getReflection(arguments.id);
	}

	public array function getReflections(boolean active=false
		,boolean archived=false
		,numeric startRow=0
		,numeric maxRows=0
		,string sortOrder='') {

		return variables.ReflectionGateway.getReflections(active=arguments.active
			,archived=arguments.archived
			,startRow=arguments.startRow
			,maxRows=arguments.maxRows
			,sortOrder=arguments.sortOrder
		);
	}

	public Reflection function save(required struct entityProperties) {
		var Reflection = variables.ReflectionGateway.newReflection();

		populate(Reflection, arguments.entityProperties);

		transaction {
			variables.ReflectionGateway.saveReflection(Reflection);
		}

		return Reflection;
	}

	public numeric function count(active=true) {
		return arrayLen(getReflections(active=arguments.active));
	}

	public struct function validate(required struct entityProperties, required string context) {
		var Entity = variables.ReflectionGateway.newReflection();

		populate(Entity, arguments.entityProperties);

		var validationResult = variables.Validator.validate(theObject=Entity, context=arguments.context);

		if (validationResult.getIsSuccess()) {
			switch(arguments.context){
				case 'add':
					validationResult.setSuccessMessage('The Reflection has been added for you');
				break;

				case 'update':
					validationResult.setSuccessMessage('The Reflection has been updated for you');
				break;

				default:
					validationResult.setSuccessMessage('The record has been changed');
				break;
			}
		}

		return validationResult;
	}

	remote any function getAjaxReflections(boolean active=false, boolean archived=false) returnFormat='json' {
		var ReflectionService = application.remoteBeanFactory.getBean('ReflectionService');

		var reflections = ReflectionService.getReflections(active=arguments.active
			,archived=arguments.archived
			,startRow=arguments.iDisplayStart
			,maxRows=arguments.iDisplayLength
			,sortOrder=arguments.sortOrder);

		var totalCount = ReflectionService.count(active=arguments.active
			,archived=arguments.archived);

		var filteredCount = ReflectionService.count(active=arguments.active
			,archived=arguments.archived);

		var result = {};

		result['sEcho'] = int(arguments.sEcho);
		result['iTotalRecords'] = totalCount;
		result['iTotalDisplayRecords'] = filteredCount;
		result['aaData'] = [];

		var reflectionTextLimit = 200;

		for (var Entity in reflections) {
			var data = {};

			data['when'] = lSDateFormat(Entity.getWhen(), 'dd&nbsp;mmm&nbsp;yy');
			data['reflection'] = (len(Entity.getReflection()) GT reflectionTextLimit ? left(Entity.getReflection(), reflectionTextLimit) & '&hellip;' : Entity.getReflection());
			data['duration'] = lSTimeFormat(Entity.getDuration(), 'HH:mm');

			if (arguments.archived) {
				data['archive'] = '<button class="btn btn-success pull-right archiveRecord" data-id="#Entity.getID()#" type="button"><i class="icon-plus icon-white"></i> Unarchive</button>';
			} else {
				data['archive'] = '<button class="btn btn-danger pull-right archiveRecord" data-id="#Entity.getID()#" type="button"><i class="icon-trash icon-white"></i> Archive</button>';
			}

			data['DT_RowId'] = Entity.getID();

			arrayAppend(result['aaData'], data);
		}

		return result;
	}
}