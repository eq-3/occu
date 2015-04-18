#!/bin/tclsh

set DPControls_GETSTATUS(RHS.STATE) [list RHSControl_getStatus]

proc RHSControl_getStatus { channelId dataPoint } {
	array set dp $dataPoint
	
	set script "var dpId = \"$dp(ID)\";"
	append script {
		var dp = dom.GetObject(dpId);
		Write(dp.Value());
	}
	
	switch -exact -- [rega_exec $script] {
		0       { set status "Verriegelt" }
		1       { set status "Kippstellung" }
		2       { set status "Offen" }
		default { set status "unbekannt" }
	}
	
	set    result [status_separator]
	append result {<tr><td class="status">}
	append result {<div class="caption">Status</div>}
	append result "<div class=\"center\">$status</div>"
	append result {</td></tr>}
	return $result

}