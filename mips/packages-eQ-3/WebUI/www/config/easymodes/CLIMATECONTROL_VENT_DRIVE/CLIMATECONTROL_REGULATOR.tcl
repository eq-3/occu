#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${no_profile}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"no"
set PROFILE_0(UI_TEMPLATE)	"no"

set PROFILE_1(UI_HINT)	0
set PROFILE_1(UI_DESCRIPTION)	"no"
set PROFILE_1(UI_TEMPLATE)	"no"

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	
	global dev_descr_sender dev_descr_receiver IC_SETTINGS_VALUES 
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
	append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
	append HTML_PARAMS(separate_$prn) "</textarea></div>"
#1
	incr prn	
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn)	"\${hint_no_expert}<br/><br/>"
	append HTML_PARAMS(separate_$prn) "</textarea></div>"
	
	append HTML_PARAMS(separate_$prn) "<script type=\"text/javascript\">"
	append HTML_PARAMS(separate_$prn) "var elem = document.getElementById(\'receiver_profiles\');"

	append HTML_PARAMS(separate_$prn) "if ('$IC_SETTINGS_VALUES(EXPERTMODE)' == \"on\") {elem.selectedIndex = 1;} else {elem.selectIndex = 0;}"
	append HTML_PARAMS(separate_$prn) "elem.disabled = true;"
	append HTML_PARAMS(separate_$prn) "</script>"
}

constructor
