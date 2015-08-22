<?xml version="1.0" encoding="UTF-8"?>
<validateThis xsi:noNamespaceSchemaLocation="validateThis.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<objectProperties>
		<property name="when" desc="When">
			<rule type="required" contexts="add,update" failureMessage="A When date is required." />

			<rule type="date" contexts="add,update" />
		</property>

		<property name="reflection" desc="Reflection">
			<rule type="required" contexts="add,update" failureMessage="A Reflection is required." />
		</property>

		<property name="duration" desc="Duration">
			<rule type="required" contexts="add,update" failureMessage="A Duration is required." />

			<rule type="time" contexts="add,update" />
		</property>
	</objectProperties>
</validateThis>