#!/bin/tclsh

set DPControls_GETSTATUS(LOCK.STATE) [list LockControl_getStateStatus]
set DPControls_GETSTATUS(LOCK.UNCERTAIN) [list LockControl_getUncertainStatus]

set DPControls_GETCONTROLS(LOCK.STATE) [list LockControl_getStateControls]
set DPControls_GETCONTROLS(LOCK.OPEN) [list LockControl_getOpenControls]

#set DPControls_GETTOPCONTROLS(LOCK.OPEN) [list LockControl_getOpenControls]


set COMMANDS(lock_unlock) [list LockControl_unlock]
set COMMANDS(lock_lock)   [list LockControl_lock]
set COMMANDS(lock_open)   [list LockControl_open]

proc LockControl_getStateStatus { channelId dataPoint } {
	array set dp $dataPoint
	
	set    script "var dpId = \"$dp(ID)\";"
	append script {
		var dp = dom.GetObject(dpId);
		Write(dp.Value());
	}
	
	switch -exact -- [rega_exec $script] {
		false   { set status "Zu"}
		true    { set status "Auf"}
		default { set status "Unbekannt"}
	}
	
	set    result [status_separator]
	append result {<tr><td class="status">}
	append result {<div class="caption">Status</div>}
	append result "<div class=\"center\">$status</div>"
	append result {</td></tr>}
	
	return $result
}

proc LockControl_getUncertainStatus { channelId dataPoint } {
	array set dp $dataPoint
	
	set    script "var dpId = \"$dp(ID)\";"
	append script {
		var dp = dom.GetObject(dpId);
		Write(dp.Value());
	}
	
	set result ""
	if { "true" == [rega_exec $script] } {
		append result [status_separator]
		append result {<tr><td class="status">}
		append result {<div class="caption">Zustand unbestimmt</div>}
		append result {</td></tr>}
	}
	
	return $result
}

proc LockControl_getStateControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button "Auf" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=lock_unlock"]
	append result [button "Zu"  "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=lock_lock"]
	
	return $result

}

proc LockControl_getOpenControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button "T&uuml;r &ouml;ffnen" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=lock_open"]
	
	return $result
}

proc LockControl_unlock { } {
	global fav

	set    script "var channelId = \"$fav(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dpId = channel.DPByControl("LOCK.STATE");
		var dp = dom.GetObject(dpId);
		dp.State(true);
	}
	
	rega_exec $script
}

proc LockControl_lock { } {
	global fav
	
	set    script "var channelId = \"$fav(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dpId = channel.DPByControl("LOCK.STATE");
		var dp = dom.GetObject(dpId);
		dp.State(false);
	}
	
	rega_exec $script
}

proc LockControl_open { } {
	global fav
	
	set    script "var channelId = \"$fav(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dpId = channel.DPByControl("LOCK.OPEN");
		var dp = dom.GetObject(dpId);
		dp.State(1);
	}
	
	rega_exec $script
}
