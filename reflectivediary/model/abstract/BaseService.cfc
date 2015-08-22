component accessors='true' {
	property name='MetaData' getter='false';
	property name='Validator' getter='false';

	/**
	 * I return an entity validator
	 */
	function getValidator(required Entity) {
		return variables.Validator.getValidator(theObject=arguments.Entity);
	}

	/**
     * I populate an entity
	 */
	void function populate(required Entity, required struct memento, boolean trustedSetter=false, string include='', string exclude='') {
		var populate = true;

		for (var key in arguments.memento) {
			populate = true;

			if (len(arguments.include) && !listFindNoCase(arguments.include, key)) populate = false;
			if (len(arguments.exclude) && listFindNoCase(arguments.exclude, key)) populate = false;
			if (populate && (structKeyExists(arguments.Entity, 'set' & key) || arguments.trustedSetter)) evaluate('arguments.Entity.set#key#(arguments.memento[key])');
		}

		populateMetaData(arguments.Entity);
	}

	/**
	 * I populate meta data for an entity
	 */
	void function populateMetaData(required Entity) {
		if (structKeyExists(arguments.Entity, 'isMetaGenerated') && arguments.Entity.isMetaGenerated()) {
			if (structKeyExists(arguments.Entity, 'setMetaTitle') && structKeyExists(arguments.Entity, 'getTitle')) arguments.Entity.setMetaTitle(arguments.Entity.getTitle());
			if (structKeyExists(arguments.Entity, 'setMetaDescription') && structKeyExists(arguments.Entity, 'getContent')) arguments.Entity.setMetaDescription(variables.MetaData.generateMetaDescription(arguments.Entity.getContent()));
			if (structKeyExists(arguments.Entity, 'setMetaKeywords') && structKeyExists(arguments.Entity, 'getContent')) arguments.Entity.setMetaKeywords(variables.MetaData.generateMetaKeywords(arguments.Entity.getContent()));
		}
	}
}