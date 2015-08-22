<cfoutput>
	<table style="width:100%">
		<thead>
			<tr>
				<th>When</th>
				<th>Reflection</th>
				<th>How Long</th>
			</tr>
		</thead>


<!--- <cfdump var='#rc.reflections#' label='reflections' expand='0' abort='0'> --->


		<tbody>
			<h1>Lisa Herbert: Reflective Diary</h1>

			<cfloop array='#rc.reflections#' item='local.reflection'>
				<tr>
					<td>#lsDateFormat(local.reflection.getWhen(), 'dd&nbsp;mmm&nbsp;yyyy')#</td>
					<td>#local.reflection.getReflection()#</td>
					<td>#lsTimeFormat(local.reflection.getDuration(), 'HH:mm')#</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</cfoutput>