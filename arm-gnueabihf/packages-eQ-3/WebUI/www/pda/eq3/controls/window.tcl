#!/bin/tclsh

set DPControls_GETSTATUS(WINDOW.LEVEL)     [list WindowControl_getLevelStatus]
set DPControls_GETSTATUS(WINDOW.UNCERTAIN) [list WindowControl_getUncertainStatus]

set DPControls_GETCONTROLS(WINDOW.LEVEL) [list WindowControls_getLevelControls]
set DPControls_GETCONTROLS(WINDOW.STOP)  [list WindowControls_getStopControls]

#set DPControls_GETTOPCONTROLS(WINDOW.LEVEL) [list WindowControls_getLevelTopControls]

set COMMANDS(win_100)  [list WindowControl_open_100]
set COMMANDS(win_75)   [list WindowControl_open_75]
set COMMANDS(win_50)   [list WindowControl_open_50]
set COMMANDS(win_25)   [list WindowControl_open_25]
set COMMANDS(win_0)    [list WindowControl_open_0]
set COMMANDS(win_lock) [list WindowControl_lock]
set COMMANDS(win_stop) [list WindowControl_stop]

proc WindowControl_getLevelStatus { channelId dataPoint } {
	array set dp $dataPoint
	
	set    script  "var dpId = \"$dp(ID)\";"
	append script {
		var dp = dom.GetObject(dpId);
		var value = dp.Value();
		Write(value.ToString(3));
	}
	
	set level [rega_exec $script]
	if { 0 < $level } {
		set level [expr round($level * 100)]
		set status "Gekippt ($level %)" 
	}	else {
		set status "Zu"
		if { 0 > $level } { append status " (verriegelt)" }
	}
	
	set result [status_separator]
	append result {<tr><td class="status">}
	append result {<div class="caption">Status</div>}
	append result "<div class=\"center\">$status</div>"
	append result {</td></tr>}
	
	return $result
}

proc WindowControl_getUncertainStatus { channelId dataPoint } {
	array set dp $dataPoint
	
	set script "var dpId = \"$dp(ID)\";"
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

proc WindowControls_getLevelTopControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button Gekippt "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=win_100"]
	return $result
}

proc WindowControls_getLevelControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button Gekippt "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=win_100"]
	append result [button "75 %" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=win_75"]
	append result [button "50 %" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=win_50"]
	append result [button "25 %" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=win_25"]
	append result [button "Zu"   "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=win_0"]
	append result [button "Verriegeln" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=win_lock"]
	
	return $result
}

proc WindowControls_getStopControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button "Stopp" "$UI_URLBASE/fav.cgi?sid=$sid&favListId=$favListId&favId=$favId&cmd=win_stop"]
	
	return $result

}

proc WindowControl_open { channelId level } {
	set    script "var channelId = \"$channelId\";"
	append script "var level = $level;"
	append script {
		var channel = dom.GetObject(channelId);
		var dpId = channel.DPByControl("WINDOW.LEVEL");
		var dp = dom.GetObject(dpId);
		dp.State(level);
	}
	
	rega_exec $script
}

proc WindowControl_open_100 { } {
	global fav
	WindowControl_open $fav(ID) 1.00
}

proc WindowControl_open_75 { } {
	global fav
	WindowControl_open $fav(ID) 0.75
}

proc WindowControl_open_50 { } {
	global fav
	WindowControl_open $fav(ID) 0.50
}

proc WindowControl_open_25 { } {
	global fav
	WindowControl_open $fav(ID) 0.25
}

proc WindowControl_open_0 { } {
	global fav
	WindowControl_open $fav(ID) 0.00
}

proc WindowControl_lock { } {
	global fav
	WindowControl_open $fav(ID) -0.05
}

proc WindowControl_stop { } {
	global fav
	
	set    script "var channelId = \"$fav(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dpId = channel.DPByControl("WINDOW.STOP");
		var dp = dom.GetObject(dpId);
		dp.State(1);
	}
	
	rega_exec $script
}
