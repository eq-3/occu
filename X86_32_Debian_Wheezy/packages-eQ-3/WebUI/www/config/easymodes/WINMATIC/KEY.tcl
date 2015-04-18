#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]


set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${window_tilt}"
set PROFILES_MAP(2)	"\${window_close}"
set PROFILES_MAP(3)	"\${window_tilt_close}"
set PROFILES_MAP(4)	"\${window_airing}" 

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)		"Expertenprofil"

# hier folgen die verschiedenen Profile
set PROFILE_1(LONG_COND_TYPE_AD)	0
set PROFILE_1(LONG_COND_TYPE_AR)	0
set PROFILE_1(LONG_COND_TYPE_ED)	0
set PROFILE_1(LONG_COND_TYPE_ER)	0
set PROFILE_1(LONG_COND_VALUE_HI)	100
set PROFILE_1(LONG_COND_VALUE_LO)	50
set PROFILE_1(LONG_JT_OFF)			2
set PROFILE_1(LONG_JT_ON)			2
set PROFILE_1(LONG_JT_RAMPOFF)		6
set PROFILE_1(LONG_JT_RAMPON)		7
set PROFILE_1(LONG_OFF_LEVEL)		-0.005
set PROFILE_1(LONG_OFF_TIME)		111600.0
set PROFILE_1(LONG_ON_LEVEL)		1
set PROFILE_1(LONG_ON_TIME)			111600.0
set PROFILE_1(LONG_RAMPOFF_SPEED)	1
set PROFILE_1(LONG_RAMPON_SPEED)	1
set PROFILE_1(SHORT_COND_TYPE_AD)	0
set PROFILE_1(SHORT_COND_TYPE_AR)	0
set PROFILE_1(SHORT_COND_TYPE_ED)	0
set PROFILE_1(SHORT_COND_TYPE_ER)	0
set PROFILE_1(SHORT_COND_VALUE_HI)	100
set PROFILE_1(SHORT_COND_VALUE_LO)	50
set PROFILE_1(SHORT_JT_OFF)			2
set PROFILE_1(SHORT_JT_ON)			2
set PROFILE_1(SHORT_JT_RAMPOFF)		6
set PROFILE_1(SHORT_JT_RAMPON)		7
set PROFILE_1(SHORT_OFF_LEVEL)		-0.005
set PROFILE_1(SHORT_OFF_TIME)		111600.0
set PROFILE_1(SHORT_ON_LEVEL)		1
set PROFILE_1(SHORT_ON_TIME)		111600.0
set PROFILE_1(SHORT_RAMPOFF_SPEED)	1
set PROFILE_1(SHORT_RAMPON_SPEED)	1
set PROFILE_1(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird das Fenster mit der eingestellten Geschwindigkeit auf die eingestellte Kippweite gekippt."
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)	1

set PROFILE_2(LONG_COND_TYPE_AD)	0
set PROFILE_2(LONG_COND_TYPE_AR)	0
set PROFILE_2(LONG_COND_TYPE_ED)	0
set PROFILE_2(LONG_COND_TYPE_ER)	0
set PROFILE_2(LONG_COND_VALUE_HI)	100
set PROFILE_2(LONG_COND_VALUE_LO)	50
set PROFILE_2(LONG_JT_OFF)			5
set PROFILE_2(LONG_JT_ON)			5
set PROFILE_2(LONG_JT_RAMPOFF)		{7 8}
set PROFILE_2(LONG_JT_RAMPON)		3
set PROFILE_2(LONG_OFF_LEVEL)		-0.005
set PROFILE_2(LONG_OFF_TIME)		111600.0
set PROFILE_2(LONG_ON_LEVEL)		1
set PROFILE_2(LONG_ON_TIME)			111600.0
set PROFILE_2(LONG_RAMPOFF_SPEED)	1
set PROFILE_2(LONG_RAMPON_SPEED)	1
set PROFILE_2(SHORT_COND_TYPE_AD)	0
set PROFILE_2(SHORT_COND_TYPE_AR)	0
set PROFILE_2(SHORT_COND_TYPE_ED)	0
set PROFILE_2(SHORT_COND_TYPE_ER)	0
set PROFILE_2(SHORT_COND_VALUE_HI)	100
set PROFILE_2(SHORT_COND_VALUE_LO)	50
set PROFILE_2(SHORT_JT_OFF)			5
set PROFILE_2(SHORT_JT_ON)			5
set PROFILE_2(SHORT_JT_RAMPOFF)		{7 8}
set PROFILE_2(SHORT_JT_RAMPON)		3
set PROFILE_2(SHORT_OFF_LEVEL)		-0.005
set PROFILE_2(SHORT_OFF_TIME)		111600.0
set PROFILE_2(SHORT_ON_LEVEL)		1
set PROFILE_2(SHORT_ON_TIME)		111600.0
set PROFILE_2(SHORT_RAMPOFF_SPEED)	1
set PROFILE_2(SHORT_RAMPON_SPEED)	1
set PROFILE_2(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird das Fenster mit der eingestellten Geschwindigkeit geschlossen und je nach Einstellung auch verriegelt."
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)	2

