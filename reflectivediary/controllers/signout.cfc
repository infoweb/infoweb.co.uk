component accessors='true' extends='abstract' {
	public void function default(rc) {
		rc.validationResult = variables.SecurityService.signoutUser(rc, 'signin');

		variables.fw.redirect('signin', 'validationResult');
	}
}