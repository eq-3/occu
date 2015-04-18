#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_hmw.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/HMW_SWITCH/mapping/INPUT_OUTPUT_0_map.tcl]


set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${switch_on_off}"
set PROFILES_MAP(2)	"\${light_stairway}"
set PROFILES_MAP(3)	"\${switch_on}"
set PROFILES_MAP(4)	"\${switch_off}"

set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)		"Expertenprofil"

# hier folgen die verschiedenen Profile
set PROFILE_1(SHORT_ACTION_TYPE)	1
set PROFILE_1(SHORT_JT_OFF)			0
set PROFILE_1(SHORT_JT_OFFDELAY)	3
set PROFILE_1(SHORT_JT_ON)			2
set PROFILE_1(SHORT_JT_ONDELAY)		1
set PROFILE_1(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_1(SHORT_OFF_TIME)		16383000.000000
set PROFILE_1(SHORT_OFF_TIME_MODE)	1
set PROFILE_1(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_1(SHORT_ON_TIME)		16383000.000000
set PROFILE_1(SHORT_ON_TIME_MODE)	1
set PROFILE_1(SHORT_TOGGLE_USE)		0
set PROFILE_1(UI_DESCRIPTION)	"Bei Bet&auml;tigung des Schaltkontaktes wechselt der Schalter f&uuml;r die gew&uuml;nschte Zeit in den entgegengesetzten Zustand. Ist eine Ein- oder Ausschaltverz&ouml;gerungszeit eingestellt, so wird der Schalter erst nach Ablauf dieser Zeit ein- bzw. ausgeschaltet."
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)	1

set PROFILE_2(SHORT_ACTION_TYPE)	1
set PROFILE_2(SHORT_JT_OFF)			0
set PROFILE_2(SHORT_JT_OFFDELAY)	1
set PROFILE_2(SHORT_JT_ON)			1
set PROFILE_2(SHORT_JT_ONDELAY)		1
set PROFILE_2(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_2(SHORT_OFF_TIME)		16383000.000000
set PROFILE_2(SHORT_OFF_TIME_MODE)	1
set PROFILE_2(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_2(SHORT_ON_TIME)		300.000000
set PROFILE_2(SHORT_ON_TIME_MODE)	1
set PROFILE_2(SHORT_TOGGLE_USE)		0
set PROFILE_2(UI_DESCRIPTION)	"Bei Bet&auml;tigung des Schaltkontaktes schaltet der Schalter das Licht f&uuml;r die gew&uuml;nschte Zeit ein. Wird der Schaltkontakt w&auml;hrend der EIN-Phase nochmal bet&auml;tigt, beginnt die Zeitz&auml;hlung von vorne."
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)	2

set PROFILE_3(SHORT_ACTION_TYPE)	1
set PROFILE_3(SHORT_JT_OFF)			0
set PROFILE_3(SHORT_JT_OFFDELAY)	1
set PROFILE_3(SHORT_JT_ON)			1
set PROFILE_3(SHORT_JT_ONDELAY)		1
set PROFILE_3(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_3(SHORT_OFF_TIME)		16383000.000000
set PROFILE_3(SHORT_OFF_TIME_MODE)	1
set PROFILE_3(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_3(SHORT_ON_TIME)		16383000.000000
set PROFILE_3(SHORT_ON_TIME_MODE)	1
set PROFILE_3(SHORT_TOGGLE_USE)		0
set PROFILE_3(UI_DESCRIPTION)	"Bei Bet&auml;tigung des Schaltkontaktes wird der Schalter f&uuml;r die gew&uuml;nschte Zeit eingeschaltet. Ist eine Einschaltverz&ouml;gerungszeit eingestellt, so wird der Schalter erst nach Ablauf dieser Zeit eingeschaltet."
set PROFILE_3(UI_TEMPLATE)		$PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)	3

set PROFILE_4(SHORT_ACTION_TYPE)	1
set PROFILE_4(SHORT_JT_OFF)			3
set PROFILE_4(SHORT_JT_OFFDELAY)	3
set PROFILE_4(SHORT_JT_ON)			2
set PROFILE_4(SHORT_JT_ONDELAY)		3
set PROFILE_4(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_4(SHORT_OFF_TIME)		16383000.000000
set PROFILE_4(SHORT_OFF_TIME_MODE)	1
set PROFILE_4(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_4(SHORT_ON_TIME)		16383000.000000
set PROFILE_4(SHORT_ON_TIME_MODE)	1
set PROFILE_4(SHORT_TOGGLE_USE)		0
set PROFILE_4(UI_DESCRIPTION)	"Bei Bet&auml;tigung des Schaltkontaktes wird der Schalter f&uuml;r die gew&uuml;nschte Zeit ausgeschaltet. Ist eine Ausschaltverz&ouml;gerungszeit eingestellt, so wird der Schalter erst nach Ablauf dieser Zeit ausgeschaltet."
set PROFILE_4(UI_TEMPLATE)		$PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)	4

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

#	die Texte der Platzhalter einlesen > _sender(TYPE)_0 = der Sender ist als Schalter geschaltet.
	puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)_0', 'HMW_$dev_descr_receiver(TYPE)');</script>"
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

	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME|LONG_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 3
	append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 4
	append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME|LONG_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#2
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option STAIRCASE
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#3
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
	
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME|LONG_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#4
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"
	
	append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME|LONG_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor
