<?xml version="1.0" encoding="UTF-8"?>
<validateThis xsi:noNamespaceSchemaLocation="validateThis.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<objectProperties>
		<property name="forename" desc="Forename">
			<rule type="required" contexts="update" failureMessage="A forename is required." />
			<rule type="maxLength" contexts="update">
				<param name="maxLength" value="255" />
			</rule>
		</property>

		<property name="surname" desc="Surname">
			<rule type="required" contexts="update" failureMessage="A surname is required." />
			<rule type="maxLength" contexts="update">
				<param name="maxLength" value="255" />
			</rule>
		</property>

		<property name="emailAddress" desc="email address">
			<rule type="required" contexts="register,signin,update" failureMessage="An email address is required." />
			<rule type="email" contexts="register,signin,update" />

			<rule type="maxLength" contexts="register,update">
				<param name="maxLength" value="255" />
			</rule>

			<rule type="custom" contexts="register,update" failureMessage="The email address is registered to an existing account.">
				<param name="methodname" value="isEmailUnique" />
			</rule>
		</property>

		<property name="password" desc="Password">
			<rule type="required" contexts="signin" failureMessage="A password is required." />
		</property>

		<property name="newPassword" desc=" New password">
			<rule type="minLength" contexts="update" failureMessage="The password must be a minimum of 8 characters in length.">
				<param name="minLength" value="6" />
			</rule>

			<rule type="custom" contexts="update" failureMessage="The provided current password is not correct.">
				<param name="methodname" value="isCurrentPasswordCorrect" />
			</rule>
		</property>
	</objectProperties>
</validateThis>