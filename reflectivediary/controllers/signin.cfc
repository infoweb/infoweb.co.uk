component accessors='true' extends='abstract' {
	property name='UserService' setter='true' getter='false';

	public void function default(rc) {
		param name='rc.emailAddress' default='';
		param name='rc.password' default='';

		if (NOT structKeyExists(cookie, 'reflectivediary')) {
			cookie name='reflectivediary' value='' preservecase=true;
		}
	}

	public void function signinAction(rc) {
		rc.validationResult = variables.UserService.validateUser(rc, 'signin');

		if (NOT rc.validationResult.getIsSuccess()) {
			variables.fw.redirect('signin', 'validationResult');
		}

		rc.validationResult = variables.SecurityService.signinUser(rc, 'signin');

		if (rc.validationResult.getIsSuccess()) {
			cookie name='reflectivediary' value=rc.emailAddress preservecase=true;

			variables.fw.redirect('diary');
		} else {
			variables.fw.redirect('signin', 'validationResult');
		}
	}
}