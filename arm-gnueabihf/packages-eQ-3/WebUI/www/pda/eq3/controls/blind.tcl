#!/bin/tclsh

set DPControls_GETSTATUS(BLIND.LEVEL)   [list BlindControl_getStatus]
set DPControls_GETCONTROLS(BLIND.LEVEL) [list BlindControl_getLevelControls]
#set DPControls_GETTOPCONTROLS(BLIND.LEVEL) [list BlindControl_getLevelTopControls]
set DPControls_GETCONTROLS(BLIND.STOP)  [list BlindControl_getStopControls]

set COMMANDS(bl_100)  [list BlindControl_bl_100]
set COMMANDS(bl_75)   [list BlindControl_bl_75]
set COMMANDS(bl_50)   [list BlindControl_bl_50]
set COMMANDS(bl_25)   [list BlindControl_bl_25]
set COMMANDS(bl_0)    [list BlindControl_bl_0]
set COMMANDS(bl_stop) [list BlindControl_bl_stop]

proc BlindControl_getStatus { channelId dataPoint } {
	array set dp $dataPoint
	
	set    script "var dpId = \"$dp(ID)\";"
	append script {
		var dp = dom.GetObject(dpId);
		var level = dp.Value() * 100;
		! Nachkommastellen abschneiden:
		level = 0 + level;
		Write(level);
	}
	set level [rega_exec $script]
	if { "" == $level } { set level "0" }
	
	set    result [status_separator]
	append result {<tr><td class="status">}
	append result {<div class="caption">Behanghöhe</div>}
	append result "<div class=\"center\">$level %</div>"
	append result {</td></tr>}
	return $result
}

proc BlindControl_getLevelTopControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button "Auf"  "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=bl_100"]
	
	return $result
}

proc BlindControl_getLevelControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button "Auf"  "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=bl_100"]
	append result [button "75 %" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=bl_75"]
	append result [button "50 %" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=bl_50"]
	append result [button "25 %" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=bl_25"]
	append result [button "Ab"   "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=bl_0"]
	
	return $result
}

proc BlindControl_getStopControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button "Stopp" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=bl_stop"]

	return $result
}

proc BlindControl_bl { channelId level } {
	set    script "var channelId = \"$channelId\";"
	append script "var level = $level;"
	append script {
		var channel = dom.GetObject(channelId);
		var dpId = channel.DPByControl("BLIND.LEVEL");
		var dp = dom.GetObject(dpId);
		dp.State(level);
	}
	
	rega_exec $script
}

proc BlindControl_bl_stop { } {
	global fav
	
	set    script "var channelId = \"$fav(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dpId = channel.DPByControl("BLIND.STOP");
		var dp = dom.GetObject(dpId);
		dp.State(1);
	}
	
	rega_exec $script
}

proc BlindControl_bl_100 { } {
	global fav
	BlindControl_bl $fav(ID) 1.00
}

proc BlindControl_bl_75 { } {
	global fav
	BlindControl_bl $fav(ID) 0.75
}

proc BlindControl_bl_50 { } {
	global fav
	BlindControl_bl $fav(ID) 0.50
}

proc BlindControl_bl_25 { } {
	global fav
	BlindControl_bl $fav(ID) 0.25
}

proc BlindControl_bl_0 { } {
	global fav
	BlindControl_bl $fav(ID) 0.00
}
