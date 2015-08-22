component persistent='true' table='reflections' {
	property name='id' fieldtype='id' setter='false' type='string' generator='uuid' unsavedvalue='-1';

	property name='when' ormtype='timestamp' notnull=true;
	property name='reflection' ormtype='text' type='string' notnull=true;
	property name='duration' ormtype='timestamp' notnull=true;

	property name='dateCreated' ormtype='timestamp' notnull=true;
	property name='dateUpdated' ormtype='timestamp' notnull=true;
	property name='dateDeleted' ormtype='timestamp';

	Reflection function init() {
		// variables.id = createUUID();

		variables.when = now();
		variables.reflection = '';
		variables.duration = createDate(1970, 1, 1);

		variables.dateCreated = now();
		variables.dateUpdated = variables.dateCreated;
		variables.dateDeleted = '';

		return this;
	}

	boolean function isPersisted()
		hint='I return true if the Entity is persisted'
	{
		if (isNull(entityLoad('Reflection', variables.id, true))) {
			return false;
		} else {
			return true;
		}
	}
}