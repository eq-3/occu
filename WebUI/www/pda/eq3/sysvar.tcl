#!/bin/tclsh

proc SysVar_getValue { varId } {
	set    script "var varId = \"$varId\";"
	append script {
		var result    = "";
		var sv        = dom.GetObject(varId);
		var svType    = sv.ValueType();
		var svSubType = sv.ValueSubType();
		
		! Logikwert
		if ( (svType == ivtBinary) && (svSubType == istBool) )
		{
			var value = sv.Value();
			if ( (value == 0) || (value == "") ) { result = sv.ValueName0(); }
			else	{ result = sv.ValueName1(); }
		}
		
		! Alarm
		if ( (svType == ivtBinary) && (svSubType == istAlarm) )
		{
			if (sv.AlState() == asOncoming) { result = sv.ValueName1(); }
			else { result = sv.ValueName0(); }
		}
		
		! Werteliste
		if ( (svType == ivtInteger) && (svSubType == istEnum) )
		{
			if (sv.Value() == "")
			{
				result = web.webGetValueFromList(sv.ValueList(), 0);
			}
			else
			{
				result = web.webGetValueFromList(sv.ValueList(), sv.Value());
			}
			result = result # " " # sv.ValueUnit();
		}
		
		! Zahl
		if ( (svType == ivtFloat) && (svSubType == istGeneric) )
		{
			if (sv.Value() != "") { result = sv.Value().ToString(2); }
			else { result = "0.00"; }
			result = result # " " # sv.ValueUnit();
		}
		
		! Zeichenkette
		if ( (svType == ivtString) && (svSubType == istChar8859) )
		{
			result = sv.Value() # " " # sv.ValueUnit();
		}
		
		WriteXML(result);
	}
	
	return [rega_exec $script]
}
