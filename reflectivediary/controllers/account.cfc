component accessors='true' extends='abstract' {
	property name='UserService' setter='true' getter='false';

	public void function default(rc) {
		param name='rc.forename' default=rc.CurrentUser.getForename();
		param name='rc.surname' default=rc.CurrentUser.getSurname();
		param name='rc.emailAddress' default=rc.CurrentUser.getEmailAddress();

		rc.event.cancel = variables.fw.buildURL('account');
		rc.event.action = variables.fw.buildURL('account.updateAction');

		rc.event.submitLabel = 'Update Account';
	}

	public void function updateAction(rc) {
		rc.validationResult = variables.UserService.updateUser(rc, 'update');

		variables.fw.redirect('account', 'validationResult');

		if (rc.validationResult.getIsSuccess()) {
			variables.fw.redirect('account.updated');
		} else {
			variables.fw.redirect('account', 'validationResult');
		}
	}
}