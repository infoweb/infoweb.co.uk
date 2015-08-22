component accessors='true' {
	property name='SecurityService' setter='true' getter='false';

	void function init(required any fw) {
		variables.fw = arguments.fw;
	}

	void function before(required struct rc) {
		rc.isAllowed = variables.SecurityService.isAllowed(variables.fw.getFullyQualifiedAction());

		if (rc.isAllowed) {
			rc.CurrentUser = variables.SecurityService.getCurrentUser();
		} else {
			variables.fw.redirect('signin');
		}

		if (isNull(rc.CurrentUser)) {
			rc.isAuthenicated = false;
		} else {
			rc.isAuthenicated = true;
		}

// if the user hasn't updated their login details then send them back to the account page
		// if (rc.CurrentUser.getDateCreated() == rc.CurrentUser.getDateUpdated() && variables.fw.getSection() != 'account') {
			// variables.fw.redirect('account');
		// }
	}
}