#!/bin/tclsh

set DPControls_GETSTATUS(SWITCH.STATE) [list SwitchControl_getStatus]

set DPControls_GETCONTROLS(SWITCH.STATE) [list SwitchControl_getControls]

#set DPControls_GETTOPCONTROLS(SWITCH.STATE) [list SwitchControl_getTopControls]


set COMMANDS(switch_on)  [list SwitchControl_on]
set COMMANDS(switch_off) [list SwitchControl_off]

proc SwitchControl_getStatus { channelId dataPoint } {
	array set dp $dataPoint
	
	set    script  "var dpId = \"$dp(ID)\";"
	append script {
		var dp = dom.GetObject(dpId);
		var value = dp.Value();
		Write(value.ToString(3));
	}
	
	switch -exact -- [rega_exec $script] {
		true    { set status "Ein" }
		false   { set status "Aus" }
		default { set status "Unbekannt" }
	}
	
	set    result [status_separator]
	append result {<tr><td class="status">}
	append result {<div class="caption">Status</div>}
	append result "<div class=\"center\">$status</div>"
	append result {</td></tr>}
	
	return $result

}

proc SwitchControl_getTopControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""

	append result [button Ein "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=switch_on"]

	return $result
}

proc SwitchControl_getControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button Ein "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=switch_on"]
	append result [button Aus "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=switch_off"]

	return $result
}

proc SwitchControl_on { } {
	global fav
	
	set    script "var channelId = \"$fav(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dpId = channel.DPByControl("SWITCH.STATE");
		var dp = dom.GetObject(dpId);
		dp.State(1);
	}
	
	rega_exec $script
}

proc SwitchControl_off { } {
	global fav
	
	set    script "var channelId = \"$fav(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dpId = channel.DPByControl("SWITCH.STATE");
		var dp = dom.GetObject(dpId);
		dp.State(0);
	}
	
	rega_exec $script
}