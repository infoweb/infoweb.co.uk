component accessors='true' extends='model.abstract.BaseGateway' {
	void function deleteReflection(required Reflection Entity)
		hint='I delete a reflection'
	{
		delete(arguments.Entity);
	}

	Reflection function getReflection(required any id)
		hint='I return a reflection matching an id'
	{
		return get('Reflection', arguments.id);
	}

	array function getReflections(boolean active=false
		,boolean archived=false
		,numeric startRow=0
		,numeric maxRows=0
		,string sortOrder='')

		hint='I return an array of reflections'
	{
		var filterCriteria = {};
		var options = {};

		options.offset = arguments.startRow;

		if (arguments.maxRows > 0) {
			options.maxResults = arguments.maxRows;
		}

		if (arguments.active) {
			filterCriteria.dateDeleted = javaCast('NULL', '');

			return entityLoad('Reflection', filterCriteria, arguments.sortOrder, options);
		}

		if (arguments.archived) {
			filterCriteria.dateDeleted = javaCast('NULL', '');

			return ormExecuteQuery('FROM Reflection WHERE dateDeleted IS NOT NULL ORDER BY #arguments.sortOrder#', false, options);
		}

		return entityLoad('Reflection', filterCriteria, arguments.sortOrder, options);
	}

	Reflection function newReflection()
		hint='I return a new reflection'
	{
		return new('Reflection');
	}

	function saveReflection(required any Entity)
		hint='I save a reflection'
	{
		return save(arguments.Entity);
	}
}