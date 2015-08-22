component accessors='true' extends='abstract' {
	property name='ReflectionService' setter='true' getter='false';

	public void function default(rc) {
		rc.nReflections = variables.ReflectionService.count();

		if (rc.nReflections == 0) {
			variables.fw.redirect('diary.add');
		}

		rc.event.add = variables.fw.buildURL('diary.add');

		rc.jsScript = 'diary.default.js';
	}

	public void function add(rc) {
		var Reflection = variables.ReflectionService.new();

		param name='rc.when' default=lsDateFormat(now(), 'yyyy-mm-dd');
		param name='rc.reflection' default='';
		param name='rc.duration' default='00:30';

		rc.event.cancel = variables.fw.buildURL('diary');
		rc.event.action = variables.fw.buildURL('diary.addAction');

		rc.event.submitLabel = 'Add Reflection';

		variables.fw.setView('diary.addEdit');
	}

	public void function addAction(rc) {
		rc.id = '0';

		rc.validationResult = variables.ReflectionService.validate(rc, 'add');

		if (rc.validationResult.getIsSuccess()) {
			rc.Reflection = variables.ReflectionService.add(rc);

			variables.fw.redirect('diary.add', 'validationResult');
		} else {
			variables.fw.redirect('diary.add', 'all');
		}
	}

	public void function update(rc) {
		var Reflection = variables.ReflectionService.get(rc.id);

		param name='rc.when' default=lsDateFormat(Reflection.getWhen(), 'yyyy-mm-dd');
		param name='rc.reflection' default=Reflection.getReflection();
		param name='rc.duration' default=lsTimeFormat(Reflection.getDuration(), 'HH:mm');

		rc.event.cancel = variables.fw.buildURL('diary');
		rc.event.action = variables.fw.buildURL('diary.updateAction?id=#rc.id#');

		rc.event.submitLabel = 'Update Reflection';

		variables.fw.setView('diary.addEdit');
	}

	public void function updateAction(rc) {
		rc.validationResult = variables.ReflectionService.validate(rc, 'update');

		if (rc.validationResult.getIsSuccess()) {
			rc.Reflection = variables.ReflectionService.update(rc);
		}

		variables.fw.redirect('diary');
	}

	public void function archive(rc) {
	}

	public void function unArchive(rc) {
	}
}