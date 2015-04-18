#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

#set PROFILES_MAP(0)	"Experte"
#set PROFILES_MAP(1)	"Kein Profil vorhanden!"

set multilingual 1

set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${no_profile}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)	"Expertenprofil"

set PROFILE_1(UI_HINT)	1
set PROFILE_1(UI_DESCRIPTION)	"no"
set PROFILE_1(UI_TEMPLATE)	"no"


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
	 		
	set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]
	

#	die Texte der Platzhalter einlesen
	puts "<script type=\"text/javascript\">getLangInfo_Special('SPECIAL.txt');</script>"
	set prn 0	
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
	append HTML_PARAMS(separate_$prn) "</textarea></div>"

	incr prn 
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn)	"\${hint_no_profile}<br/><br/>"
	append HTML_PARAMS(separate_$prn) "</textarea></div>"
	
}

constructor
