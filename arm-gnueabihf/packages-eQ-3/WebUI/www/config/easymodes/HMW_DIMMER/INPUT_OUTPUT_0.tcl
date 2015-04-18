#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options_hmw.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/HMW_DIMMER/mapping/INPUT_OUTPUT_0_map.tcl]

set PROFILES_MAP(0)	"\${expert}"
set PROFILES_MAP(1)	"\${dimmer_on_off}"
set PROFILES_MAP(2)	"\${dimmer_on}"
set PROFILES_MAP(3)	"\${dimmer_off}"
set PROFILES_MAP(4)	"\${light_stairway}"
set PROFILES_MAP(5)	"\${sleep_well}"
set PROFILES_MAP(6)	"\${wake_up_light}"
set PROFILES_MAP(7)	"\${blink}"


set PROFILE_0(UI_HINT)	0
set PROFILE_0(UI_DESCRIPTION)	"Expertenprofil"
set PROFILE_0(UI_TEMPLATE)		"Expertenprofil"

# hier folgen die verschiedenen Profile

set PROFILE_1(SHORT_ACTION_TYPE)	1
set PROFILE_1(SHORT_DIM_MAX_LEVEL)	1.000000
set PROFILE_1(SHORT_DIM_MIN_LEVEL)	0.000000
set PROFILE_1(SHORT_DIM_STEP)		0.050000
set PROFILE_1(SHORT_JT_OFF)			0
set PROFILE_1(SHORT_JT_OFFDELAY)	4
set PROFILE_1(SHORT_JT_ON)			3
set PROFILE_1(SHORT_JT_ONDELAY)		1
set PROFILE_1(SHORT_JT_RAMPOFF)		5
set PROFILE_1(SHORT_JT_RAMPON)		2
set PROFILE_1(SHORT_OFFDELAY_STEP)	0.050000
set PROFILE_1(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_1(SHORT_OFF_LEVEL)		0.000000
set PROFILE_1(SHORT_OFF_TIME)		16383000.000000
set PROFILE_1(SHORT_OFF_TIME_MODE)	0
set PROFILE_1(SHORT_ONDELAY_MODE)	0
set PROFILE_1(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_1(SHORT_ON_LEVEL)		1.000000
set PROFILE_1(SHORT_ON_MIN_LEVEL)	0.100000
set PROFILE_1(SHORT_ON_TIME)		16383000.000000
set PROFILE_1(SHORT_ON_TIME_MODE)	0
set PROFILE_1(SHORT_RAMPOFF_TIME)	0.500000
set PROFILE_1(SHORT_RAMPON_TIME)	0.500000
set PROFILE_1(SHORT_RAMP_START_STEP)	0.050000
set PROFILE_1(UI_DESCRIPTION)	"Beim Bet&auml;tigen des Schaltkontaktes wechselt das Licht in den entgegengesetzten Zustand. Bei nochmaligem Bet&auml;tigen w&auml;hrend der Rampenzeit, wird sofort der jeweilige Endwert eingestellt."
set PROFILE_1(UI_TEMPLATE)		$PROFILE_1(UI_DESCRIPTION)
set PROFILE_1(UI_HINT)	1

set PROFILE_2(SHORT_ACTION_TYPE)	1
set PROFILE_2(SHORT_DIM_MAX_LEVEL)	1.000000
set PROFILE_2(SHORT_DIM_MIN_LEVEL)	0.000000
set PROFILE_2(SHORT_DIM_STEP)		0.050000
set PROFILE_2(SHORT_JT_OFF)			0
set PROFILE_2(SHORT_JT_OFFDELAY)	1
set PROFILE_2(SHORT_JT_ON)			1
set PROFILE_2(SHORT_JT_ONDELAY)		1
set PROFILE_2(SHORT_JT_RAMPOFF)		1
set PROFILE_2(SHORT_JT_RAMPON)		2
set PROFILE_2(SHORT_OFFDELAY_STEP)	0.050000
set PROFILE_2(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_2(SHORT_OFF_LEVEL)		0.000000
set PROFILE_2(SHORT_OFF_TIME)		16383000.000000
set PROFILE_2(SHORT_OFF_TIME_MODE)	0
set PROFILE_2(SHORT_ONDELAY_MODE)	0
set PROFILE_2(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_2(SHORT_ON_LEVEL)		1.000000
set PROFILE_2(SHORT_ON_MIN_LEVEL)	0.100000
set PROFILE_2(SHORT_ON_TIME)		16383000.000000
set PROFILE_2(SHORT_ON_TIME_MODE)	0
set PROFILE_2(SHORT_RAMPOFF_TIME)	0.500000
set PROFILE_2(SHORT_RAMPON_TIME)	0.500000
set PROFILE_2(SHORT_RAMP_START_STEP)	0.050000
set PROFILE_2(UI_DESCRIPTION)	"Beim Bet&auml;tigen des Schaltkontaktes wird das Licht f&uuml;r die eingestellte Zeit auf die gew&uuml;nschte Helligkeit gestellt."
append PROFILE_2(UI_DESCRIPTION) "&nbsp;Bei nochmaligem Bet&auml;tigen w&auml;hrend der Rampenzeit, wird sofort der jeweilige Endwert eingestellt"
set PROFILE_2(UI_TEMPLATE)		$PROFILE_2(UI_DESCRIPTION)
set PROFILE_2(UI_HINT)	2

set PROFILE_3(SHORT_ACTION_TYPE)	1
set PROFILE_3(SHORT_DIM_MAX_LEVEL)	1.000000
set PROFILE_3(SHORT_DIM_MIN_LEVEL)	0.000000
set PROFILE_3(SHORT_DIM_STEP)		0.050000
set PROFILE_3(SHORT_JT_OFF)			3
set PROFILE_3(SHORT_JT_OFFDELAY)	4
set PROFILE_3(SHORT_JT_ON)			3
set PROFILE_3(SHORT_JT_ONDELAY)		3
set PROFILE_3(SHORT_JT_RAMPOFF)		5
set PROFILE_3(SHORT_JT_RAMPON)		3
set PROFILE_3(SHORT_OFFDELAY_STEP)	0.050000
set PROFILE_3(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_3(SHORT_OFF_LEVEL)		0.000000
set PROFILE_3(SHORT_OFF_TIME)		16383000.000000
set PROFILE_3(SHORT_OFF_TIME_MODE)	0
set PROFILE_3(SHORT_ONDELAY_MODE)	0
set PROFILE_3(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_3(SHORT_ON_LEVEL)		1.000000
set PROFILE_3(SHORT_ON_MIN_LEVEL)	0.100000
set PROFILE_3(SHORT_ON_TIME)		16383000.000000
set PROFILE_3(SHORT_ON_TIME_MODE)	0
set PROFILE_3(SHORT_RAMPOFF_TIME)	0.500000
set PROFILE_3(SHORT_RAMPON_TIME)	0.500000
set PROFILE_3(SHORT_RAMP_START_STEP)	0.050000
set PROFILE_3(UI_DESCRIPTION)	"Bei Bet&auml;tigung des Schaltkontaktes wird das Licht nach der eingestellten Verz&ouml;gerungszeit ausgeschaltet."
append PROFILE_3(UI_DESCRIPTION) "&nbsp;Bei nochmaligem Bet&auml;tigen w&auml;hrend der Rampenzeit, wird das Licht sofort ausgeschaltet."
set PROFILE_3(UI_TEMPLATE)		$PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)	3

set PROFILE_4(SHORT_ACTION_TYPE)	1
set PROFILE_4(SHORT_DIM_MAX_LEVEL)	1.000000
set PROFILE_4(SHORT_DIM_MIN_LEVEL)	0.000000
set PROFILE_4(SHORT_DIM_STEP)		0.050000
set PROFILE_4(SHORT_JT_OFF)			0
set PROFILE_4(SHORT_JT_OFFDELAY)	1
set PROFILE_4(SHORT_JT_ON)			1
set PROFILE_4(SHORT_JT_ONDELAY)		1
set PROFILE_4(SHORT_JT_RAMPOFF)		1
set PROFILE_4(SHORT_JT_RAMPON)		6
set PROFILE_4(SHORT_OFFDELAY_STEP)	0.050000
set PROFILE_4(SHORT_OFFDELAY_TIME)	20.000000
set PROFILE_4(SHORT_OFF_LEVEL)		0.000000
set PROFILE_4(SHORT_OFF_TIME)		16383000.000000
set PROFILE_4(SHORT_OFF_TIME_MODE)	0
set PROFILE_4(SHORT_ONDELAY_MODE)	0
set PROFILE_4(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_4(SHORT_ON_LEVEL)		0.900000
set PROFILE_4(SHORT_ON_MIN_LEVEL)	0.100000
set PROFILE_4(SHORT_ON_TIME)		120.000000
set PROFILE_4(SHORT_ON_TIME_MODE)	1
set PROFILE_4(SHORT_RAMPOFF_TIME)	20.000000
set PROFILE_4(SHORT_RAMPON_TIME)	0.500000
set PROFILE_4(SHORT_RAMP_START_STEP)	0.050000
set PROFILE_4(UI_DESCRIPTION)	"Bei Bet&auml;tigung des Schaltkontaktes wird das Licht f&uuml;r die eingestellte Zeit eingeschaltet. In der Ausschaltverz&ouml;gerung wird der Pegel zur Vorwarnung leicht abgesenkt, um anschlie&szlig;end langsam bis auf &quot;Aus&quot; herunter zu dimmen."
set PROFILE_4(UI_TEMPLATE)		$PROFILE_4(UI_DESCRIPTION)
set PROFILE_4(UI_HINT)	4

set PROFILE_5(SHORT_ACTION_TYPE)	1
set PROFILE_5(SHORT_DIM_MAX_LEVEL)	1.000000
set PROFILE_5(SHORT_DIM_MIN_LEVEL)	0.000000
set PROFILE_5(SHORT_DIM_STEP)		0.050000
set PROFILE_5(SHORT_JT_OFF)			0
set PROFILE_5(SHORT_JT_OFFDELAY)	1
set PROFILE_5(SHORT_JT_ON)			1
set PROFILE_5(SHORT_JT_ONDELAY)		1
set PROFILE_5(SHORT_JT_RAMPOFF)		1
set PROFILE_5(SHORT_JT_RAMPON)		2
set PROFILE_5(SHORT_OFFDELAY_STEP)	0.000000
set PROFILE_5(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_5(SHORT_OFF_LEVEL)		0.000000
set PROFILE_5(SHORT_OFF_TIME)		16383000.000000
set PROFILE_5(SHORT_OFF_TIME_MODE)	0
set PROFILE_5(SHORT_ONDELAY_MODE)	0
set PROFILE_5(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_5(SHORT_ON_LEVEL)		0.500000
set PROFILE_5(SHORT_ON_MIN_LEVEL)	0.100000
set PROFILE_5(SHORT_ON_TIME)		1800.000000
set PROFILE_5(SHORT_ON_TIME_MODE)	0
set PROFILE_5(SHORT_RAMPOFF_TIME)	1800.000000
set PROFILE_5(SHORT_RAMPON_TIME)	0.500000
set PROFILE_5(SHORT_RAMP_START_STEP)	0.000000
set PROFILE_5(UI_DESCRIPTION)	"Bei Bet&auml;tigung des Schaltkontaktes wird das Licht auf die eingestellte Helligkeit geschaltet und nach der eingestellten Zeit langsam auf &quot;Aus&quot; herunter gedimmt."
set PROFILE_5(UI_TEMPLATE)		$PROFILE_5(UI_DESCRIPTION)
set PROFILE_5(UI_HINT)	5

set PROFILE_6(SHORT_ACTION_TYPE)	1
set PROFILE_6(SHORT_DIM_MAX_LEVEL)	1.000000
set PROFILE_6(SHORT_DIM_MIN_LEVEL)	0.000000
set PROFILE_6(SHORT_DIM_STEP)		0.050000
set PROFILE_6(SHORT_JT_OFF)			0
set PROFILE_6(SHORT_JT_OFFDELAY)	4
set PROFILE_6(SHORT_JT_ON)			3
set PROFILE_6(SHORT_JT_ONDELAY)		1
set PROFILE_6(SHORT_JT_RAMPOFF)		5
set PROFILE_6(SHORT_JT_RAMPON)		2
set PROFILE_6(SHORT_OFFDELAY_STEP)	0.050000
set PROFILE_6(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_6(SHORT_OFF_LEVEL)		0.000000
set PROFILE_6(SHORT_OFF_TIME)		16383000.000000
set PROFILE_6(SHORT_OFF_TIME_MODE)	0
set PROFILE_6(SHORT_ONDELAY_MODE)	0
set PROFILE_6(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_6(SHORT_ON_LEVEL)		0.800000
set PROFILE_6(SHORT_ON_MIN_LEVEL)	0.100000
set PROFILE_6(SHORT_ON_TIME)		16383000.000000
set PROFILE_6(SHORT_ON_TIME_MODE)	0
set PROFILE_6(SHORT_RAMPOFF_TIME)	0.500000
set PROFILE_6(SHORT_RAMPON_TIME)	60.000000
set PROFILE_6(SHORT_RAMP_START_STEP)	0.050000
set PROFILE_6(UI_DESCRIPTION)	"Bei Bet&auml;tigung des Schaltkontaktes wird das Licht langsam auf die eingestellte Helligkeit hoch gedimmt."
set PROFILE_6(UI_TEMPLATE)		$PROFILE_6(UI_DESCRIPTION)
set PROFILE_6(UI_HINT)	6

set PROFILE_7(SHORT_ACTION_TYPE)	1
set PROFILE_7(SHORT_DIM_MAX_LEVEL)	1.000000
set PROFILE_7(SHORT_DIM_MIN_LEVEL)	0.000000
set PROFILE_7(SHORT_DIM_STEP)		0.050000
set PROFILE_7(SHORT_JT_OFF)			0
set PROFILE_7(SHORT_JT_OFFDELAY)	0
set PROFILE_7(SHORT_JT_ON)			3
set PROFILE_7(SHORT_JT_ONDELAY)		3
set PROFILE_7(SHORT_JT_RAMPOFF)		0
set PROFILE_7(SHORT_JT_RAMPON)		3
set PROFILE_7(SHORT_OFFDELAY_STEP)	0.050000
set PROFILE_7(SHORT_OFFDELAY_TIME)	0.000000
set PROFILE_7(SHORT_OFF_LEVEL)		0.000000
set PROFILE_7(SHORT_OFF_TIME)		1.000000
set PROFILE_7(SHORT_OFF_TIME_MODE)	0
set PROFILE_7(SHORT_ONDELAY_MODE)	0
set PROFILE_7(SHORT_ONDELAY_TIME)	0.000000
set PROFILE_7(SHORT_ON_LEVEL)		1.000000
set PROFILE_7(SHORT_ON_MIN_LEVEL)	0.100000
set PROFILE_7(SHORT_ON_TIME)		1.000000
set PROFILE_7(SHORT_ON_TIME_MODE)	0
set PROFILE_7(SHORT_RAMPOFF_TIME)	0.000000
set PROFILE_7(SHORT_RAMPON_TIME)	0.000000
set PROFILE_7(SHORT_RAMP_START_STEP)	0.000000
set PROFILE_7(UI_DESCRIPTION)	"Das Licht wechselt im eingestellten Takt endlos zwischen den beiden Helligkeitswerten."
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

#	die Texte der Platzhalter einlesen > _sender(TYPE)_x = 0 der Sender ist als Schalter geschaltet, 1 der Sender ist als Taster geschaltet.
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

	append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME|LONG_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr LONG_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPON_TIME}</td><td>"
	option RAMPTIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 3
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 4
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
	option DIM_ONLEVEL
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
	EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 5
	append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME|LONG_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr LONG_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
		
	incr pref ;# 6
	append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPOFF_TIME}</td><td>"
	option RAMPTIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPOFF_TIME|LONG_RAMPOFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPOFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPOFF_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
		
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#2
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${ONDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ONDELAY_TIME|LONG_ONDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ONDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr LONG_ONDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPON_TIME}</td><td>"
	option RAMPTIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 3
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 4
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
	option DIM_ONLEVEL
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
	EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#3
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME|LONG_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr LONG_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPOFF_TIME}</td><td>"
	option RAMPTIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPOFF_TIME|LONG_RAMPOFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPOFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPOFF_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#4	
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPON_TIME}</td><td>"
	option RAMPTIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 3
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
	option DIM_ONLEVEL
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
	EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 4
	append HTML_PARAMS(separate_$prn) "<tr><td>\${OFFDELAY_TIME}</td><td>"
	option DELAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFFDELAY_TIME|LONG_OFFDELAY_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFFDELAY_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr LONG_OFFDELAY_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
		
	incr pref ;# 5
	append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPOFF_TIME}</td><td>"
	option RAMPTIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPOFF_TIME|LONG_RAMPOFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPOFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPOFF_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#5
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
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
	option DIM_ONLEVEL
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
	EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 3
	append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPOFF_TIME}</td><td>"
	option RAMPTIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_RAMPOFF_TIME|LONG_RAMPOFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPOFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPOFF_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#6
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${RAMPON_TIME}</td><td>"
	option RAMPTIME
	append HTML_PARAMS(separate_$prn) [get_ComboBox options LONG_RAMPON_TIME|SHORT_RAMPON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_RAMPON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_RAMPON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option LENGTH_OF_STAY
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 3
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
	option DIM_ONLEVEL
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
	EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
#7
	incr prn
	set pref 1
	if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
	append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
	append HTML_PARAMS(separate_$prn) "\${description_$prn}"
	append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_TIME}</td><td>"
	option BLINK
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_TIME|LONG_ON_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_ON_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 2
	append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
	option DIM_ONLEVEL
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL|LONG_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
	EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
	append HTML_PARAMS(separate_$prn) "</td></tr>"

	incr pref ;# 3
	append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_TIME}</td><td>"
	option BLINK
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_TIME|LONG_OFF_TIME separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_TIME "onchange=\"ActivateFreeTime(\$('${special_input_id}_profiles'),$pref);\""]
	EnterTime_h_m_s $prn $pref ${special_input_id} ps_descr SHORT_OFF_TIME
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	incr pref ;# 4
	append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
	option DIM_OFFLEVEL
	append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL|LONG_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
	EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_LEVEL
	append HTML_PARAMS(separate_$prn) "</td></tr>"
	
	append HTML_PARAMS(separate_$prn) "</table></textarea></div>"
}

constructor
