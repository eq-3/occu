#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_alarmactuator.tcl]


set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${alarm_on}"
set PROFILES_MAP(2)	"\${alarm_on_off}"
set PROFILES_MAP(3)	"\${alarm_emergency_off}"


set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)		"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)			"Expertenprofil"


set PROFILE_1(SHORT_CT_OFFDELAY)	0
set PROFILE_1(SHORT_CT_ONDELAY)		0
set PROFILE_1(SHORT_CT_OFF)			0
set PROFILE_1(SHORT_CT_ON)			0
set PROFILE_1(SHORT_COND_VALUE_LO)	50
set PROFILE_1(SHORT_COND_VALUE_HI)	100
set PROFILE_1(SHORT_ON_TIME)		{120 300}
set PROFILE_1(SHORT_ACTION_TYPE)	1
set PROFILE_1(SHORT_JT_OFF)			1
set PROFILE_1(SHORT_JT_ON)			0
set PROFILE_1(SHORT_JT_OFFDELAY)	0
set PROFILE_1(SHORT_JT_ONDELAY)		0
set PROFILE_1(LONG_CT_OFFDELAY)		0
set PROFILE_1(LONG_CT_ONDELAY)		0
set PROFILE_1(LONG_CT_OFF)			0
set PROFILE_1(LONG_CT_ON)			0
set PROFILE_1(LONG_COND_VALUE_LO)	50
set PROFILE_1(LONG_COND_VALUE_HI)	100
set PROFILE_1(LONG_ON_TIME)			{120 300}
set PROFILE_1(LONG_ACTION_TYPE)		1
set PROFILE_1(LONG_JT_OFF)			1
set PROFILE_1(LONG_JT_ON)			0
set PROFILE_1(LONG_JT_OFFDELAY)		0
set PROFILE_1(LONG_JT_ONDELAY)		0
set PROFILE_1(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird der Alarm f&uuml;r die gew&auml;hlte Zeit eingeschaltet.<br />"
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)	1

set PROFILE_2(SHORT_CT_OFFDELAY)	0
set PROFILE_2(SHORT_CT_ONDELAY)		0
set PROFILE_2(SHORT_CT_OFF)			0
set PROFILE_2(SHORT_CT_ON)			0
set PROFILE_2(SHORT_COND_VALUE_LO)	50
set PROFILE_2(SHORT_COND_VALUE_HI)	100
set PROFILE_2(SHORT_ON_TIME)		{120 300}
set PROFILE_2(SHORT_ACTION_TYPE)	1
set PROFILE_2(SHORT_JT_OFF)			1
set PROFILE_2(SHORT_JT_ON)			{3 4}
set PROFILE_2(SHORT_JT_OFFDELAY)	4
set PROFILE_2(SHORT_JT_ONDELAY)		2 
set PROFILE_2(LONG_CT_OFFDELAY)		0
set PROFILE_2(LONG_CT_ONDELAY)		0
set PROFILE_2(LONG_CT_OFF)			0
set PROFILE_2(LONG_CT_ON)			0
set PROFILE_2(LONG_COND_VALUE_LO)	50
set PROFILE_2(LONG_COND_VALUE_HI)	100
set PROFILE_2(LONG_ON_TIME)			{120 300}
set PROFILE_2(LONG_ACTION_TYPE)		1
set PROFILE_2(LONG_JT_OFF)			1
set PROFILE_2(LONG_JT_ON)			{3 4}
set PROFILE_2(LONG_JT_OFFDELAY)		4
set PROFILE_2(LONG_JT_ONDELAY)		2
set PROFILE_2(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird der Alarm je nach aktuellem Zustand ein- oder ausgeschaltet (Togglefunktion)."
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)	
set PROFILE_2(UI_HINT)	2

set PROFILE_3(SHORT_CT_OFFDELAY)	0
set PROFILE_3(SHORT_CT_ONDELAY)		0
set PROFILE_3(SHORT_CT_OFF)			0
set PROFILE_3(SHORT_CT_ON)			0
set PROFILE_3(SHORT_COND_VALUE_LO)	50
set PROFILE_3(SHORT_COND_VALUE_HI)	100
set PROFILE_3(SHORT_ON_TIME)		{120 300}
set PROFILE_3(SHORT_ACTION_TYPE)	1
set PROFILE_3(SHORT_JT_OFF)			4
set PROFILE_3(SHORT_JT_ON)			3
set PROFILE_3(SHORT_JT_OFFDELAY)	4
set PROFILE_3(SHORT_JT_ONDELAY)		4
set PROFILE_3(LONG_CT_OFFDELAY)		0
set PROFILE_3(LONG_CT_ONDELAY)		0
set PROFILE_3(LONG_CT_OFF)			0
set PROFILE_3(LONG_CT_ON)			0
set PROFILE_3(LONG_COND_VALUE_LO)	50
set PROFILE_3(LONG_COND_VALUE_HI)	100
set PROFILE_3(LONG_ON_TIME)			{120 300}
set PROFILE_3(LONG_ACTION_TYPE)		1
set PROFILE_3(LONG_JT_OFF)			4
set PROFILE_3(LONG_JT_ON)			3
set PROFILE_3(LONG_JT_OFFDELAY)		4
set PROFILE_3(LONG_JT_ONDELAY)		4
set PROFILE_3(UI_DESCRIPTION)	"Mit einem kurzen oder langen Tastendruck wird der Alarm sofort ausgeschaltet."
set PROFILE_3(UI_TEMPLATE)		$PROFILE_3(UI_DESCRIPTION)	
set PROFILE_3(UI_HINT)	3

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	

	global dev_descr_sender dev_descr_receiver receiver_address
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps      
	upvar $pps_descr    ps_descr

	# hier wird der gewaehlte Kancal der ASA ermittelt, Kanal 1 = Sirene - Kanal 2 = Blitzlicht
	set ch [string range $receiver_address [expr [string first ":" $receiver_address] +1] [string length $receiver_address]]  
	set manner(1) "siren"
	set manner(2) "flashlight"
	
	foreach pro [array names PROFILES_MAP] {
		upvar PROFILE_$pro PROFILE_$pro
	}
 		
	set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]

#	die Texte der Platzhalter einlesen
	puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
	set prn 0	
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
	append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1 	Alarm Ein	
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn\_s}&nbsp;\${actor_$ch}&nbsp;\${description_$prn\_e}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option $manner($ch)
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME ]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#2	Alarm Ein/Aus
	incr prn 
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn\_s}&nbsp;\${actor_$ch}&nbsp;\${description_$prn\_e}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option $manner($ch)
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME ]
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#3	Alarm NOT-AUS 
	incr prn 
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn\_s}&nbsp;\${actor_$ch}&nbsp;\${description_$prn\_e}"
	append HTML_PARAMS(separate_$prn) "</textarea></div>"
}

constructor
