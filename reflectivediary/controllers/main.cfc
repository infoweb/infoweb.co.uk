component accessors='true' extends='abstract' {
	public any function init(fw) {
		variables.fw = fw;

		return this;
	}

	public void function default(rc) {
	}
}