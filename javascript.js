function placeFocus() {
	if (document.forms.length > 0) {
		var field = document.forms[0];
		for (i = 0; i < field.length; i++) {
			if ((field.elements[i].type == "text") 
				|| (field.elements[i].type == "textarea") 
				|| (field.elements[i].type.toString().charAt(0) == "s")) {
					document.forms[0].elements[i].focus();
					document.forms[0].elements[i].select();
					break;
			}
		}
	}
}

function delEntry(id,action) {
	if (confirm('Are you sure you want to delete this entry?'))
		window.location='index.cfm?fuseaction=' + action + '&id=' + id;
}

function openWindow(theURL,winName,features) {
	window.open(theURL,winName,features);
}

function breakFrame() {
	if (parent.frames.length > 0) {
	    parent.location.href = self.document.location
	}
}
