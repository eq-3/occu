#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${door_unlock}"
set PROFILES_MAP(2)	"\${door_lock}"
set PROFILES_MAP(3)	"\${door_open}"
set PROFILES_MAP(4)	"\${door_lock_unlock}"
set PROFILES_MAP(5)	"\${door_lock_open}"
set PROFILES_MAP(6)	"\${door_unlock_open}" 
set PROFILES_MAP(7) "\${door_lock_toggle}"


set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)		"Expertenprofil"

# hier folgen die verschiedenen Profile
set PROFILE_1(LONG_COND_VALUE_HI)	100
set PROFILE_1(LONG_COND_VALUE_LO)	50
set PROFILE_1(LONG_CT_OFF)			0
set PROFILE_1(LONG_CT_ON)			0
set PROFILE_1(LONG_JT_OFF)			3
set PROFILE_1(LONG_JT_ON)			3
set PROFILE_1(LONG_ON_TIME)			111600
set PROFILE_1(SHORT_COND_VALUE_HI)	100
set PROFILE_1(SHORT_COND_VALUE_LO)	50
set PROFILE_1(SHORT_CT_OFF)			0
set PROFILE_1(SHORT_CT_ON)			0
set PROFILE_1(SHORT_JT_OFF)			3
set PROFILE_1(SHORT_JT_ON)			3
set PROFILE_1(SHORT_ON_TIME)		111600
set PROFILE_1(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird die T&uuml;r entriegelt. Nach der eingestellten Zeit wird die T&uuml;r automatisch wieder verriegelt."
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)	1

set PROFILE_2(LONG_COND_VALUE_HI)	100
set PROFILE_2(LONG_COND_VALUE_LO)	50
set PROFILE_2(LONG_CT_OFF)			0
set PROFILE_2(LONG_CT_ON)			0
set PROFILE_2(LONG_JT_OFF)			6 
set PROFILE_2(LONG_JT_ON)			6
set PROFILE_2(LONG_ON_TIME)			111600
set PROFILE_2(SHORT_COND_VALUE_HI)	100
set PROFILE_2(SHORT_COND_VALUE_LO)	50
set PROFILE_2(SHORT_CT_OFF)			0
set PROFILE_2(SHORT_CT_ON)			0
set PROFILE_2(SHORT_JT_OFF)			6 
set PROFILE_2(SHORT_JT_ON)			6 
set PROFILE_2(SHORT_ON_TIME)		111600
set PROFILE_2(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird die T&uuml;r verriegelt."
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)	2

set PROFILE_3(LONG_COND_VALUE_HI)	100
set PROFILE_3(LONG_COND_VALUE_LO)	50
set PROFILE_3(LONG_CT_OFF)			0
set PROFILE_3(LONG_CT_ON)			0
set PROFILE_3(LONG_JT_OFF)			7
set PROFILE_3(LONG_JT_ON)			7
set PROFILE_3(LONG_ON_TIME)			111600
set PROFILE_3(SHORT_COND_VALUE_HI)	100
set PROFILE_3(SHORT_COND_VALUE_LO)	50
set PROFILE_3(SHORT_CT_OFF)			0
set PROFILE_3(SHORT_CT_ON)			0
set PROFILE_3(SHORT_JT_OFF)			7
set PROFILE_3(SHORT_JT_ON)			7
set PROFILE_3(SHORT_ON_TIME)		111600
set PROFILE_3(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird die T&uuml;r ge&ouml;ffnet. Nach der eingestellten Zeit wird die T&uuml;r automatisch wieder verriegelt."
set PROFILE_3(UI_TEMPLATE)		$PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)	3

set PROFILE_4(LONG_COND_VALUE_HI)	100 
set PROFILE_4(LONG_COND_VALUE_LO)	50
set PROFILE_4(LONG_CT_OFF)			0
set PROFILE_4(LONG_CT_ON)			0
set PROFILE_4(LONG_JT_OFF)			3
set PROFILE_4(LONG_JT_ON)			3 
set PROFILE_4(LONG_ON_TIME)			111600
set PROFILE_4(SHORT_COND_VALUE_HI)	100 
set PROFILE_4(SHORT_COND_VALUE_LO)	50
set PROFILE_4(SHORT_CT_OFF)			0
set PROFILE_4(SHORT_CT_ON)			0
set PROFILE_4(SHORT_JT_OFF)			6 
set PROFILE_4(SHORT_JT_ON)			6 
set PROFILE_4(SHORT_ON_TIME)		111600
set PROFILE_4(UI_DESCRIPTION)	"Mit einem kurzen Tastendruck wird die T&uuml;r verriegelt. Mit einem langen Tastendruck wird die T&uuml;r entriegelt. Nach der eingestellten Zeit wird die T&uuml;r automatisch wieder verriegelt."
set PROFILE_4(UI_TEMPLATE)		$PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)	4

