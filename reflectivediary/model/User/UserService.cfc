component accessors='true' extends='model.abstract.BaseService' {
	property name='UserGateway' setter='true' getter='false';

	public any function register(required string emailAddress) {
		var User = variables.UserGateway.newUser();

		arguments.password = getRandomString(6);

		populate(User, arguments);

		transaction {
			variables.UserGateway.saveUser(User);
		}

		var emailBody = 'Welcome to infoweb.com your password is "#arguments.password#" without quotes.';



Ng2aef


writedump(var='#emailBody#', label='', expand=1, abort=1);

		variables.EmailService.send('"Scrum Master" <scrummaster@infoweb.com>'
			,arguments.emailAddress
			,'Welcome to infoweb.com'
			,emailBody);

		return User;
	}

	public any function signin(required string emailAddress, required string password) {
		var User = variables.UserGateway.newUser();

		populate(User, arguments);

		variables.UserGateway.getUserByCredentials(User);

		return User;
	}

	public struct function validateUser(required struct entityProperties, required string context) {
		var User = variables.UserGateway.newUser();

		populate(User, arguments.entityProperties);

		var validationResult = variables.Validator.validate(theObject=User, context=arguments.context);

		return validationResult;
	}

	public struct function updateUser(required struct entityProperties, required string context) {
		var User = variables.UserGateway.getUser(arguments.entityProperties.CurrentUser.getID());

		populate(User, arguments.entityProperties);

		var validationResult = variables.Validator.validate(theObject=User, context=arguments.context);

		if (validationResult.getIsSuccess()) {
			transaction {
				User.setPassword(arguments.entityProperties.newPassword);
				User.setDateUpdated(now());

				variables.UserGateway.saveUser(User);
			}

			validationResult.setSuccessMessage('Your account details have been updated for you');
		}

		return validationResult;
	}

	User function getUserByEmailAddress(required User theUser) {
		return variables.UserGateway.getUserByEmailAddress(theUser);
	}

// based on Ben Nadel's work - http://www.bennadel.com/index.cfm?dax=blog:488.view
	public string function getRandomString(required numeric length) {
		var lowerCaseAlpha = 'abcdefghjkmnpqrstuvwxyz';
		var upperCaseAlpha = 'ABCDEFGHJKMNPQRSTUVWXYZ';
		var numbers = '23456789';
		var otherChars = '!@##$%^&*';

		var allValidChars = lowerCaseAlpha & upperCaseAlpha & numbers & otherChars;

		var stringArray = [];

		stringArray[1] = mid(numbers,randRange(1, len(numbers)), 1);
		stringArray[2] = mid(lowerCaseAlpha, randRange(1, len(lowerCaseAlpha)), 1);
		stringArray[3] = mid(upperCaseAlpha, randRange(1, len(upperCaseAlpha)), 1);

		for (var intChar=1; intChar LTE arguments.length; ++intChar) {
			stringArray[intChar] = mid(allValidChars, randRange(1, len(allValidChars)), 1);
		}

		createObject('java', 'java.util.Collections').Shuffle(stringArray);

		var randonString = arrayToList(stringArray, '');

		return randonString;
	}
}