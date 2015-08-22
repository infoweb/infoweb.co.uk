component persistent='true' table='users' {
	property name='id' column='id' fieldtype='id' setter='false' generator='assigned';

	property name='forename' column='forename' ormtype='string' length='255' dbdefault="''";
	property name='surname' column='surname' ormtype='string' length='255' dbdefault="''";
	property name='emailAddress' column='emailAddress' ormtype='string' length='255' notnull=true;
	property name='password' column='password' ormtype='string' length='255' setter='false' notnull=true;
	property name='passwordSalt' column='passwordSalt' ormtype='string' length='255' notnull=true;

// many Users can have one Role
	property name="role" fieldtype="many-to-one" cfc="Role" fkcolumn="roleID";

	property name='dateCreated' column='dateCreated' ormtype='timestamp' notnull=true;
	property name='dateUpdated' column='dateUpdated' ormtype='timestamp' notnull=true;
	property name='dateDeleted' column='dateDeleted' ormtype='timestamp';

	property name='applicationPasswordSalt' persistent='false' default='BF9BAB6A-EC9B-4C40-BA244DC938395958';
	property name='currentPassword' persistent='false' default='';
	property name='newPassword' persistent='false' default='';

	User function init() {
		variables.id = createUUID();

		variables.forename = '';
		variables.surname = '';

		variables.emailAddress = '';
		variables.password = 'abc';
		variables.password = '';
		variables.passwordSalt = '';
		variables.passwordSalt = createUUID();

		variables.dateCreated = now();
		variables.dateUpdated = variables.dateCreated;
		variables.dateDeleted = '';

		return this;
	}

	public void function setPassword(required string password) {
// http://www.12robots.com/index.cfm/2008/5/21/Salting-Passwords-Security-Series-4.3
// http://www.12robots.com/index.cfm/2008/5/29/Salting-and-Hashing-Code-Example--Security-Series-44
// http://www.12robots.com/index.cfm/2008/6/2/User-Login-with-Salted-and-Hashed-passwords--Security-Series-45

		if (arguments.password != '') {
			var passwordHash = '';

			var userPasswordSalt = variables.passwordSalt;

			passwordHash = hash(arguments.password & userPasswordSalt & variables.applicationPasswordSalt, 'SHA-512');

			for (var i = 1; i lte 1257; i++) {
				passwordHash = hash(passwordHash & userPasswordSalt & variables.applicationPasswordSalt, 'SHA-512');
			}

			variables.password = passwordHash;
		}
	}

	public void function setConfirmPassword(required string confirmPassword) {
		if (arguments.confirmPassword != '') {
			var passwordHash = '';

			var userPasswordSalt = variables.passwordSalt;

			passwordHash = hash(arguments.confirmPassword & userPasswordSalt & variables.applicationPasswordSalt, 'SHA-512');

			for (var i = 1; i lte 1257; i++) {
				passwordHash = hash(passwordHash & userPasswordSalt & variables.applicationPasswordSalt, 'SHA-512');
			}

			variables.confirmPassword = passwordHash;
		}
	}

	private string function encryptPassword(required string password) {
		var userPasswordSalt = variables.passwordSalt;

		var passwordHash = hash(arguments.password & userPasswordSalt & variables.applicationPasswordSalt, 'SHA-512');

		for (var i = 1; i lte 1257; i++) {
			passwordHash = hash(passwordHash & userPasswordSalt & variables.applicationPasswordSalt, 'SHA-512');
		}

		return passwordHash;
	}

/**
* I return true if the email address is unique
*/
	struct function isEmailUnique() {
		var matches = [];

		var result = {isSuccess=false
			,failureMessage='The email address "#variables.emailAddress#" is already registered.'};

		if (isPersisted()) {
			matches = ormExecuteQuery('from User where id <> :id and emailAddress = :emailAddress'
				,{id=variables.id, emailAddress=variables.emailAddress});
		} else {
			matches = ormExecuteQuery('from User where emailAddress=:emailAddress'
				,{emailAddress=variables.emailAddress});
		}

		if (!arrayLen(matches)) {
			result.isSuccess = true;
		}

		return result;
	}

/**
* I return true if ...
*/
	struct function isCurrentPasswordCorrect() {
		var result = {isSuccess=false
			,failureMessage=''};

		if (variables.newPassword == '') {
			result.isSuccess = true;
		} else if (variables.currentPassword == '') {
			result.isSuccess = false;
			result.failureMessage = 'If a new password is provided, the current password must also be provided.';
		} else if (encryptPassword(variables.currentPassword) == variables.password) {
			result.successMessage = 'Your password has been updated.';

			result.isSuccess = true;
		} else {
			result.isSuccess = false;
			result.failureMessage = 'The current password provided is not correct.';
		}

		return result;
	}

	boolean function isPersisted()
		hint='I return true if the Entity is persisted'
	{
		if (isNull(entityLoad('User', variables.id, true))) {
			return false;
		} else {
			return true;
		}
	}
}