set PROFILE_5(LONG_COND_VALUE_HI)	100
set PROFILE_5(LONG_COND_VALUE_LO)	50
set PROFILE_5(LONG_CT_OFF)			0
set PROFILE_5(LONG_CT_ON)			0
set PROFILE_5(LONG_JT_OFF)			7
set PROFILE_5(LONG_JT_ON)			7
set PROFILE_5(LONG_ON_TIME)			111600
set PROFILE_5(SHORT_COND_VALUE_HI)	100
set PROFILE_5(SHORT_COND_VALUE_LO)	50
set PROFILE_5(SHORT_CT_OFF)			0
set PROFILE_5(SHORT_CT_ON)			0
set PROFILE_5(SHORT_JT_OFF)			6
set PROFILE_5(SHORT_JT_ON)			6
set PROFILE_5(SHORT_ON_TIME)		111600
set PROFILE_5(UI_DESCRIPTION)	"Mit einem kurzen Tastendruck wird die T&uuml;r verriegelt. Mit einem langen Tastendruck wird die T&uuml;r ge&ouml;ffnet. Nach der eingestellten Zeit wird die T&uuml;r automatisch wieder verriegelt."
set PROFILE_5(UI_TEMPLATE)		$PROFILE_5(UI_DESCRIPTION)
set PROFILE_5(UI_HINT)	5

set PROFILE_6(LONG_COND_VALUE_HI)	100
set PROFILE_6(LONG_COND_VALUE_LO)	50
set PROFILE_6(LONG_CT_OFF)			0
set PROFILE_6(LONG_CT_ON)			0
set PROFILE_6(LONG_JT_OFF)			7
set PROFILE_6(LONG_JT_ON)			7
set PROFILE_6(LONG_ON_TIME)			111600
set PROFILE_6(SHORT_COND_VALUE_HI)	100
set PROFILE_6(SHORT_COND_VALUE_LO)	50
set PROFILE_6(SHORT_CT_OFF)			0
set PROFILE_6(SHORT_CT_ON)			0
set PROFILE_6(SHORT_JT_OFF)			3
set PROFILE_6(SHORT_JT_ON)			3
set PROFILE_6(SHORT_ON_TIME)		111600
set PROFILE_6(UI_DESCRIPTION)	"Mit einem kurzen Tastendruck wird die T&uuml;r entriegelt. Mit einem langen Tastendruck wird die T&uuml;r ge&ouml;ffnet. Nach der eingestellten Zeit wird die T&uuml;r automatisch wieder verriegelt."
set PROFILE_6(UI_TEMPLATE)		$PROFILE_6(UI_DESCRIPTION)
set PROFILE_6(UI_HINT)	6

set PROFILE_7(LONG_COND_VALUE_HI)	100 
set PROFILE_7(LONG_COND_VALUE_LO)	50
set PROFILE_7(LONG_CT_OFF)			0
set PROFILE_7(LONG_CT_ON)			0
set PROFILE_7(LONG_JT_OFF)			3
set PROFILE_7(LONG_JT_ON)			6 
set PROFILE_7(LONG_ON_TIME)			111600
set PROFILE_7(SHORT_COND_VALUE_HI)	100 
set PROFILE_7(SHORT_COND_VALUE_LO)	50
set PROFILE_7(SHORT_CT_OFF)			0
set PROFILE_7(SHORT_CT_ON)			0
set PROFILE_7(SHORT_JT_OFF)			3 
set PROFILE_7(SHORT_JT_ON)			6 
set PROFILE_7(SHORT_ON_TIME)		111600
set PROFILE_7(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird die T&uuml;r, je nach aktuellem Zustand, entweder ent- oder verriegelt."
set PROFILE_7(UI_TEMPLATE)		$PROFILE_7(UI_DESCRIPTION)
set PROFILE_7(UI_HINT)	7

# hier folgen die eventuellen Subsets

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	
	global dev_descr_sender dev_descr_receiver  
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps      
	upvar $pps_descr    ps_descr
	
	foreach pro [array names PROFILES_MAP] {
		upvar PROFILE_$pro PROFILE_$pro
	}
	 		
	set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]
	
	#global SUBSETS
	set name "x"
	set i 1
	while {$name != ""} {
		upvar SUBSET_$i SUBSET_$i
		array set subset [array get SUBSET_$i]
		set name ""
		catch {set name $subset(NAME)}
		array_clear subset
		incr i
	}

#	die Texte der Platzhalter einlesen
	puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
	set prn 0	
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
	append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}<br/><br/>"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${AUTO_LOCK_TIME}</td><td>"
	option DOOR_LOCK_TIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#2
	incr prn 
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}<br/><br/>"
	append HTML_PARAMS(separate_$prn)	"</textarea></div>"
#3	
	incr prn 
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}<br/><br/>"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${AUTO_LOCK_TIME}</td><td>"
	option DOOR_LOCK_TIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#4
	incr prn 
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}<br/><br/>"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${AUTO_LOCK_TIME}</td><td>"
	option DOOR_LOCK_TIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#5
	incr prn 
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}<br/><br/>"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${AUTO_LOCK_TIME}</td><td>"
	option DOOR_LOCK_TIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#6
	incr prn 
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}<br/><br/>"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${AUTO_LOCK_TIME}</td><td>"
	option DOOR_LOCK_TIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#7	
	incr prn 
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}<br/><br/>"
	append HTML_PARAMS(separate_$prn) "</textarea></div>"
}

constructor
