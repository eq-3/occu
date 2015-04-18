#!/bin/tclsh

set DPControls_GETSTATUS(SYSVAR) [list SVControl_getStatus]

proc SVControl_getStatus { channelId dataPoint } {
	array set dp $dataPoint
	
	set result [status_separator]
	append result {<tr><td class="status">}
	append result "<div class=\"caption\">$dp(NAME)</div>"
	append result "<div class=\"center\">[SysVar_getValue $dp(ID)]</div>"
	append result {</td></tr>}
	
	return $result
}

