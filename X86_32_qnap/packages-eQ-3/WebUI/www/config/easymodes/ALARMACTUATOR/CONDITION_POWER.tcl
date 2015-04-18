#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_alarmactuator.tcl]



set PROFILES_MAP(0) "\${expert}"
set PROFILES_MAP(1) "\${alarm_on_hi}"
set PROFILES_MAP(2) "\${alarm_on_lo}"
set PROFILES_MAP(3) "\${alarm_on}"
set PROFILES_MAP(4) "\${alarm_on_off}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)	"Expertenprofil"

# hier folgen die verschiedenen Profile
set PROFILE_1(SHORT_CT_OFFDELAY)	0
set PROFILE_1(SHORT_CT_ONDELAY)		0
set PROFILE_1(SHORT_CT_OFF)			0
set PROFILE_1(SHORT_CT_ON)			0
set PROFILE_1(SHORT_COND_VALUE_LO)	50
set PROFILE_1(SHORT_COND_VALUE_HI)	100
set PROFILE_1(SHORT_ONDELAY_TIME)		0
set PROFILE_1(SHORT_ON_TIME)		{120 300}
set PROFILE_1(SHORT_OFFDELAY_TIME)		0
set PROFILE_1(SHORT_ACTION_TYPE)	1
set PROFILE_1(SHORT_JT_OFF)			1
set PROFILE_1(SHORT_JT_ON)			0
set PROFILE_1(SHORT_JT_OFFDELAY)	0
set PROFILE_1(SHORT_JT_ONDELAY)		0
set PROFILE_1(UI_DESCRIPTION)	""
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)	1

set PROFILE_2(SHORT_CT_OFFDELAY)	2
set PROFILE_2(SHORT_CT_ONDELAY)		2
set PROFILE_2(SHORT_CT_OFF)			2
set PROFILE_2(SHORT_CT_ON)			2
set PROFILE_2(SHORT_COND_VALUE_LO)	50
set PROFILE_2(SHORT_COND_VALUE_HI)	100
set PROFILE_2(SHORT_ONDELAY_TIME)		0
set PROFILE_2(SHORT_ON_TIME)		{120 300}
set PROFILE_2(SHORT_OFFDELAY_TIME)		0
set PROFILE_2(SHORT_ACTION_TYPE)	1
set PROFILE_2(SHORT_JT_OFF)			1
set PROFILE_2(SHORT_JT_ON)			0
set PROFILE_2(SHORT_JT_OFFDELAY)	0
set PROFILE_2(SHORT_JT_ONDELAY)		0
set PROFILE_2(UI_DESCRIPTION)	""
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)	2

set PROFILE_3(SHORT_CT_OFFDELAY)	5
set PROFILE_3(SHORT_CT_ONDELAY)		5
set PROFILE_3(SHORT_CT_OFF)			5
set PROFILE_3(SHORT_CT_ON)			5
set PROFILE_3(SHORT_COND_VALUE_LO)	50
set PROFILE_3(SHORT_COND_VALUE_HI)	100
set PROFILE_3(SHORT_ONDELAY_TIME)		0
set PROFILE_3(SHORT_ON_TIME)		{120 300}
set PROFILE_3(SHORT_OFFDELAY_TIME)		0
set PROFILE_3(SHORT_ACTION_TYPE)	1
set PROFILE_3(SHORT_JT_OFF)			1
set PROFILE_3(SHORT_JT_ON)			0
set PROFILE_3(SHORT_JT_OFFDELAY)	0
set PROFILE_3(SHORT_JT_ONDELAY)		0
set PROFILE_3(UI_DESCRIPTION)	""
set PROFILE_3(UI_TEMPLATE)		$PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)	3

set PROFILE_4(SHORT_CT_OFFDELAY)	0
set PROFILE_4(SHORT_CT_ONDELAY)		3
set PROFILE_4(SHORT_CT_OFF)			0
set PROFILE_4(SHORT_CT_ON)			3
set PROFILE_4(SHORT_COND_VALUE_LO)	50
set PROFILE_4(SHORT_COND_VALUE_HI)	100
set PROFILE_4(SHORT_ONDELAY_TIME)		0
set PROFILE_4(SHORT_ON_TIME)		{120 300}
set PROFILE_4(SHORT_OFFDELAY_TIME)		0
set PROFILE_4(SHORT_ACTION_TYPE)	1
set PROFILE_4(SHORT_JT_OFF)			1
set PROFILE_4(SHORT_JT_ON)			3
set PROFILE_4(SHORT_JT_OFFDELAY)	2
set PROFILE_4(SHORT_JT_ONDELAY)		4
set PROFILE_4(UI_DESCRIPTION)	""
set PROFILE_4(UI_TEMPLATE)		$PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)	4

# hier folgen die eventuellen Subsets

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

	global dev_descr_sender dev_descr_receiver receiver_address
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps      
	upvar $pps_descr    ps_descr

	# hier wird der gewaehlte Kanal der ASA ermittelt, Kanal 1 = Sirene - Kanal 2 = Blitzlicht
	set ch [string range $receiver_address [expr [string first ":" $receiver_address] +1] [string length $receiver_address]]  
	set manner(1) "siren"
	set manner(2) "flashlight"

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
	puts "<script type=\"text/javascript\">getLangInfo('CONDITION_X', '$dev_descr_receiver(TYPE)');</script>"
	set prn 0	
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
	append HTML_PARAMS(separate_$prn) "</textarea></div>"

# hier folgt die Profildarstellung

#1 	Alarm Ein wenn HI
	incr prn
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn\_s}&nbsp;\${actor_$ch}&nbsp;\${description_$prn\_e} \${descrHint}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	set pref 1
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option $manner($ch)
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME ]
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2 	Alarm Ein wenn LO
	incr prn
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn\_s}&nbsp;\${actor_$ch}&nbsp;\${description_$prn\_e} \${descrHint}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	set pref 1
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option $manner($ch)
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME ]
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#3 	Alarm Ein wenn LO oder HI
	incr prn
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn\_s}&nbsp;\${actor_$ch}&nbsp;\${description_$prn\_e} \${descrHint}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	set pref 1
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option $manner($ch)
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME ]
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#4 	Alarm Ein wenn HI und Aus wenn LO
	incr prn
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn\_s}&nbsp;\${actor_$ch}&nbsp;\${description_$prn\_e} \${descrHintMS}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	set pref 1
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option $manner($ch)
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME ]
	append HTML_PARAMS(separate_$prn) "</td></tr>"

  incr pref ;# 3
	append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"


	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"


}

constructor
