component accessors='true' extends='model.abstract.BaseGateway' {
/**
* I delete a user
*/
	void function deleteUser(required User theUser) {
		delete(arguments.theUser);
	}

/**
* I return a user matching an id
*/
	User function getUser(required any userID) {
		return get('User', arguments.userID);
	}

/**
* I return a user matching a email address and password
*/
	User function getUserByCredentials(required any theUser) {
		var User = ormExecuteQuery('from User where emailAddress=:emailAddress and password=:password'
			,{emailAddress=arguments.theUser.getEmailAddress(), password=arguments.theUser.getPassword()}, true);

		if (isNull(User)) {
			User = new('User');
		}

		return User;
	}

/**
* I return a user matching an email address
*/
	function getUserByEmailAddress(required any theUser) {
		var User = ormExecuteQuery('from User where emailAddress=:emailAddress'
			,{emailAddress=arguments.theUser.getEmailAddress()}, true);

		if (isNull(User)) {
			User = new('User');
		}

		return User;
	}

/**
* I return an array of users
*/
	array function getUsers() {
		return entityLoad('User', {}, 'name');
	}

/**
* I return a new user
*/
	any function newUser() {
		return new('User');
	}

/**
* I save a user
*/
	function saveUser(required any theUser) {
		return save(arguments.theUser);
	}
}