component accessors='true' extends='model.abstract.BaseGateway' {
/**
* I delete a ethnicity
*/
	void function deleteEthnicity(required Ethnicity Entity) {
		delete(arguments.Entity);
	}

/**
* I return a ethnicity matching an id
*/
	Ethnicity function getEthnicity(required any id) {
		return get('Ethnicity', arguments.id);
	}

/**
* I return an array of ethnicities
*/
	array function getEthnicities() {
		return entityLoad('Ethnicity', {}, 'categorySortOrder,nameSortOrder');
	}

/**
* I return a new ethnicity
*/
	Ethnicity function newEthnicity() {
		return new('Ethnicity');
	}

/**
* I save a ethnicity
*/
	function saveEthnicity(required any Entity) {
		return save(arguments.Entity);
	}
}