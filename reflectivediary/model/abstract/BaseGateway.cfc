<cfcomponent output="false">
	<cfscript>
	// ------------------------ CONSTRUCTOR ------------------------ //

	any function init() {
		variables.dbengine = getDBEngine();

		return this;
	}

	// ------------------------ PUBLIC METHODS ------------------------ //

	/**
     * I delete an entity
	 */
	void function delete(required entity) {
		entityDelete(arguments.entity);
	}

	/**
     * I return an entity matching an id
	 */
	function get(required string entityname, required any id) {
// writedump(var='#arguments#', label='', expand=0, abort=0);

		var entity = entityLoadByPK(arguments.entityname, arguments.id);

		if (isNull(entity)) {
			entity = new(arguments.entityname);
		}

		return entity;
	}

	/**
     * I return a new entity
	 */
	function new(required string entityname) {
		return entityNew(arguments.entityname);
	}

	/**
     * I return a count of entity
	 */
	numeric function count(required string entityname, boolean active=false
		,boolean archived=false) {

		if (arguments.active) {
			return ORMExecuteQuery("SELECT COUNT(*) FROM #arguments.entityname# WHERE dateDeleted IS NULL")[1];
		}

		if (arguments.archived) {
			return ORMExecuteQuery("SELECT COUNT(*) FROM #arguments.entityname# WHERE dateDeleted IS NOT NULL")[1];
		}

		return ORMExecuteQuery("SELECT COUNT(*) FROM #arguments.entityname#")[1];
	}

	/**
     * I save an entity
	 */
	function save(required entity) {
		entitySave(arguments.entity);

		return arguments.entity;
	}
    </cfscript>

    <!------------------------ PRIVATE METHODS ------------------------>

    <cffunction name="getDBEngine" returntype="string" output="false" access="private">
		<cfset var dbinfo = "">
		<cfdbinfo type="version" name="dbinfo">

		<cfreturn UCase(dbinfo.DATABASE_PRODUCTNAME)>
	</cffunction>
</cfcomponent>