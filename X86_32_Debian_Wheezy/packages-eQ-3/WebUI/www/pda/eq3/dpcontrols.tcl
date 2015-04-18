#!/bin/tclsh

set CONTROL_FILES $UI_DIRBASE/eq3/controls/*.tcl

array set DPControls_GETSTATUS {}
array set DPControls_GETCONTROLS {}
array set DPControls_GETTOPCONTROLS {}

proc DPControls_getStatus {channelId dataPoint} {
	global DPControls_GETSTATUS
	array set dp $dataPoint

	if { [info exists DPControls_GETSTATUS($dp(CONTROL))] } then {
		return [$DPControls_GETSTATUS($dp(CONTROL)) $channelId $dataPoint]
	} else {
		return ""
	}
}

proc DPControls_getControls { channelId dataPoint } {
	global DPControls_GETCONTROLS
	array set dp $dataPoint
	
	if { [info exists DPControls_GETCONTROLS($dp(CONTROL))] } then {
		return [$DPControls_GETCONTROLS($dp(CONTROL)) $channelId $dataPoint]
	} else {
		return ""
	}
}

proc DPControls_getTopControls { channelId dataPoint } {
	global DPControls_GETTOPCONTROLS
	array set dp $dataPoint
	
	if { [info exists DPControls_GETTOPCONTROLS($dp(CONTROL))] } then {
		return [$DPControls_GETTOPCONTROLS($dp(CONTROL)) $channelId $dataPoint]
	} else {
		return ""
	}
}

foreach filename [glob -nocomplain -- $CONTROL_FILES] {
	source $filename
}

