<?xml version="1.0" encoding="UTF-8"?>
<validateThis xsi:noNamespaceSchemaLocation="validateThis.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<objectProperties>
		<property name="title" desc="Forename">
			<rule type="maxLength" contexts="add,update">
				<param name="maxLength" value="255" />
			</rule>
		</property>

		<property name="forename" desc="Forename">
			<rule type="required" contexts="add,update" failureMessage="A forename is required." />

			<rule type="maxLength" contexts="add,update">
				<param name="maxLength" value="255" />
			</rule>
		</property>

		<property name="surname" desc="Surname">
			<rule type="required" contexts="add,update" failureMessage="A surname is required." />

			<rule type="maxLength" contexts="add,update">
				<param name="maxLength" value="255" />
			</rule>
		</property>
	</objectProperties>
</validateThis>