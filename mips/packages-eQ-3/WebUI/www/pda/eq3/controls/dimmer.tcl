#!/bin/tclsh

set DPControls_GETSTATUS(DIMMER.LEVEL)   [list DimmerControl_getStatus]
set DPControls_GETCONTROLS(DIMMER.LEVEL) [list DimmerControl_getControls]
#set DPControls_GETTOPCONTROLS(DIMMER.LEVEL) [list DimmerControl_getTopControls]

set COMMANDS(dim100) [list DimmerControl_dim100]
set COMMANDS(dim75)  [list DimmerControl_dim75]
set COMMANDS(dim50)  [list DimmerControl_dim50]
set COMMANDS(dim25)  [list DimmerControl_dim25]
set COMMANDS(dim0)   [list DimmerControl_dim0]

proc DimmerControl_getStatus { channelId dataPoint } {
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
	append result {<div class="caption">Dimmwert</div>}
	append result "<div class=\"center\">$level %</div>"
	append result {</td></tr>}
	return $result
}

proc DimmerControl_getTopControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button "Ein"  "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=dim100"]
	
	return $result
}


proc DimmerControl_getControls { channelId dataPoint } {
	global sid favListId favId UI_URLBASE
	set result ""
	
	append result [button "Ein"  "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=dim100"]
	append result [button "75 %" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=dim75"]
	append result [button "50 %" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=dim50"]
	append result [button "25 %" "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=dim25"]
	append result [button "Aus"  "$UI_URLBASE/fav.cgi?sid=$sid&uiStyle=[getUIStyle]&favListId=$favListId&favId=$favId&cmd=dim0"]
	
	return $result
}

proc DimmerControl_dim { channelId level } {
	set    script "var channelId = \"$channelId\";"
	append script "var level = $level;"
	append script {
		var channel = dom.GetObject(channelId);
		var dpId = channel.DPByControl("DIMMER.LEVEL"); 
		var dp = dom.GetObject(dpId);
		dp.State(level);
	}
	
	rega_exec $script
}

proc DimmerControl_dim100 { } {
	global fav
	DimmerControl_dim $fav(ID) 1.00;
}

proc DimmerControl_dim75 { } {
	global fav
	DimmerControl_dim $fav(ID) 0.75;
}

proc DimmerControl_dim50 { } {
	global fav
	DimmerControl_dim $fav(ID) 0.50;
}

proc DimmerControl_dim25 { } {
	global fav
	DimmerControl_dim $fav(ID) 0.25;
}

proc DimmerControl_dim0 { } {
	global fav
	DimmerControl_dim $fav(ID) 0.00;
}