set PROFILE_3(LONG_COND_TYPE_AD)	0
set PROFILE_3(LONG_COND_TYPE_AR)	0
set PROFILE_3(LONG_COND_TYPE_ED)	0
set PROFILE_3(LONG_COND_TYPE_ER)	0
set PROFILE_3(LONG_COND_VALUE_HI)	100
set PROFILE_3(LONG_COND_VALUE_LO)	50
set PROFILE_3(LONG_JT_OFF)			2
set PROFILE_3(LONG_JT_ON)			5
set PROFILE_3(LONG_JT_RAMPOFF)		2
set PROFILE_3(LONG_JT_RAMPON)		5
set PROFILE_3(LONG_OFF_LEVEL)		-0.005
set PROFILE_3(LONG_OFF_TIME)		111600.0
set PROFILE_3(LONG_ON_LEVEL)		1
set PROFILE_3(LONG_ON_TIME)			111600.0
set PROFILE_3(LONG_RAMPOFF_SPEED)	1
set PROFILE_3(LONG_RAMPON_SPEED)	1
set PROFILE_3(SHORT_COND_TYPE_AD)	0
set PROFILE_3(SHORT_COND_TYPE_AR)	0
set PROFILE_3(SHORT_COND_TYPE_ED)	0
set PROFILE_3(SHORT_COND_TYPE_ER)	0
set PROFILE_3(SHORT_COND_VALUE_HI)	100
set PROFILE_3(SHORT_COND_VALUE_LO)	50
set PROFILE_3(SHORT_JT_OFF)			2
set PROFILE_3(SHORT_JT_ON)			5
set PROFILE_3(SHORT_JT_RAMPOFF)		2
set PROFILE_3(SHORT_JT_RAMPON)		5
set PROFILE_3(SHORT_OFF_LEVEL)		-0.005
set PROFILE_3(SHORT_OFF_TIME)		111600.0
set PROFILE_3(SHORT_ON_LEVEL)		1
set PROFILE_3(SHORT_ON_TIME)		111600.0
set PROFILE_3(SHORT_RAMPOFF_SPEED)	1
set PROFILE_3(SHORT_RAMPON_SPEED)	1
set PROFILE_3(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird das Fenster je nach aktuellem Zustand mit der eingestellten Geschwindigkeit auf die eingestellte Kippweite gekippt oder geschlossen und je nach Einstellung auch verriegelt (Togglefunktion)."
set PROFILE_3(UI_TEMPLATE)		$PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)	3

