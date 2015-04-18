#!/bin/tclsh

set DPControls_GETSTATUS(DOOR_SENSOR.STATE) [list DoorSensorControl_getStatus]

proc DoorSensorControl_getStatus { channelId dataPoint } {
	array set dp $dataPoint
	
	set    script "var dpId = \"$dp(ID)\";"
	append script {
		var dp = dom.GetObject(dpId);
		Write(dp.Value());
	}
	
	switch -exact -- [rega_exec $script] {
		false		{ set status "Verschlossen"}
		true		{ set status "Offen"}
		default	{ set status "unbekannt" }
	}
	
	set    result [status_separator]
	append result {<tr><td class="status">}
	append result {<div class="caption">Status</div>}
	append result "<div class=\"center\">$status</div>"
	append result {</td></tr>}
	return $result

}
