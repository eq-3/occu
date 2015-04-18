#!/bin/tclsh
#Kanal-EasyMode!
source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

#set PROFILE_PNAME(Team) "Gruppenmitglieder"
set PROFILE_PNAME(Team) "\${SD_GroupMember}"


proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

	global iface_url ise_CHANNELNAMES 
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	
	set url $iface_url($iface)
	
	array set dev_descr [xmlrpc $url getDeviceDescription [list string $address]]

	puts "<script type=\"text/javascript\">getLangInfo_Special('SMOKE_DETECTOR.txt');</script>"

  append HTML_PARAMS(separate_1) "<div id=\"param_1\"><textarea id=\"profile_1\" style=\"display:none\" >"
	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\"><tr><th colspan=\"2\" style=\"text-align:center\">"
	append HTML_PARAMS(separate_1) "$PROFILE_PNAME(Team)"
	append HTML_PARAMS(separate_1) "</th></tr><tr></tr>"
	
	
	if { [info exist dev_descr(TEAM_CHANNELS)] } {
			foreach channel $dev_descr(TEAM_CHANNELS) {
				#append HTML_PARAMS(separate_1) "<tr><td>[cgi_quote_html $ise_CHANNELNAMES($iface;$channel)]</td> <td> Rauchmelder SN: $channel<br></td></tr>"
				append HTML_PARAMS(separate_1) "<tr><td>[cgi_quote_html $ise_CHANNELNAMES($iface;$channel)]</td> <td>\${SD_LblSmokeDetectorSN} [lindex [split $channel ":"] 0]<br/></td></tr>"
			}
		
	}
	
	append HTML_PARAMS(separate_1) "</table></textarea></div>"

	puts "<script type=\"text/javascript\">translate('1', '$special_input_id');</script>"
}

constructor
