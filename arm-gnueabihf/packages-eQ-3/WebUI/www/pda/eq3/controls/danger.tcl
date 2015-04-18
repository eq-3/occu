#!/bin/tclsh

set DPControls_GETSTATUS(DANGER.STATE) [list DangerControl_getStatus]

proc DangerControl_getStatus { channelId dataPoint } {
	array set dp $dataPoint
	
	set    script "var dpId = \"$dp(ID)\";"
	append script {
		var dp = dom.GetObject(dpId);
		Write(dp.Value());
	}
	
	switch -exact -- [rega_exec $script] {
		false		{ set status "OK"}
		true		{ set status "Gefahr"}
		default	{ set status "unbekannt" }
	}
	
	set    result [status_separator]
	append result {<tr><td class="status">}
	append result {<div class="caption">Status</div>}
	append result "<div class=\"center\">$status</div>"
	append result {</td></tr>}
	return $result

}
