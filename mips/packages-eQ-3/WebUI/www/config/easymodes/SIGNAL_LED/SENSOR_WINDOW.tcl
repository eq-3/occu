#/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

set PROFILES_MAP(0) "\${expert}"
set PROFILES_MAP(1)	"\${signal_led_chime_active}"
set PROFILES_MAP(2) "\${signal_led_chime_non_active}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)		"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)			"Expertenprofil"

set PROFILE_1(SHORT_CT_OFFDELAY)	0
set PROFILE_1(SHORT_CT_ONDELAY)		0
set PROFILE_1(SHORT_CT_OFF)			0
set PROFILE_1(SHORT_CT_ON)			0
set PROFILE_1(SHORT_COND_VALUE_LO)	50 
set PROFILE_1(SHORT_COND_VALUE_HI)	100
set PROFILE_1(SHORT_ONDELAY_TIME)	0
set PROFILE_1(SHORT_ON_TIME)		{111600 6}
set PROFILE_1(SHORT_OFFDELAY_TIME)	0
set PROFILE_1(SHORT_OFF_TIME)		111600
set PROFILE_1(SHORT_ON_TIME_MODE)	0
set PROFILE_1(SHORT_OFF_TIME_MODE)	0
set PROFILE_1(SHORT_ACTION_TYPE)	1
set PROFILE_1(SHORT_JT_OFF)			1
set PROFILE_1(SHORT_JT_ON)			0
set PROFILE_1(SHORT_JT_OFFDELAY)	0
set PROFILE_1(SHORT_JT_ONDELAY)		0
set PROFILE_1(SHORT_ACT_TYPE)		2
set PROFILE_1(SHORT_ACT_NUM)		{6 7}
set PROFILE_1(LONG_ACTION_TYPE)		{0 1}
set PROFILE_1(UI_DESCRIPTION)	""
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)	
set PROFILE_1(UI_HINT)	1

set PROFILE_2(SHORT_ACT_TYPE)		0
set PROFILE_2(SHORT_ACT_NUM)		0
set PROFILE_2(LONG_ACT_TYPE)		0
set PROFILE_2(LONG_ACT_NUM)			0
set PROFILE_2(UI_DESCRIPTION)		"descr"
set PROFILE_2(UI_TEMPLATE)			"templ"
set PROFILE_2(UI_HINT) 2

#set SUBSET_1(NAME)					"Offen-Ein/Zu-Aus"
set SUBSET_1(NAME)					"\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)	1
set SUBSET_1(SHORT_CT_OFF)			0
set SUBSET_1(SHORT_CT_OFFDELAY)		0
set SUBSET_1(SHORT_CT_ON)			2
set SUBSET_1(SHORT_CT_ONDELAY)		2

#set SUBSET_2(NAME)					""Offen-Aus/Zu-Ein""
set SUBSET_2(NAME)					"\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)	2
set SUBSET_2(SHORT_CT_OFF)			2
set SUBSET_2(SHORT_CT_OFFDELAY)		2
set SUBSET_2(SHORT_CT_ON)			0
set SUBSET_2(SHORT_CT_ONDELAY)		0

#set SUBSET_3(NAME)					""Offen-Ein"
set SUBSET_3(NAME)					"\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)	3
set SUBSET_3(SHORT_CT_OFF)			0
set SUBSET_3(SHORT_CT_OFFDELAY)		0
set SUBSET_3(SHORT_CT_ON)			0
set SUBSET_3(SHORT_CT_ONDELAY)		0
set SUBSET_3(SHORT_JT_OFF)			1
set SUBSET_3(SHORT_JT_ON)			0
set SUBSET_3(SHORT_JT_OFFDELAY)		0
set SUBSET_3(SHORT_JT_ONDELAY)		0

#set SUBSET_4(NAME)					""Zu-Ein"
set SUBSET_4(NAME)					"\${subset_4}"
set SUBSET_4(SUBSET_OPTION_VALUE)	4
set SUBSET_4(SHORT_CT_OFF)			2
set SUBSET_4(SHORT_CT_OFFDELAY)		2
set SUBSET_4(SHORT_CT_ON)			2
set SUBSET_4(SHORT_CT_ONDELAY)		2
set SUBSET_4(SHORT_JT_OFF)			1
set SUBSET_4(SHORT_JT_ON)			0
set SUBSET_4(SHORT_JT_OFFDELAY)		1
set SUBSET_4(SHORT_JT_ONDELAY)		1

#set SUBSET_5(NAME)					"Ändern"
set SUBSET_5(NAME)					"\${subset_5}"
set SUBSET_5(SUBSET_OPTION_VALUE)	5
set SUBSET_5(SHORT_CT_OFF)			5
set SUBSET_5(SHORT_CT_OFFDELAY)		5
set SUBSET_5(SHORT_CT_ON)			5
set SUBSET_5(SHORT_CT_ONDELAY)		5
set SUBSET_5(SHORT_JT_OFF)			1
set SUBSET_5(SHORT_JT_ON)			0
set SUBSET_5(SHORT_JT_OFFDELAY)		1
set SUBSET_5(SHORT_JT_ONDELAY)		1

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	
	global env dev_descr_sender dev_descr_receiver  
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

	append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_DIR}</td><td>"
	append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2 SUBSET_3 SUBSET_4 SUBSET_5} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	# Signalart
	source [file join $env(DOCUMENT_ROOT) config/easymodes/SIGNAL_LED/signal_type.tcl]

	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#2
	incr prn 
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "</textarea></div>"
}
constructor
