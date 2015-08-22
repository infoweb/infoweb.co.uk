component accessors='true' extends='model.abstract.BaseService' {
	property name='EthnicityGateway' setter='true' getter='false';

	public Ethnicity function update(required struct entityProperties) {
		var Ethnicity = variables.EthnicityGateway.getEthnicity(arguments.entityProperties.id);

		populate(Ethnicity, arguments.entityProperties);

		transaction {
			variables.EthnicityGateway.saveEthnicity(Ethnicity);
		}

		return Ethnicity;
	}

	public array function getEthnicities() {
		return variables.EthnicityGateway.getEthnicities();
	}

	public Ethnicity function get(required any id) {
		return variables.EthnicityGateway.getEthnicity(arguments.id);
	}

	public Ethnicity function new() {
		return variables.EthnicityGateway.newEthnicity();
	}

	public Ethnicity function save(required struct entityProperties) {
		var Ethnicity = variables.EthnicityGateway.newEthnicity();

		populate(Ethnicity, arguments.entityProperties);

		transaction {
			variables.EthnicityGateway.saveEthnicity(Ethnicity);
		}

		return Ethnicity;
	}

	public struct function validate(required struct entityProperties, required string context) {
		var Entity = variables.EthnicityGateway.newEthnicity();

		populate(Entity, arguments.entityProperties);

		var validationResult = variables.Validator.validate(theObject=Entity, context=arguments.context);

		if (validationResult.getIsSuccess()) {
			switch(arguments.context){
				case 'add':
					validationResult.setSuccessMessage('The Ethnicity has been added for you');
				break;

				case 'update':
					validationResult.setSuccessMessage('The Ethnicity has been updated for you');
				break;

				default:
					validationResult.setSuccessMessage('The record has been changed');
				break;
			}
		}

		return validationResult;
	}
}