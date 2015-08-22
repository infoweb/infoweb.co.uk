component accessors='true' extends='abstract' {
	property name='ReflectionService' setter='true' getter='false';

	public any function init(fw) {
		variables.fw = fw;

		return this;
	}

	public void function default(rc) {
		rc.reflections = variables.ReflectionService.getReflections(active=true, startRow=0, sortOrder='when DESC');
	}
}