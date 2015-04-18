#!/bin/tclsh

set DPControls_GETCONTROLS(EVENT_INTERFACE.TRIGGER) [list EventControl_getControls]

set COMMANDS(evt_trigger) [list EventControl_trigger]

proc EventControl_getControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button "Bet&auml;tigen" "$UI_URLBASE/fav.cgi?sid=$uiStyle=[getUIStyle]&sid&favListId=$favListId&favId=$favId&cmd=evt_trigger"]

	return $result
}

proc EventControl_trigger { } {
	global fav
	
	set    script "var channelId = \"$fav(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dpId = channel.DPByControl("EVENT_INTERFACE.TRIGGER");
		var dp = dom.GetObject(dpId);
		dp.State(1);
	}
	
	rega_exec $script
}