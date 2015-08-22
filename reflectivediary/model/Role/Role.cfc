component persistent='true' table='roles' {
	property name='id' fieldtype='id' setter='false' generator='assigned';

	property name='name' ormtype='string' length='255' notnull=true;

	property name='dateCreated' ormtype='timestamp' notnull=true;
	property name='dateUpdated' ormtype='timestamp' notnull=true;
	property name='dateDeleted' ormtype='timestamp';

	Role function init() {
		variables.id = createUUID();

		variables.name = '';

		variables.dateCreated = now();
		variables.dateUpdated = variables.dateCreated;
		variables.dateDeleted = '';

		return this;
	}

	boolean function isPersisted()
		hint='I return true if the Entity is persisted'
	{
		if (isNull(entityLoad('Role', variables.id, true))) {
			return false;
		} else {
			return true;
		}
	}
}