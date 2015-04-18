#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]

set PROFILES_MAP(0)	"\${expert}"
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
set PROFILE_1(SHORT_ON_TIME)		{111600 5 6}
set PROFILE_1(SHORT_OFFDELAY_TIME)	0
set PROFILE_1(SHORT_OFF_TIME)		111600
set PROFILE_1(SHORT_ON_TIME_MODE)	0
set PROFILE_1(SHORT_OFF_TIME_MODE)	0
set PROFILE_1(SHORT_ACTION_TYPE)	1
set PROFILE_1(SHORT_JT_OFF)			1
set PROFILE_1(SHORT_JT_ON)			0
set PROFILE_1(SHORT_JT_OFFDELAY)	0
set PROFILE_1(SHORT_JT_ONDELAY)		0 
set PROFILE_1(SHORT_ACT_TYPE)		0
set PROFILE_1(SHORT_ACT_NUM)		1
set PROFILE_1(SHORT_ACT_INTENS)		0
set PROFILE_1(LONG_ACTION_TYPE)		{1 0}
set PROFILE_1(UI_DESCRIPTION)	"Beim Senden des Schaltbefehls ert&ouml;nt der Gong. Ist eine Einschaltverz&ouml;gerungszeit eingestellt, so geschieht es erst nach Ablauf dieser Zeit."
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)	
set PROFILE_1(UI_HINT)	1

set PROFILE_2(SHORT_ACTION_TYPE)	0
set PROFILE_2(UI_DESCRIPTION)		"Der Sensor ist deaktiviert."
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)	
set PROFILE_2(UI_HINT) 2

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	
	global env sender_address receiver_address dev_descr_sender dev_descr_receiver url
	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps      
	upvar $pps_descr    ps_descr
	
	array set dev_descr [xmlrpc $url getParamset [list string $sender_address] MASTER]

	foreach pro [array names PROFILES_MAP] {
		upvar PROFILE_$pro PROFILE_$pro
	}
 		
	set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]
	
#	die Texte der Platzhalter einlesen
	puts "<script type=\"text/javascript\">getLangInfo('CONDITION_X', '$dev_descr_receiver(TYPE)M');</script>"
	set prn 0
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
	append HTML_PARAMS(separate_$prn) "</textarea></div>"
#1
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn} \${descrHint}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	# Signalart
	source [file join $env(DOCUMENT_ROOT) config/easymodes/SIGNAL_CHIMEM/signal_type.tcl]

	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#2
	incr prn 
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "</textarea></div>"
}

constructor
