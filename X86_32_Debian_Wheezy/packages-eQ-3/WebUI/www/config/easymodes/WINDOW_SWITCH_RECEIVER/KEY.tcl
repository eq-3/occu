#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]


set PROFILES_MAP(0)	"\${no_profile}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"no"
set PROFILE_0(UI_TEMPLATE)	"no"


proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	
	global dev_descr_sender dev_descr_receiver  
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar $pps          ps      
	upvar $pps_descr    ps_descr
	upvar prn prn
	
	foreach pro [array names PROFILES_MAP] {
		upvar PROFILE_$pro PROFILE_$pro
	}

#	die Texte der Platzhalter einlesen
	puts "<script type=\"text/javascript\">getLangInfo_Special('SPECIAL.txt');</script>"
	set prn 0	
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn)	"\${hint_no_expert}<br/><br/>"
	append HTML_PARAMS(separate_$prn) "</textarea></div>"
	
}

constructor