set PROFILE_4(LONG_COND_TYPE_AD)	0
set PROFILE_4(LONG_COND_TYPE_AR)	0
set PROFILE_4(LONG_COND_TYPE_ED)	0
set PROFILE_4(LONG_COND_TYPE_ER)	0
set PROFILE_4(LONG_COND_VALUE_HI)	100
set PROFILE_4(LONG_COND_VALUE_LO)	50
set PROFILE_4(LONG_JT_OFF)			2
set PROFILE_4(LONG_JT_ON)			2
set PROFILE_4(LONG_JT_RAMPOFF)		6
set PROFILE_4(LONG_JT_RAMPON)		7
set PROFILE_4(LONG_OFF_LEVEL)		-0.005
set PROFILE_4(LONG_OFF_TIME)		111600.0
set PROFILE_4(LONG_ON_LEVEL)		1
set PROFILE_4(LONG_ON_TIME)			900
set PROFILE_4(LONG_RAMPOFF_SPEED)	1
set PROFILE_4(LONG_RAMPON_SPEED)	1
set PROFILE_4(SHORT_COND_TYPE_AD)	0
set PROFILE_4(SHORT_COND_TYPE_AR)	0
set PROFILE_4(SHORT_COND_TYPE_ED)	0
set PROFILE_4(SHORT_COND_TYPE_ER)	0
set PROFILE_4(SHORT_COND_VALUE_HI)	100
set PROFILE_4(SHORT_COND_VALUE_LO)	50
set PROFILE_4(SHORT_JT_OFF)			2
set PROFILE_4(SHORT_JT_ON)			2
set PROFILE_4(SHORT_JT_RAMPOFF)		6
set PROFILE_4(SHORT_JT_RAMPON)		7
set PROFILE_4(SHORT_OFF_LEVEL)		-0.005
set PROFILE_4(SHORT_OFF_TIME)		111600.0
set PROFILE_4(SHORT_ON_LEVEL)		1
set PROFILE_4(SHORT_ON_TIME)		900
set PROFILE_4(SHORT_RAMPOFF_SPEED)	1
set PROFILE_4(SHORT_RAMPON_SPEED)	1
set PROFILE_4(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird das Fenster mit der eingestellten Geschwindigkeit auf die eingestellte Kippweite gekippt und nach der eingestellten Zeit wieder geschlossen und je nach Einstellung auch verriegelt."
set PROFILE_4(UI_TEMPLATE)		$PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)	4

# hier folgen die eventuellen Subsets

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

	global receiver_address dev_descr_sender dev_descr_receiver
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
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_OPEN_LEVEL}</td><td>"
	option WINDOW_OPEN_LEVEL
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_RUNNING_SPEED}&nbsp;\${when_tilting}</td><td>"
	option WINDOW_RUNNING_SPEED
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPON_SPEED|LONG_RAMPON_SPEED separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPON_SPEED]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#2
	incr prn 
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${ACTION}</td><td>"
	array_clear options
	set options(0) "\${only_close}"
	set options(-0.005) "\${close_lock}"
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL|LONG_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_RUNNING_SPEED}&nbsp;\${when_closing}</td><td>"
	option WINDOW_RUNNING_SPEED
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPOFF_SPEED|LONG_RAMPOFF_SPEED separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPOFF_SPEED]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#3
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_OPEN_LEVEL}</td><td>"
	option WINDOW_OPEN_LEVEL
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_RUNNING_SPEED}&nbsp;\${when_tilting}</td><td>"
	option WINDOW_RUNNING_SPEED
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPON_SPEED|LONG_RAMPON_SPEED separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPON_SPEED]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 3	
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ACTION}&nbsp;\${when_closing}</td><td>"
	array_clear options
	set options(0) "\${only_close}"
	set options(-0.005) "\${close_lock}"
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL|LONG_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 4
	append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_RUNNING_SPEED}&nbsp;\${when_closing}</td><td>"
	option WINDOW_RUNNING_SPEED
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPOFF_SPEED|LONG_RAMPOFF_SPEED separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPOFF_SPEED]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#4
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_OPEN_LEVEL}</td><td>"
	option WINDOW_OPEN_LEVEL
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_RUNNING_SPEED}&nbsp;\${when_tilting}</td><td>"
	option WINDOW_RUNNING_SPEED
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPON_SPEED|LONG_RAMPON_SPEED separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPON_SPEED]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 3
	append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_OPEN_TIME}</td><td>"
	option WINDOW_OPEN_TIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 4
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ACTION}&nbsp;\${past_exposure_time}</td><td>"
	array_clear options
	set options(0) "\${only_close}"
	set options(-0.005) "\${close_lock}"
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL|LONG_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 5
	append HTML_PARAMS(separate_$prn) "<tr><td>\${WINDOW_RUNNING_SPEED}&nbsp;\${when_closing}</td><td>"
	option WINDOW_RUNNING_SPEED
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPOFF_SPEED|LONG_RAMPOFF_SPEED separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPOFF_SPEED]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"	
}

constructor
