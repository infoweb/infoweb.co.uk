component accessors='true' extends='abstract' {
	property name='UserService' setter='true' getter='false';

	public void function default(rc) {
		param name='rc.emailAddress' default='';
	}

	public void function registerAction(rc) {
		rc.validationResult = variables.UserService.validateUser(rc, 'register');

		if (rc.validationResult.getIsSuccess()) {
			rc.result = variables.UserService.register(trim(rc.emailAddress));

			variables.fw.redirect('register.welcome');
		} else {

			variables.fw.redirect('register.', 'validationResult');
		}
	}
}