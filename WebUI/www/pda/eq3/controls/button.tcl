#!/bin/tclsh

set DPControls_GETCONTROLS(BUTTON.SHORT) [list ButtonControl_getShortControls]
set DPControls_GETCONTROLS(BUTTON.LONG)  [list ButtonControl_getLongControls]

set COMMANDS(pressShort) [list ButtonControl_pressShort]
set COMMANDS(pressLong)  [list ButtonControl_pressLong]

proc ButtonControl_getShortControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	array set dp $dataPoint
	
	set result [button "Kurzer Tastendruck" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=pressShort"]
	return $result
}

proc ButtonControl_getLongControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	array set dp $dataPoint
	
	set result [button "Langer Tastendruck" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=pressLong"]
	return $result
}

proc ButtonControl_pressShort { } {
	global fav
	
	set script    "var channelId = \"$fav(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dp = dom.GetObject(channel.DPByControl("BUTTON.SHORT"));
		dp.State(1);
	}
	
	rega_exec $script
}

proc ButtonControl_pressLong { } {
	global fav
	
	set script    "var channelId = \"$fav(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dp = dom.GetObject(channel.DPByControl("BUTTON.LONG"));
		dp.State(1);
	}
	
	rega_exec $script
}


